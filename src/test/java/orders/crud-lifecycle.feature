Feature: Full CRUD Lifecycle - End-to-End API Chaining

  Background:
    * url baseUrl

  Scenario: Complete user lifecycle - Create, Read, Update, Delete
    # Step 1: Create a new user
    Given path '/users'
    And request { name: 'Lifecycle User', username: 'lifecycle', email: 'lifecycle@test.com' }
    When method post
    Then status 201
    * def createdId = response.id
    And match response.name == 'Lifecycle User'

    # Step 2: Read an existing user
    Given path '/users/2'
    When method get
    Then status 200
    And match response.id == 2

    # Step 3: Update the user
    Given path '/users/2'
    And request { name: 'Updated Lifecycle User', username: 'updated', email: 'updated@test.com' }
    When method put
    Then status 200
    And match response.name == 'Updated Lifecycle User'

    # Step 4: Partial update
    Given path '/users/2'
    And request { name: 'Lead QA Engineer' }
    When method patch
    Then status 200
    And match response.name == 'Lead QA Engineer'

    # Step 5: Delete the user
    Given path '/users/2'
    When method delete
    Then status 200

  Scenario: Create user and fetch their posts
    # Step 1: Get a user
    Given path '/users/1'
    When method get
    Then status 200
    * def userId = response.id

    # Step 2: Fetch posts for that user
    Given path '/posts'
    And param userId = userId
    When method get
    Then status 200
    And match each response contains { userId: '#(userId)' }

  Scenario: Batch create multiple users and verify
    * def users = [{ name: 'User A', username: 'usera', email: 'a@test.com' }, { name: 'User B', username: 'userb', email: 'b@test.com' }, { name: 'User C', username: 'userc', email: 'c@test.com' }]
    * def result = call read('classpath:helpers/create-single-user.feature') users
    * match each result[*].response contains { id: '#number' }