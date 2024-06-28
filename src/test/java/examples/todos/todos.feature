Feature: Karate Basic Todos

Background:
    * url "http://localhost:8080/api/todos"

Scenario: Get all todos
    Given url "http://localhost:8080/api/todos"
    When method Get
    Then status 200

Scenario: Basic todo flow
    # Create a singe todo
    Given request { title: "First", complete: false }
    When method Post
    Then status 200
    And match response == { id: "#string", title: "First", complete: false }
    * def id = response.id
    * def title = response.title
    * def status = response.complete
    * print "Value of ID: " + id

    # Get a single Todo
    Given path id
    When method Get
    Then status 200
    And match response == { id: "#(id)", title: "First", complete: false }

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
    * match firstTask.title == "First"
    * match firstTask.complete == false
