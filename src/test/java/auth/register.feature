Feature: Authentication - Register API Tests

  Background:
    * url baseUrl

  Scenario: Create new user (register equivalent)
    Given path '/users'
    And request { name: 'New User', username: 'newuser', email: 'newuser@test.com' }
    When method post
    Then status 201
    And match response.id == '#number'
    And match response.name == 'New User'

  Scenario: Create user without username
    Given path '/users'
    And request { name: 'No Username', email: 'nousername@test.com' }
    When method post
    Then status 201
    And match response.id == '#number'

  Scenario: Create user without email
    Given path '/users'
    And request { name: 'No Email', username: 'noemail' }
    When method post
    Then status 201
    And match response.id == '#number'

  Scenario: Create user with all fields returns id
    Given path '/users'
    And request { name: 'Full User', username: 'fulluser', email: 'full@test.com' }
    When method post
    Then status 201
    And match response.id == '#number'