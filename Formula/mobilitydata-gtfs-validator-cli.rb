class MobilitydataGtfsValidatorCli < Formula
  desc "Validates GTFS feeds"
  homepage "https://github.com/MobilityData/gtfs-validator"
  url "https://github.com/MobilityData/gtfs-validator/releases/download/v8.0.1/gtfs-validator-8.0.1-cli.jar"
  sha256 "19293ddd9b6f954f216d4f12054bd8a3232921751c4484339e339764a91000e2"
  license "Apache-2.0"
  head "https://github.com/MobilityData/gtfs-validator.git"

  depends_on "openjdk@17" => :optional

  def install
    libexec.install "gtfs-validator-8.0.1-cli.jar"
    bin.write_jar_script libexec/"gtfs-validator-8.0.1-cli.jar", "mobilitydata-gtfs-validator"
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
