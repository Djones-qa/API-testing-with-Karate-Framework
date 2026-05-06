Feature: GET Users API Tests

  Background:
    * url baseUrl

  Scenario: Get list of users
    Given path '/users'
    When method get
    Then status 200
    And match response == '#[10]'
    And match each response contains { id: '#number', name: '#string', email: '#string' }

  Scenario: Get single user by ID
    Given path '/users/1'
    When method get
    Then status 200
    And match response.id == 1
    And match response.name == '#string'
    And match response.email == '#string'
    And match response.username == '#string'

  Scenario: Get user with invalid ID returns 404
    Given path '/users/999'
    When method get
    Then status 404

  Scenario: Validate user response schema
    Given path '/users/1'
    When method get
    Then status 200
    And match response ==
    """
    {
      id: '#number',
      name: '#string',
      username: '#string',
      email: '#string',
      address: '#object',
      phone: '#string',
      website: '#string',
      company: '#object'
    }
    """

  Scenario Outline: Get user by valid IDs
    Given path '/users/<userId>'
    When method get
    Then status 200
    And match response.id == <userId>

    Examples:
      | userId |
      | 1      |
      | 2      |
      | 3      |
      | 4      |

  Scenario: Verify response headers
    Given path '/users/1'
    When method get
    Then status 200
    And match responseHeaders['Content-Type'][0] contains 'application/json'