Feature: Helper to reset all todos

Scenario: Reset all todos
    # Clear all tasks
    Given url "http://localhost:8080/api/reset"
    When method Get
    Then status 200
    And match response == { deleted: "#number" }
    * def numbersDeleted = response.deleted
    * print `Number of tasks deleted: ${numbersDeleted}`
