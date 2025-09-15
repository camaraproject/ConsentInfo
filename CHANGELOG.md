# Changelog ConsentInfo

## Table of contents

- **[r1.2](#r12)**
- **[r1.1](#r11)**

**Please be aware that the project will have frequent updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until it has been released. For example, changes may be reverted before a release is published. For the best results, use the latest published release.**

The below sections record the changes for each API version in each release as follows:

* for an alpha release, the delta with respect to the previous release
* for the first release-candidate, all changes since the last public release
* for subsequent release-candidate(s), only the delta to the previous release-candidate
* for a public release, the consolidated changes since the previous public release

<!--Repeat the below release section (header 1 and subsections) at the top of this file for each new (pre-)release-->

# r1.2

## Release Notes

This release contains the definition and documentation of
* consent-info v0.1.0

The API definition(s) are based on
* Commonalities r3.3
* Identity and Consent Management r3.3

## consent-info v0.1.0

**consent-info v0.1.0 is the first public version of this API.**

Version 0.1.0 provides the initial API definition and documentation for the consent-info API, which is part of the Identity and Consent Management (ICM) Working Group. 

- This API version provide the API consumer with the ability to:

  - **Check the validity of data processing**: The API returns `statusValidForProcessing`, a boolean flag that indicates whether the requested data processing is currently permitted (`true`) or not (`false`).
  - **Understand why processing is not allowed**: If data processing is not permitted, the response includes a `statusReason` field to explain why.
  - **Retrieve a Capture URL (if requested)**: If the status is not valid because user action is required, and the API Consumer sets `requestCaptureUrl` to `true`, the API will return a `captureUrl` field that can be presented to the user. This URL directs them to the API Provider's secure consent capture channel, where they can provide or renew their consent.
  
- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/ConsentInfo/r1.2/code/API_definitions/consent-info.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/ConsentInfo/r1.2/code/API_definitions/consent-info.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/ConsentInfo/blob/r1.2/code/API_definitions/consent-info.yaml)

### Added

- Initial consent-info API definition and documentation

### Changed

- N/A

### Fixed

- N/A

### Removed

- N/A

**Full Changelog**: https://github.com/camaraproject/ConsentInfo/commits/r1.2

# r1.1

## Release Notes

This release contains the definition and documentation of
* consent-info v0.1.0-rc.1

The API definition(s) are based on
* Commonalities r3.2
* Identity and Consent Management r3.2

## consent-info v0.1.0-rc.1

**consent-info v0.1.0-rc.1 is is the first release candidate of the version 0.1.0**

Version 0.1.0 provides the initial API definition and documentation for the consent-info API, which is part of the Identity and Consent Management (ICM) Working Group. 

- This API version provide the API consumer with the ability to:

  - **Check the validity of data processing**: The API returns `statusValidForProcessing`, a boolean flag that indicates whether the requested data processing is currently permitted (`true`) or not (`false`).
  - **Understand why processing is not allowed**: If data processing is not permitted, the response includes a `statusReason` field to explain why.
  - **Retrieve a Capture URL (if requested)**: If the status is not valid because user action is required, and the API Consumer sets `requestCaptureUrl` to `true`, the API will return a `captureUrl` field that can be presented to the user. This URL directs them to the API Provider's secure consent capture channel, where they can provide or renew their consent.
  
- API definition **with inline documentation**:
  - [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/ConsentInfo/r1.1/code/API_definitions/consent-info.yaml&nocors)
  - [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/ConsentInfo/r1.1/code/API_definitions/consent-info.yaml)
  - OpenAPI [YAML spec file](https://github.com/camaraproject/ConsentInfo/blob/r1.1/code/API_definitions/consent-info.yaml)

### Added

- Initial consent-info API definition and documentation

### Changed

- N/A

### Fixed

- N/A

### Removed

- N/A

**Full Changelog**: https://github.com/camaraproject/ConsentInfo/commits/r1.1