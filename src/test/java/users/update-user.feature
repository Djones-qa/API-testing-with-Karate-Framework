Feature: PUT/PATCH Update User API Tests

  Background:
    * url baseUrl

  Scenario: Update user with PUT - full replacement
    Given path '/users/2'
    And request { name: 'Updated Name', job: 'Lead QA' }
    When method put
    Then status 200
    And match response.name == 'Updated Name'
    And match response.job == 'Lead QA'
    And match response.updatedAt == '#string'

  Scenario: Update user with PATCH - partial update
    Given path '/users/2'
    And request { job: 'Senior QA Automation' }
    When method patch
    Then status 200
    And match response.job == 'Senior QA Automation'
    And match response.updatedAt == '#string'

  Scenario: PUT update preserves all fields
    Given path '/users/3'
    And request { name: 'Full Update', job: 'DevOps', email: 'update@test.com' }
    When method put
    Then status 200
    And match response contains { name: 'Full Update', job: 'DevOps' }

  Scenario: PATCH update with single field
    Given path '/users/4'
    And request { name: 'Patched Name' }
    When method patch
    Then status 200
    And match response.name == 'Patched Name'

  Scenario: Verify updatedAt timestamp exists
    Given path '/users/2'
    And request { name: 'Timestamp Check' }
    When method put
    Then status 200
    And match response.updatedAt == '#regex \\d{4}-\\d{2}-\\d{2}T.+'
