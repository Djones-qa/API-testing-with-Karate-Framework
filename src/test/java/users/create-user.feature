Feature: POST Create User API Tests

  Background:
    * url baseUrl

  Scenario: Create a new user with name and job
    Given path '/users'
    And request { name: 'Darrius Jones', job: 'QA Engineer' }
    When method post
    Then status 201
    And match response.name == 'Darrius Jones'
    And match response.job == 'QA Engineer'
    And match response.id == '#string'
    And match response.createdAt == '#string'

  Scenario: Create user with minimal data
    Given path '/users'
    And request { name: 'Test User' }
    When method post
    Then status 201
    And match response.name == 'Test User'
    And match response.id == '#string'

  Scenario: Create user with all fields
    Given path '/users'
    And request
    """
    {
      "name": "Jane Smith",
      "job": "Senior Developer",
      "email": "jane.smith@example.com",
      "department": "Engineering"
    }
    """
    When method post
    Then status 201
    And match response contains { name: 'Jane Smith', job: 'Senior Developer' }

  Scenario: Create user with empty body
    Given path '/users'
    And request {}
    When method post
    Then status 201
    And match response.id == '#string'
    And match response.createdAt == '#string'

  Scenario: Create user from external JSON data
    Given path '/users'
    And request read('classpath:data/users.json')[0]
    When method post
    Then status 201
    And match response.id == '#string'

  Scenario: Verify created timestamp format
    Given path '/users'
    And request { name: 'Timestamp Test', job: 'Tester' }
    When method post
    Then status 201
    And match response.createdAt == '#regex \\d{4}-\\d{2}-\\d{2}T.+'
