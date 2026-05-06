Feature: GET Posts (Products) API Tests

  Background:
    * url baseUrl

  Scenario: Get list of posts
    Given path '/posts'
    When method get
    Then status 200
    And match response == '#[100]'
    And match each response contains { id: '#number', userId: '#number', title: '#string', body: '#string' }

  Scenario: Get single post by ID
    Given path '/posts/1'
    When method get
    Then status 200
    And match response.id == 1
    And match response.userId == '#number'
    And match response.title == '#string'
    And match response.body == '#string'

  Scenario: Get post with invalid ID returns 404
    Given path '/posts/999'
    When method get
    Then status 404

  Scenario: Validate post schema
    Given path '/posts/1'
    When method get
    Then status 200
    And match response ==
    """
    {
      userId: '#number',
      id: '#number',
      title: '#string',
      body: '#string'
    }
    """

  Scenario Outline: Get posts by valid IDs
    Given path '/posts/<postId>'
    When method get
    Then status 200
    And match response.id == <postId>

    Examples:
      | postId |
      | 1      |
      | 2      |
      | 3      |

  Scenario: Verify post list pagination with _limit
    Given path '/posts'
    And param _limit = 10
    When method get
    Then status 200
    And match response == '#[10]'