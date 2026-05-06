Feature: PUT/PATCH Update User API Tests

  Background:
    * url baseUrl

  Scenario: Update user with PUT - full replacement
    Given path '/users/1'
    And request { name: 'Updated Name', username: 'updated', email: 'updated@test.com' }
    When method put
    Then status 200
    And match response.name == 'Updated Name'
    And match response.id == 1

  Scenario: Update user with PATCH - partial update
    Given path '/users/1'
    And request { name: 'Patched Name' }
    When method patch
    Then status 200
    And match response.name == 'Patched Name'
    And match response.id == 1

  Scenario: PUT update returns all sent fields
    Given path '/users/3'
    And request { name: 'Full Update', username: 'fullupdate', email: 'full@test.com' }
    When method put
    Then status 200
    And match response contains { name: 'Full Update', id: 3 }

  Scenario: PATCH update with single field
    Given path '/users/4'
    And request { email: 'newemail@test.com' }
    When method patch
    Then status 200
    And match response.id == 4

  Scenario: Verify PUT response contains id
    Given path '/users/2'
    And request { name: 'Timestamp Check', username: 'tc', email: 'tc@test.com' }
    When method put
    Then status 200
    And match response.id == '#number'