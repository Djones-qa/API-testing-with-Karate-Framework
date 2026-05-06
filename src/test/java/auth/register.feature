Feature: Authentication - Register API Tests

  Background:
    * url baseUrl

  Scenario: Successful registration
    Given path '/register'
    And request { email: 'eve.holt@reqres.in', password: 'pistol' }
    When method post
    Then status 200
    And match response.id == '#number'
    And match response.token == '#string'

  Scenario: Registration fails without password
    Given path '/register'
    And request { email: 'eve.holt@reqres.in' }
    When method post
    Then status 400
    And match response.error == 'Missing password'

  Scenario: Registration fails without email
    Given path '/register'
    And request { password: 'pistol' }
    When method post
    Then status 400
    And match response.error == 'Missing email or username'

  Scenario: Registration fails with undefined user
    Given path '/register'
    And request { email: 'unknown@test.com', password: 'test123' }
    When method post
    Then status 400
    And match response.error == '#string'
