Feature: Negative and Edge Case Tests

  Background:
    * url baseUrl

  Scenario: GET non-existent endpoint returns 404
    Given path '/nonexistent'
    When method get
    Then status 404

  Scenario: GET user with invalid large ID returns 404
    Given path '/users/999999'
    When method get
    Then status 404

  Scenario: GET post with invalid ID returns 404
    Given path '/posts/999'
    When method get
    Then status 404

  Scenario: GET user with ID 0 returns 404
    Given path '/users/0'
    When method get
    Then status 404

  Scenario: GET users with large page returns empty or valid response
    Given path '/posts'
    And param _page = 99999
    When method get
    Then status 200

  Scenario: POST user with minimal body still returns 201
    Given path '/users'
    And request { name: 'Minimal' }
    When method post
    Then status 201
    And match response.id == '#number'

  Scenario: POST user with very long name
    * def fun = function(){ var s = ''; for(var i = 0; i < 100; i++) s += 'a'; return s; }
    * def longName = fun()
    Given path '/users'
    And request { name: '#(longName)', username: 'longtest', email: 'long@test.com' }
    When method post
    Then status 201

  Scenario: DELETE non-existent user still returns 200
    Given path '/users/999'
    When method delete
    Then status 200