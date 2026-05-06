Feature: POST Create User API Tests

  Background:
    * url baseUrl

  Scenario: Create a new user
    Given path '/users'
    And request { name: 'Darrius Jones', username: 'djones', email: 'djones@test.com' }
    When method post
    Then status 201
    And match response.name == 'Darrius Jones'
    And match response.id == '#number'

  Scenario: Create user with minimal data
    Given path '/users'
    And request { name: 'Test User', username: 'tuser', email: 'tuser@test.com' }
    When method post
    Then status 201
    And match response.name == 'Test User'
    And match response.id == '#number'

  Scenario: Create user with all fields
    Given path '/users'
    And request
    """
    {
      "name": "Jane Smith",
      "username": "jsmith",
      "email": "jane.smith@example.com"
    }
    """
    When method post
    Then status 201
    And match response contains { name: 'Jane Smith' }

  Scenario: Create user from external JSON data
    Given path '/users'
    And request read('classpath:data/users.json')[0]
    When method post
    Then status 201
    And match response.id == '#number'

  Scenario: Create user returns assigned ID
    Given path '/users'
    And request { name: 'ID Test', username: 'idtest', email: 'id@test.com' }
    When method post
    Then status 201
    And match response.id == 11