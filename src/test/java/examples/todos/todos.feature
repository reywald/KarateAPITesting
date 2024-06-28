Feature: Karate Basic Todos

Background:
    * url "http://localhost:8080/api/todos"

Scenario: Get all todos
    Given url "http://localhost:8080/api/todos"
    When method Get
    Then status 200

Scenario: Basic todo flow

    * def taskName = "FirstTask"

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

     # Update a todo
     Given path id
     And request { title: "#(taskName)", complete: true }
     When method Put
     Then status 200
     And match response.complete == true
    
     # Delete todo
     Given request id
     when method Delete
     Then status 200
     
     # Clear all tasks
     Given url "https://localhost:8080/api/reset"
     When method Get
     Then status 200
     And match response == { deleted: "#number" }