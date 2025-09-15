<a href="https://github.com/camaraproject/ConsentInfo/commits/" title="Last Commit"><img src="https://img.shields.io/github/last-commit/camaraproject/ConsentInfo?style=plastic"></a>
<a href="https://github.com/camaraproject/ConsentInfo/issues" title="Open Issues"><img src="https://img.shields.io/github/issues/camaraproject/ConsentInfo?style=plastic"></a>
<a href="https://github.com/camaraproject/ConsentInfo/pulls" title="Open Pull Requests"><img src="https://img.shields.io/github/issues-pr/camaraproject/ConsentInfo?style=plastic"></a>
<a href="https://github.com/camaraproject/ConsentInfo/graphs/contributors" title="Contributors"><img src="https://img.shields.io/github/contributors/camaraproject/ConsentInfo?style=plastic"></a>
<a href="https://github.com/camaraproject/ConsentInfo" title="Repo Size"><img src="https://img.shields.io/github/repo-size/camaraproject/ConsentInfo?style=plastic"></a>
<a href="https://github.com/camaraproject/ConsentInfo/blob/main/LICENSE" title="License"><img src="https://img.shields.io/badge/License-Apache%202.0-green.svg?style=plastic"></a>
<a href="https://github.com/camaraproject/ConsentInfo/releases/latest" title="Latest Release"><img src="https://img.shields.io/github/release/camaraproject/ConsentInfo?style=plastic"></a>
<a href="https://github.com/camaraproject/Governance/blob/main/ProjectStructureAndRoles.md" title="Sandbox API Repository"><img src="https://img.shields.io/badge/Sandbox%20API%20Repository-yellow?style=plastic"></a>

# ConsentInfo

Sandbox API Repository to describe, develop, document, and test the ConsentInfo API(s) within the Working Group [IdentityAndConsentManagement](https://lf-camaraproject.atlassian.net/wiki/x/ZzDe)

* API Repository [Wiki page](https://lf-camaraproject.atlassian.net/wiki/x/NICeBQ)


## Scope

* API(s) “ConsentInfo”
* The API(s) provide(s) the API consumer with the ability to:  
  * **Check the validity of data processing**: The API returns `statusValidForProcessing`, a boolean flag that indicates whether the requested data processing is currently permitted (`true`) or not (`false`).
  * **Understand why processing is not allowed**: If data processing is not permitted, the response includes a `statusReason` field to explain why.
  * **Retrieve a Capture URL (if requested)**: If the status is not valid because user action is required, and the API Consumer sets `requestCaptureUrl` to `true`, the API will return a `captureUrl` field that can be presented to the User. This URL directs them to the API Provider's secure Consent capture channel, where they can provide or renew their Consent.
  
    Importantly, this API does NOT delegate Consent capture to the API Consumer but rather empowers the API Consumer to present the API Provider's Consent capture URL at the most opportune time and place. The actual Consent capture occurs within the API Provider's secure environment, ensuring the User's authentication with the API Provider.
* Describe, develop, document, and test the API(s)
* Started: March 2025

## Release Information

* Note: Please be aware that the project will have updates to the main branch. There are no compatibility guarantees associated with code in any branch, including main, until a new release is created. For example, changes may be reverted before a release is created. **For best results, use the latest available release**.
* `NEW`: Public release r1.2 of API version `0.1.0` is available [here](https://github.com/camaraproject/ConsentInfo/releases/tag/r1.2)
  * API definition **with inline documentation**:
    * [View it on ReDoc](https://redocly.github.io/redoc/?url=https://raw.githubusercontent.com/camaraproject/ConsentInfo/r1.2/code/API_definitions/consent-info.yaml&nocors)
    * [View it on Swagger Editor](https://camaraproject.github.io/swagger-ui/?url=https://raw.githubusercontent.com/camaraproject/ConsentInfo/r1.2/code/API_definitions/consent-info.yaml)
    * OpenAPI [YAML spec file](https://github.com/camaraproject/ConsentInfo/blob/r1.2/code/API_definitions/consent-info.yaml)
  * API additional [related documentation](https://github.com/camaraproject/ConsentInfo/tree/r1.2/documentation/API_documentation)

<!-- Optional: an explicit listing of the latest (pre-)release with additional information, e.g. links to the API definitions -->
<!-- In addition use/uncomment one or multiple the following alternative options when becoming applicable -->
* Pre-releases of this sub project are available in https://github.com/camaraproject/ConsentInfo/releases
* The latest public release is available here: https://github.com/camaraproject/ConsentInfo/releases/latest
* For changes see [CHANGELOG.md](https://github.com/camaraproject/ConsentInfo/blob/main/CHANGELOG.md)

## Contributing

* Meetings of the working group are held virtually
  * Schedule: Bi-weekly, Wednesday, 4 PM CET/CEST (15:00 UTC, 14:00 UTC during European DST)
  * [Registration / Join](https://zoom-lfx.platform.linuxfoundation.org/meeting/94629188836?password=278b4c8a-f370-43bf-bac1-b30a39f169f3)
  * Minutes: Access [meeting minutes](https://lf-camaraproject.atlassian.net/wiki/x/lE7e)

* Mailing List
  * Subscribe / Unsubscribe to the mailing list <https://lists.camaraproject.org/g/wg-icm>.
  * A message to the community of this Sub Project can be sent using <wg-icm@lists.camaraproject.org>.
