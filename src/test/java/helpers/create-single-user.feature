@ignore
Feature: Helper - Create a single user (called from other features)

  Background:
    * url baseUrl

  Scenario: Create user
    Given path '/users'
    And request { name: '#(name)', username: '#(username)', email: '#(email)' }
    When method post
    Then status 201