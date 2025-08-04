# MobilityData GTFS Validator CLI - Homebrew Formula

This repository contains a Homebrew formula for the [MobilityData GTFS Validator](https://github.com/MobilityData/gtfs-validator) CLI.

**Installation:**
```bash
brew install interline-io/mobilitydata-gtfs-validator-cli/mobilitydata-gtfs-validator-cli
```

**Usage:**
```bash
mobilitydata-gtfs-validator --help
```

For detailed usage examples and all available options, see the [GTFS Validator usage documentation](https://github.com/MobilityData/gtfs-validator/blob/master/docs/USAGE.md).

## Requirements

- macOS
- Homebrew
- Java 17 or higher (any distribution)

> [!TIP]
> For managing multiple Java versions, consider installing [jenv](https://github.com/jenv/jenv)

> [!TIP]
> To instead use a desktop GUI package, download it directly from the [MobilityData GTFS Validator releases page](https://github.com/MobilityData/gtfs-validator/releases).

## For Maintainers

To update this formula:

```bash
./utils/calculate-checksums.rb
```

Then update the `url` and `sha256` values in `Formula/mobilitydata-gtfs-validator-cli.rb`. 