Feature: Negative and Edge Case Tests

  Background:
    * url baseUrl

  Scenario: GET non-existent endpoint returns 404
    Given path '/nonexistent'
    When method get
    Then status 404

  Scenario: Invalid HTTP method on users endpoint
    Given path '/users/999999'
    When method delete
    Then status 204

  Scenario: POST with invalid content type
    Given path '/users'
    And header Content-Type = 'text/plain'
    And request 'not json'
    When method post
    Then status 201

  Scenario: GET user with string ID
    Given path '/users/abc'
    When method get
    Then status 404

  Scenario: GET user with negative ID
    Given path '/users/-1'
    When method get
    Then status 404

  Scenario: GET user with zero ID
    Given path '/users/0'
    When method get
    Then status 404

  Scenario: GET users with very large page number
    Given path '/users'
    And param page = 99999
    When method get
    Then status 200
    And match response.data == '#[0]'

  Scenario: POST user with very long name
    * def longName = ''
    * def fun = function(){ var s = ''; for(var i = 0; i < 1000; i++) s += 'a'; return s; }
    * def longName = fun()
    Given path '/users'
    And request { name: '#(longName)', job: 'tester' }
    When method post
    Then status 201
