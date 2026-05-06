Feature: Full CRUD Lifecycle - End-to-End API Chaining

  Background:
    * url baseUrl

  Scenario: Complete user lifecycle - Create, Read, Update, Delete
    # Step 1: Create a new user
    Given path '/users'
    And request { name: 'Lifecycle User', job: 'QA Analyst' }
    When method post
    Then status 201
    * def userId = response.id
    * def createdName = response.name
    And match createdName == 'Lifecycle User'

    # Step 2: Verify user data
    * print 'Created user with ID:', userId
    Given path '/users/2'
    When method get
    Then status 200
    And match response.data.id == 2

    # Step 3: Update the user
    Given path '/users/' + userId
    And request { name: 'Updated Lifecycle User', job: 'Senior QA' }
    When method put
    Then status 200
    And match response.name == 'Updated Lifecycle User'
    And match response.job == 'Senior QA'

    # Step 4: Partial update
    Given path '/users/' + userId
    And request { job: 'Lead QA Engineer' }
    When method patch
    Then status 200
    And match response.job == 'Lead QA Engineer'

    # Step 5: Delete the user
    Given path '/users/' + userId
    When method delete
    Then status 204

  Scenario: Register, Login, and Access Protected Resource
    # Step 1: Register
    Given path '/register'
    And request { email: 'eve.holt@reqres.in', password: 'pistol' }
    When method post
    Then status 200
    * def regToken = response.token
    And match regToken == '#string'

    # Step 2: Login
    Given path '/login'
    And request { email: 'eve.holt@reqres.in', password: 'cityslicka' }
    When method post
    Then status 200
    * def loginToken = response.token

    # Step 3: Access user with token
    Given path '/users/1'
    And header Authorization = 'Bearer ' + loginToken
    When method get
    Then status 200
    And match response.data.id == 1
    And match response.data.email == '#string'

  Scenario: Batch create multiple users and verify
    * def users = [{ name: 'User A', job: 'Dev' }, { name: 'User B', job: 'QA' }, { name: 'User C', job: 'PM' }]
    * def result = call read('classpath:helpers/create-single-user.feature') users
    * match each result[*].response contains { id: '#string', createdAt: '#string' }
