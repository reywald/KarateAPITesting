@debug
Feature: Data Driven Testing Example

Background:
    * url apiUrl
    * def sleep = function(pause) { java.lang.Thread.sleep( pause * 1000 ) }

Scenario Outline:
    * request { title: "#(title)", complete: false }
    * method Post
    * match response == { id: "#string", title: "#(title)", complete: false } 
    * status 200
    * print `Finished iteration: ${iteration}`
    * sleep(5)

    Examples:
        | title | iteration |
        | One   | 1         |
        | Two   | 2         |
        | Three | 3         |
