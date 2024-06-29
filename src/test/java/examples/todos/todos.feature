Feature: Karate Basic Todos

Background:
    * url apiUrl

Scenario: Get all todos
    Given url "http://localhost:8080/api/todos"
    When method Get
    Then status 200

Scenario: Basic todo flow

    * def taskName = "MyFirstTask"

    # Create a singe todo
    Given request { title: "#(taskName)", complete: false }
    When method Post
    Then status 200
    And match response == { id: "#string", title: "#(taskName)", complete: false }
    * def id = response.id
    * def title = response.title
    * def status = response.complete
    * print "Value of ID: " + id

    # Get a single Todo
    Given path id
    When method Get
    Then status 200
    And match response == { id: "#(id)", title: "#(taskName)", complete: false }

    # Create a second todo
    * def todo = 
    """
        {
            "title": "Second",
            "complete": false
        }
    """

    Given request todo
    And header Content-Type = "application/json"
    When method Post
    Then status 200
    And match response.title == "Second"

    # Get all todos
    When method Get
    Then status 200
    * def firstTask = response[0]
    * match firstTask.title == taskName
    * match firstTask.complete == false

    # Check all response objects
    * match each response contains { complete: "#boolean" }

    * call read("classpath:helpers/ResetTodos.feature")