# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [unreleased]
### Added
### Changed
### Deprecated
### Removed

## [v1.0.0-beta.1] - 2020-03-17
### Added
- TelemachusClient: Added ability to choose LogLevel upon initialization
- TelemachusData:   added Environment-Data
- TelemachusData:   added IP 
- TelemachusData:   added TelemachusVersion
### Changed
- Logger: renamed to LogHelper
- LogHelper: implemented Logging library
### Deprecated
### Removed

## [v1.0.0-alpha.4] - 2020-03-16
### Added
- Added Ressource:       Ressource List
- Added Ressource:       Electric Charge
- Added Ressource:       Intake Air
- Added Sensor Data:    Temperature Sensor Data
- Added Sensor Data:    Pressure Sensor Data
- Added Sensor Data:    Acceleration Sensor Data
- Added Sensor Data:    Gravity Sensor Data
### Changed

### Deprecated
### Removed

## [v1.0.0-alpha.3] - 2020-03-15
### Added
### Changed

- TelemachusData: remaining Fuel is now 0 when max and current are 0
- TelemachusClient: sendCommand, made Param optional and replaced Key with string representation (Erro Fix)
- API Keys: Changed Key of rcs and sas value 
- TelemachusDelegate: added timeout, error to connect method
- SocketDelegate: added timeout, error to connect method

### Deprecated
### Removed

## [v1.0.0-alpha.2] - 2020-03-13
### Added
TelemachusData & APIKeys:  
- throttle
- SAS
- RCS
- Target (name, type, distance, velocity, relative velocity)
### Changed
### Deprecated
### Removed

## [v1.0.0-alpha.1] - 2020-03-13






