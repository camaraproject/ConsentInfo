Feature: CAMARA Consent Info API, v0.1.0 - Operation retrieveStatus
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * TBC
  #
  # Testing assets:
  # * TBC
  #
  # References to OAS spec schemas refer to schemas specifies in consent-info.yaml

  Background: Common retrieveStatus setup
    Given an environment at "apiRoot"
    And the resource "/consent-info/v0.1/retrieve"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    # Properties not explicitly overwitten in the Scenarios can take any values compliant with the schema
    And the request body is set by default to a request body compliant with the schema at "/components/schemas/retrieveStatusRequestBody"

  # Success scenarios

  # This first scenario serves as a minimum, not testing any specific status
  @consent_info_retrieveStatus_01_generic_success_scenario
  Scenario: Common validations for any success scenario
    Given a valid phone number identified by the token or provided in the request body
    When the request "retrieveStatus" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/retrieveStatusResponseBody"

  @consent_info_retrieveStatus_02_valid_for_processing
  Scenario: Status valid for processing. Data processing is allowed
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.scopes" is set to a valid scope list
    And the request body property "$.purpose" is set to a valid purpose for the requested scope(s)
    When the request "retrieveStatus" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/retrieveStatusResponseBody"
    And the response property "$.statusInfo[*].scopes" is either equal to or a subset of the requested scopes
    And the response property "$.statusInfo[*].purpose" matches the requested purpose
    And the response property "$.statusInfo[*].statusValidForProcessing" is true

  @consent_info_retrieveStatus_03_not_valid_for_processing
  Scenario: Status not valid for processing. Data processing is not allowed
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.scopes" is set to a valid scope list
    And the request body property "$.purpose" is set to a valid purpose for the requested scope(s)
    When the request "retrieveStatus" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/retrieveStatusResponseBody"
    And the response property "$.statusInfo[*].scopes" is either equal to or a subset of the requested scopes
    And the response property "$.statusInfo[*].purpose" matches the requested purpose
    And the response property "$.statusInfo[*].statusValidForProcessing" is false
    And the response property "$.statusInfo[*].statusReason" is present

  @consent_info_retrieveStatus_04_valid_for_processing_expiration_date
  # This scenario is only applicable if the API Provider has implemented the expirationDate property
  Scenario: Status valid for processing to be expired in the future
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.scopes" is set to a valid scope list
    And the request body property "$.purpose" is set to a valid purpose for the requested scope(s)
    When the request "retrieveStatus" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/retrieveStatusResponseBody"
    And the response property "$.statusInfo[*].scopes" is either equal to or a subset of the requested scopes
    And the response property "$.statusInfo[*].purpose" matches the requested purpose
    And the response property "$.statusInfo[*].statusValidForProcessing" is true
    And the response property "$.statusInfo[*].expirationDate" is present and its value is in the future

  @consent_info_retrieveStatus_05_not_valid_for_processing_expiration_date
  # This scenario is only applicable if the API Provider has implemented the expirationDate property
  Scenario: Status not valid for processing. Already expired
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.scopes" is set to a valid scope list
    And the request body property "$.purpose" is set to a valid purpose for the requested scope(s)
    When the request "retrieveStatus" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/retrieveStatusResponseBody"
    And the response property "$.statusInfo[*].scopes" is either equal to or a subset of the requested scopes
    And the response property "$.statusInfo[*].purpose" matches the requested purpose
    And the response property "$.statusInfo[*].statusValidForProcessing" is false
    And the response property "$.statusInfo[*].statusReason" is "EXPIRED"
    And the response property "$.statusInfo[*].expirationDate" is present and its value is in the past

  @consent_info_retrieveStatus_06_captureUrl
  Scenario: API Consumer requests API Provider to return a Consent capture URL
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.requestCaptureUrl" is set to true
    And the request body property "$.scopes" is set to a valid scope list
    And the request body property "$.purpose" is set to a valid purpose for the requested scope(s)
    When the request "retrieveStatus" is sent
    Then the response status code is 200
    And the response body complies with the OAS schema at "/components/schemas/retrieveStatusResponseBody"
    And the response property "$.statusInfo[*].scopes" is either equal to or a subset of the requested scopes
    And the response property "$.statusInfo[*].purpose" matches the requested purpose
    And the response property "$.statusInfo[*].statusValidForProcessing" is false
    And the response property "$.statusInfo[*].statusReason" is "PENDING", "REQUESTED" or "EXPIRED"
    And the response property "$.captureUrl" is present and it contains a valid URL

  # Error scenarios for management of input parameter phoneNumber

  @consent_info_retrieveStatus_C02.01_phone_number_not_schema_compliant
  Scenario: Phone number value does not comply with the schema
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" does not comply with the OAS schema at "/components/schemas/PhoneNumber"
    When the request "retrieveStatus" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_C02.02_phone_number_not_found
  Scenario: Phone number not found
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is compliant with the schema but does not identify a valid phone number
    When the request "retrieveStatus" is sent
    Then the response status code is 404
    And the response property "$.status" is 404
    And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_C02.03_unnecessary_phone_number
  Scenario: Phone number not to be included when it can be deduced from the access token
    Given the header "Authorization" is set to a valid access token identifying a phone number
    And  the request body property "$.phoneNumber" is set to a valid phone number
    When the request "retrieveStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_C02.04_missing_phone_number
  Scenario: Phone number not included and cannot be deducted from the access token
    Given the header "Authorization" is set to a valid access token which does not identify a single phone number
    And the request body property "$.phoneNumber" is not included
    When the request "retrieveStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "MISSING_IDENTIFIER"
    And the response property "$.message" contains a user friendly text

  # When the service is only offered to certain type of subscriptions, e.g. IoT, , B2C, etc
  @consent_info_retrieveStatus_C02.05_phone_number_not_supported
  Scenario: Service not available for the phone number
    Given that the service is not available for all phone numbers commercialized by the operator
    And a valid phone number, identified by the token or provided in the request body, for which the service is not applicable
    When the request "retrieveStatus" is sent
    Then the response status code is 422
    And the response property "$.status" is 422
    And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
    And the response property "$.message" contains a user friendly text

  # Generic error scenarios

  # Generic 400 errors

  @consent_info_retrieveStatus_400.1_schema_not_compliant
  Scenario: Invalid Argument. Generic Syntax Exception
    Given the request body is set to any value which is not compliant with the schema at "/components/schemas/retrieveStatusRequestBody"
    When the request "retrieveStatus" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_400.2_no_request_body
  Scenario: Missing request body
    Given the request body is not included
    When the request "retrieveStatus" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_400.3_empty_request_body
  Scenario: Empty object as request body
    Given the request body is set to {}
    When the request "retrieveStatus" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_400.4_x_correlator_not_compliant
  Scenario: Invalid x-correlator header
    Given the header "x-correlator" is set to a value which is not compliant with the schema at "#/components/schemas/XCorrelator"
    And the request body is set to a valid request body
    When the request "retrieveStatus" is sent
    Then the response status code is 400
    And the response property "$.status" is 400
    And the response property "$.code" is "INVALID_ARGUMENT"
    And the response property "$.message" contains a user friendly text

  # Generic 401 errors

  @consent_info_retrieveStatus_401.1_no_authorization_header
  Scenario: No Authorization header
    Given the header "Authorization" is removed
    And the request body is set to a valid request body
    When the request "retrieveStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_401.2_expired_access_token
  Scenario: Expired access token
    Given the header "Authorization" is set to an expired access token
    And the request body is set to a valid request body
    When the request "retrieveStatus" is sent
    Then the response status code is 401
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_401.3_invalid_access_token
  Scenario: Invalid access token
    Given the header "Authorization" is set to an invalid access token
    And the request body is set to a valid request body
    When the request "retrieveStatus" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 401
    And the response property "$.code" is "UNAUTHENTICATED"
    And the response property "$.message" contains a user friendly text

  # Generic 403 errors

  @consent_info_retrieveStatus_403.1_invalid_token_permissions
  Scenario: Inconsistent access token permissions
    # To test this scenario, it will be necessary to obtain a token without the required scope
    Given the header "Authorization" is set to an access token without the required scope
    And the request body is set to a valid request body
    When the request "retrieveStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text

  # Specific 403 error scenarios

  @consent_info_retrieveStatus_01_not_allowed_scopes_purpose
  # e.g. the API Consumer has not onboarded the appropriate API(s) with the API Provider for the declared Purpose.
  Scenario: The requested scope(s) and Purpose combination is not allowed
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.scopes" and "$.purpose" are set to a value which is not allowed for the API Consumer
    When the request "retrieveStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CONSENT_INFO.NOT_ALLOWED_SCOPES_PURPOSE"
    And the response property "$.message" contains a user friendly text

  @consent_info_retrieveStatus_02_capture_frequency_exceeded
  # e.g. the API Consumer has exceeded the maximum number of captureUrl requests for the same phone number within a certain time period
  # This scenario is only applicable if the API Consumer has requested a captureUrl
  # and the API Provider has implemented limits to control the frequency a User can be contacted for Consent
  Scenario: The API Consumer has exceeded the maximum number of captureUrl requests
    Given a valid phone number identified by the token or provided in the request body
    And the request body property "$.requestCaptureUrl" is set to true
    And the API Consumer has exceeded the maximum number of captureUrl requests for the same phone number within a certain time period
    When the request "retrieveStatus" is sent
    Then the response status code is 403
    And the response property "$.status" is 403
    And the response property "$.code" is "CONSENT_INFO.CAPTURE_FREQUENCY_EXCEEDED"
    And the response property "$.message" contains a user friendly text