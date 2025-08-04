#!/usr/bin/env ruby

require 'net/http'
require 'rexml/document'
require 'open-uri'

# Fetch the latest release from GitHub atom feed
def get_latest_release
  uri = URI('https://github.com/MobilityData/gtfs-validator/releases.atom')
  response = Net::HTTP.get_response(uri)
  
  if response.code != '200'
    puts "Error: Failed to fetch releases feed (HTTP #{response.code})"
    exit 1
  end
  
  doc = REXML::Document.new(response.body)
  latest_entry = doc.elements['feed/entry']
  
  if latest_entry.nil?
    puts "Error: No releases found in feed"
    exit 1
  end
  
  title = latest_entry.elements['title'].text
  puts "Latest release: #{title}"
  title
end

# Calculate SHA256 checksum for a URL
def calculate_checksum(url)
  puts "Downloading #{url}..."
  checksum = nil
  
  begin
    URI.open(url) do |file|
      require 'digest'
      checksum = Digest::SHA256.hexdigest(file.read)
    end
  rescue OpenURI::HTTPError => e
    puts "Error: Failed to download #{url} (HTTP #{e.io.status[0]})"
    exit 1
  rescue => e
    puts "Error: Failed to download #{url} (#{e.message})"
    exit 1
  end
  
  checksum
end

# Main script
version = ARGV[0] || get_latest_release
version_without_v = version.sub(/^v/, '')

puts "Calculating SHA256 checksums for GTFS Validator #{version}..."
puts ""

# CLI JAR file
cli_url = "https://github.com/MobilityData/gtfs-validator/releases/download/#{version}/gtfs-validator-#{version_without_v}-cli.jar"
cli_checksum = calculate_checksum(cli_url)
puts "CLI JAR file:"
puts "#{cli_checksum}  -"

puts ""

# Mac GUI DMG file
dmg_url = "https://github.com/MobilityData/gtfs-validator/releases/download/#{version}/Installer.macos.dmg"
dmg_checksum = calculate_checksum(dmg_url)
puts "Mac GUI DMG file:"
puts "#{dmg_checksum}  -"

puts ""
puts "Copy the checksums above and update the formula files."
puts ""
puts "Usage: #{$0} [version]"
puts "  version: Release version (default: latest from GitHub)"
puts "  Example: #{$0} v7.2.0" 