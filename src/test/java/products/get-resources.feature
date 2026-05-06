Feature: GET Resources (Products) API Tests

  Background:
    * url baseUrl

  Scenario: Get list of resources
    Given path '/unknown'
    When method get
    Then status 200
    And match response.data == '#[6]'
    And match each response.data contains { id: '#number', name: '#string', year: '#number', color: '#string', pantone_value: '#string' }

  Scenario: Get single resource by ID
    Given path '/unknown/2'
    When method get
    Then status 200
    And match response.data.id == 2
    And match response.data.name == '#string'
    And match response.data.year == '#number'
    And match response.data.color == '#regex #[0-9a-fA-F]{6}'

  Scenario: Get resource with invalid ID returns 404
    Given path '/unknown/999'
    When method get
    Then status 404
    And match response == {}

  Scenario: Validate resource schema
    Given path '/unknown/1'
    When method get
    Then status 200
    And match response.data ==
    """
    {
      id: '#number',
      name: '#string',
      year: '#number',
      color: '#string',
      pantone_value: '#string'
    }
    """

  Scenario Outline: Get resources by valid IDs
    Given path '/unknown/<resourceId>'
    When method get
    Then status 200
    And match response.data.id == <resourceId>
    And match response.data.name == '<expectedName>'

    Examples:
      | resourceId | expectedName    |
      | 1          | cerulean        |
      | 2          | fuchsia rose    |
      | 3          | true red        |

  Scenario: Verify resource list pagination
    Given path '/unknown'
    And param page = 1
    When method get
    Then status 200
    And match response contains { page: 1, per_page: '#number', total: '#number' }
    And assert response.total >= response.per_page
