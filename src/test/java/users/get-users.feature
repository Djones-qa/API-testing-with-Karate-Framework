Feature: GET Users API Tests

  Background:
    * url baseUrl

  Scenario: Get list of users - page 1
    Given path '/users'
    And param page = 1
    When method get
    Then status 200
    And match response.page == 1
    And match response.data == '#[6]'
    And match each response.data contains { id: '#number', email: '#string', first_name: '#string', last_name: '#string' }

  Scenario: Get list of users - page 2
    Given path '/users'
    And param page = 2
    When method get
    Then status 200
    And match response.page == 2
    And match response.data == '#[6]'

  Scenario: Get single user by ID
    Given path '/users/2'
    When method get
    Then status 200
    And match response.data.id == 2
    And match response.data.email == '#string'
    And match response.data.first_name == '#string'
    And match response.data.last_name == '#string'
    And match response.data.avatar == '#string'

  Scenario: Get user with invalid ID returns 404
    Given path '/users/999'
    When method get
    Then status 404
    And match response == {}

  Scenario: Validate user response schema
    Given path '/users/1'
    When method get
    Then status 200
    And match response.data ==
    """
    {
      id: '#number',
      email: '#string',
      first_name: '#string',
      last_name: '#string',
      avatar: '#string'
    }
    """
    And match response.support contains { url: '#string', text: '#string' }

  Scenario: Verify pagination metadata
    Given path '/users'
    And param page = 1
    When method get
    Then status 200
    And match response contains { page: '#number', per_page: '#number', total: '#number', total_pages: '#number' }
    And assert response.total > 0
    And assert response.per_page > 0

  Scenario Outline: Get user by valid IDs
    Given path '/users/<userId>'
    When method get
    Then status 200
    And match response.data.id == <userId>

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

  Scenario: Get users with delay parameter
    Given path '/users'
    And param delay = 1
    When method get
    Then status 200
    And match response.data == '#[6]'
