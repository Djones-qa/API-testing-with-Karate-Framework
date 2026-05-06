Feature: Authentication - Login API Tests

  Background:
    * url baseUrl

  Scenario: Get user and use ID for subsequent request
    Given path '/users/1'
    When method get
    Then status 200
    * def userId = response.id
    And match userId == 1

    Given path '/posts'
    And param userId = userId
    When method get
    Then status 200
    And match each response contains { userId: '#number', id: '#number' }

  Scenario: Fetch user details
    Given path '/users/4'
    When method get
    Then status 200
    And match response.id == 4
    And match response.email == '#string'

  Scenario: User not found returns 404
    Given path '/users/999'
    When method get
    Then status 404

  Scenario: Get user and verify email format
    Given path '/users/1'
    When method get
    Then status 200
    And match response.email == '#regex .+@.+\\..+'

  Scenario: Get user and access nested address
    Given path '/users/1'
    When method get
    Then status 200
    And match response.address.city == '#string'
    And match response.address.zipcode == '#string'