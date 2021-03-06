# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2019-10-22
### Added 
- Support for parameters for ingress Helm deployment
- Support for EKS logs

### Changed
- Updated Kentrikos EKS module to 4.0.0

### BC
- Variable type changed for `map_users` and `map_roles` to align with upstream eks module

## [1.0.0] - 2019-07-30
### Changed
- Required terraform version updated to `>= 0.12`
- Updated Kentrikos EKS module to 3.0.0

## [0.5.0] - 2019-07-04
### Added 
- Maps for roles, users and account
- Default roles to assume for EKS
- Flag enable_default_roles to enable creation of default role; default false 

## [0.4.3] - 2019-05-22
### Added
- Disable automatic ingress deployment

## [0.4.2] - 2019-05-08
### Added
- Added outputs from eks module

## [0.4.1] - 2019-04-16
### Fixed
- Solved gp2 storage creation in EKS module
  
## [0.4.0] - 2019-04-09
### Changed
- Changed minor version due to dependency change in upward and downward repo.

## [0.3.1] - 2019-03-20
### Changed
- Renamed new k8s variables to be consistent with other modules

## [0.3.0] - 2019-03-06
### Enhancements
- Updated common tags to consistent naming
- Cluster platform is EKS

## [0.2.0] - 2019-02-25
### Changed
- Cluster name contain region
- ECR cluster name contain region 

## [0.1.0] - 2019-02-05
### Added
- Pining versions
- This CHANGELOG file


