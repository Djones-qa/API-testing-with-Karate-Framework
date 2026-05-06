Feature: Data-Driven Resource Tests

  Background:
    * url baseUrl
    * def testData = read('classpath:data/products.json')

  Scenario: Validate all resources from test data
    * def ids = karate.jsonPath(testData, '$[*].id')
    Given path '/unknown'
    When method get
    Then status 200
    And match response.data[*].id contains any ids

  Scenario Outline: Verify resource names from data file
    Given path '/unknown/<id>'
    When method get
    Then status 200
    And match response.data.name == '<name>'

    Examples:
      | id | name            |
      | 1  | cerulean        |
      | 2  | fuchsia rose    |
      | 3  | true red        |
      | 4  | aqua sky        |
      | 5  | tigerlily       |
      | 6  | blue turquoise  |

  Scenario: Search resources and filter by year
    Given path '/unknown'
    When method get
    Then status 200
    * def recentResources = karate.filter(response.data, function(x){ return x.year >= 2002 })
    And match each recentResources contains { year: '#number? _ >= 2002' }
