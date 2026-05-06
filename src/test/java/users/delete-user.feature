Feature: DELETE User API Tests

  Background:
    * url baseUrl

  Scenario: Delete existing user returns 200
    Given path '/users/1'
    When method delete
    Then status 200

  Scenario: Delete user returns empty object
    Given path '/users/5'
    When method delete
    Then status 200
    And match response == {}

  Scenario: Delete another user
    Given path '/users/2'
    When method delete
    Then status 200

  Scenario Outline: Delete multiple users
    Given path '/users/<userId>'
    When method delete
    Then status 200

    Examples:
      | userId |
      | 3      |
      | 6      |
      | 7      |