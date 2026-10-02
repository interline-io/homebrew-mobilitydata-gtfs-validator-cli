class MobilitydataGtfsValidatorCli < Formula
  desc "Validates GTFS feeds"
  homepage "https://github.com/MobilityData/gtfs-validator"
  url "https://github.com/MobilityData/gtfs-validator/releases/download/v8.0.1/gtfs-validator-8.0.1-cli.jar"
  sha256 "19293ddd9b6f954f216d4f12054bd8a3232921751c4484339e339764a91000e2"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "openjdk"

  def install
    libexec.install "gtfs-validator-#{version}-cli.jar"
    bin.write_jar_script libexec/"gtfs-validator-#{version}-cli.jar", "mobilitydata-gtfs-validator"
  end

  test do
    (testpath/"feed/agency.txt").write <<~CSV
      agency_name,agency_url,agency_timezone
      Test,https://example.com,America/Los_Angeles
    CSV
    output = shell_output("#{bin}/mobilitydata-gtfs-validator -i feed --stdout --skip_validator_update")
    assert_equal version.to_s, JSON.parse(output)["summary"]["validatorVersion"]
  end
end
