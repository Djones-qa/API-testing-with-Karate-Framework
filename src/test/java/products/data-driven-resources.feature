Feature: Data-Driven Post Tests

  Background:
    * url baseUrl
    * def testData = read('classpath:data/products.json')

  Scenario: Validate posts exist for IDs in test data
    * def ids = karate.jsonPath(testData, '$[*].id')
    Given path '/posts'
    And param _limit = 10
    When method get
    Then status 200
    And match response[*].id contains any ids

  Scenario Outline: Verify posts by ID from data file
    Given path '/posts/<id>'
    When method get
    Then status 200
    And match response.id == <id>

    Examples:
      | id |
      | 1  |
      | 2  |
      | 3  |
      | 4  |
      | 5  |
      | 6  |

  Scenario: Filter posts by userId
    Given path '/posts'
    And param userId = 1
    When method get
    Then status 200
    And match each response contains { userId: 1 }
    And match response == '#[_ > 0]'