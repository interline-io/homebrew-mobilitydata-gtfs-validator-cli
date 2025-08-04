class MobilitydataGtfsValidatorCli < Formula
  desc "MobilityData GTFS Validator CLI - Validates GTFS feeds"
  homepage "https://github.com/MobilityData/gtfs-validator"
  url "https://github.com/MobilityData/gtfs-validator/releases/download/v7.1.0/gtfs-validator-7.1.0-cli.jar"
  sha256 "52c2785089aaf04e7ba1bb11b2db215692e2622eb0e196b823c194d156d9b58c"
  license "Apache-2.0"
  head "https://github.com/MobilityData/gtfs-validator.git"

  depends_on "openjdk@17" => :optional

  def install
    libexec.install "gtfs-validator-7.1.0-cli.jar"
    bin.write_jar_script libexec/"gtfs-validator-7.1.0-cli.jar", "mobilitydata-gtfs-validator"
  end

  def caveats
    <<~EOS
      This formula requires Java 17 or higher to run.
      
      If you don't have Java installed, you can install it with:
        brew install openjdk@17
      
      Or use any other Java 17+ distribution like:
        - Eclipse Adoptium (Temurin)
        - Amazon Corretto
        - Azul Zulu
        - Microsoft Build of OpenJDK
        - Oracle JDK
      
      For managing multiple Java versions, we recommend jenv:
        brew install jenv
        echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
        echo 'eval "$(jenv init -)"' >> ~/.zshrc
        jenv add $(/usr/libexec/java_home -v 17)
    EOS
  end

  test do
    system "#{bin}/mobilitydata-gtfs-validator", "--help"
  end
end 