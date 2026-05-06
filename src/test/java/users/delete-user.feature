Feature: DELETE User API Tests

  Background:
    * url baseUrl

  Scenario: Delete existing user returns 204
    Given path '/users/2'
    When method delete
    Then status 204

  Scenario: Delete user and verify empty response
    Given path '/users/5'
    When method delete
    Then status 204
    And match response == ''

  Scenario: Delete non-existent user
    Given path '/users/999'
    When method delete
    Then status 204

  Scenario Outline: Delete multiple users
    Given path '/users/<userId>'
    When method delete
    Then status 204

    Examples:
      | userId |
      | 1      |
      | 3      |
      | 6      |
