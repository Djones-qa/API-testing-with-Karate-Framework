@ignore
Feature: Common Helper Functions

  Scenario: Reusable helper utilities
    * def generateEmail = function(name){ return name.toLowerCase().replace(' ', '.') + '@test.com' }
    * def getCurrentTimestamp = function(){ return new Date().toISOString() }
    * def randomInt = function(min, max){ return Math.floor(Math.random() * (max - min + 1)) + min }
    * def isValidEmail = function(email){ return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email) }
    * def isValidId = function(id){ return typeof id === 'string' && id.length > 0 }
