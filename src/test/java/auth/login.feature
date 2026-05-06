Feature: Authentication - Login API Tests

  Background:
    * url baseUrl

  Scenario: Successful login with valid credentials
    Given path '/login'
    And request { email: 'eve.holt@reqres.in', password: 'cityslicka' }
    When method post
    Then status 200
    And match response.token == '#string'
    And match response.token == '#notnull'

  Scenario: Login fails without password
    Given path '/login'
    And request { email: 'eve.holt@reqres.in' }
    When method post
    Then status 400
    And match response.error == 'Missing password'

  Scenario: Login fails without email
    Given path '/login'
    And request { password: 'cityslicka' }
    When method post
    Then status 400
    And match response.error == 'Missing email or username'

  Scenario: Login fails with empty body
    Given path '/login'
    And request {}
    When method post
    Then status 400
    And match response.error == '#string'

  Scenario: Login and use token for subsequent request
    Given path '/login'
    And request { email: 'eve.holt@reqres.in', password: 'cityslicka' }
    When method post
    Then status 200
    * def authToken = response.token

    Given path '/users/1'
    And header Authorization = 'Bearer ' + authToken
    When method get
    Then status 200
    And match response.data.id == 1
