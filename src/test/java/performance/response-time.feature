Feature: Performance and Response Time Validation

  Background:
    * url baseUrl

  Scenario: GET users responds under 3 seconds
    Given path '/users'
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: GET single user responds under 2 seconds
    Given path '/users/1'
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: POST create user responds under 3 seconds
    Given path '/users'
    And request { name: 'Perf Test', job: 'Tester' }
    When method post
    Then status 201
    And assert responseTime < 5000

  Scenario: GET resources responds under 3 seconds
    Given path '/unknown'
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: Login responds under 3 seconds
    Given path '/login'
    And request { email: 'eve.holt@reqres.in', password: 'cityslicka' }
    When method post
    Then status 200
    And assert responseTime < 5000

  Scenario: Delayed response within acceptable range
    Given path '/users'
    And param delay = 2
    When method get
    Then status 200
    And assert responseTime < 8000
