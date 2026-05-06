Feature: Performance and Response Time Validation

  Background:
    * url baseUrl

  Scenario: GET users responds within acceptable time
    Given path '/users'
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: GET single user responds within acceptable time
    Given path '/users/1'
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: POST create user responds within acceptable time
    Given path '/users'
    And request { name: 'Perf Test', username: 'perftest', email: 'perf@test.com' }
    When method post
    Then status 201
    And assert responseTime < 5000

  Scenario: GET posts responds within acceptable time
    Given path '/posts'
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: GET posts with limit responds within acceptable time
    Given path '/posts'
    And param _limit = 10
    When method get
    Then status 200
    And assert responseTime < 5000

  Scenario: PUT update responds within acceptable time
    Given path '/users/1'
    And request { name: 'Perf Update', username: 'perfupdate', email: 'perfupdate@test.com' }
    When method put
    Then status 200
    And assert responseTime < 5000