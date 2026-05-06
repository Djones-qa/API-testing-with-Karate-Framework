# API Testing with Karate Framework

**Comprehensive REST API test automation using Karate DSL with BDD-style feature files.**

[![CI](https://github.com/Djones-qa/API-testing-with-Karate-Framework/actions/workflows/ci.yml/badge.svg)](https://github.com/Djones-qa/API-testing-with-Karate-Framework/actions)
[![Java 17+](https://img.shields.io/badge/Java-17%2B-blue.svg)](https://openjdk.org/)
[![Karate](https://img.shields.io/badge/Karate-1.4.1-green.svg)](https://github.com/karatelabs/karate)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

---

## Project Overview

Production-grade API test automation framework built with Karate DSL demonstrating CRUD operations, authentication flows, schema validation, data-driven testing, request chaining, negative testing, performance assertions, and parallel execution. Uses the public [ReqRes API](https://reqres.in) as the system under test.

### What This Demonstrates

- **CRUD Operations** - Complete Create, Read, Update (PUT/PATCH), Delete coverage
- **Authentication Testing** - Login, registration, token extraction and reuse
- **Schema Validation** - JSON response structure verification using Karate match syntax
- **Data-Driven Testing** - Scenario Outline with Examples tables and external JSON files
- **Request Chaining** - Multi-step flows passing data between API calls
- **Negative Testing** - Invalid inputs, missing fields, edge cases, boundary values
- **Performance Assertions** - Response time SLA validation per endpoint
- **Parallel Execution** - 5-thread parallel test runner for fast feedback
- **CI/CD Pipeline** - GitHub Actions with JDK 17 and 21 matrix, artifact upload
- **Environment Config** - Multi-environment support (dev, staging, prod) via karate-config.js

---

## Project Structure

    API-testing-with-Karate-Framework/
    .github/workflows/ci.yml
    src/test/java/
        karate-config.js                 Environment configuration
        logback-test.xml                 Logging configuration
        TestParallel.java                Parallel test runner (all suites)
        users/
            UsersRunner.java             JUnit 5 runner
            get-users.feature            9 GET user scenarios
            create-user.feature          6 POST create scenarios
            update-user.feature          5 PUT/PATCH update scenarios
            delete-user.feature          4 DELETE scenarios
        auth/
            AuthRunner.java              JUnit 5 runner
            login.feature                5 login scenarios
            register.feature             4 registration scenarios
        products/
            ProductsRunner.java          JUnit 5 runner
            get-resources.feature        6 GET resource scenarios
            data-driven-resources.feature  3 data-driven scenarios
        orders/
            OrdersRunner.java            JUnit 5 runner
            crud-lifecycle.feature       3 end-to-end chain scenarios
            negative-tests.feature       8 negative/edge case scenarios
        performance/
            PerfRunner.java              JUnit 5 runner
            response-time.feature        6 response time assertions
        helpers/
            common.feature               Reusable utility functions
            create-single-user.feature   Callable helper for batch creation
        data/
            users.json                   External test data (users)
            products.json                External test data (products)
        schemas/
            user-schema.json             User response schema
            user-list-schema.json        User list response schema
    pom.xml
    .gitignore
    README.md

---

## Test Coverage Summary

| Suite | Feature Files | Scenarios | Coverage |
|---|---|---|---|
| Users | 4 | 24 | GET, POST, PUT, PATCH, DELETE |
| Auth | 2 | 9 | Login, Register, Token Reuse |
| Products | 2 | 9 | GET, Schema, Data-Driven |
| Orders | 2 | 11 | CRUD Lifecycle, Negative Tests |
| Performance | 1 | 6 | Response Time SLAs |
| **Total** | **11** | **59** | **Full REST API Coverage** |

---

## Key Testing Patterns

### Schema Validation
    And match response.data == { id: '#number', email: '#string', first_name: '#string' }

### Data-Driven with Scenario Outline
    Scenario Outline: Get user by valid IDs
      Given path '/users/<userId>'
      When method get
      Then status 200
      And match response.data.id == <userId>
      Examples:
        | userId |
        | 1      |
        | 2      |

### Request Chaining
    # Create user, capture ID, then update
    * def userId = response.id
    Given path '/users/' + userId
    And request { job: 'Senior QA' }
    When method put

### External Test Data
    * def testData = read('classpath:data/users.json')
    And request testData[0]

### Performance Assertions
    And assert responseTime < 3000

### Reusable Helpers
    * def result = call read('classpath:helpers/create-single-user.feature') users

---

## Quick Start

### Prerequisites
- Java 17+ (JDK)
- Maven 3.8+

### Run All Tests

    git clone https://github.com/Djones-qa/API-testing-with-Karate-Framework.git
    cd API-testing-with-Karate-Framework
    mvn test

### Run Specific Suite

    mvn test -Dkarate.options="classpath:users"
    mvn test -Dkarate.options="classpath:auth"
    mvn test -Dkarate.options="classpath:products"
    mvn test -Dkarate.options="classpath:orders"
    mvn test -Dkarate.options="classpath:performance"

### Run with Environment

    mvn test -Dkarate.env=dev
    mvn test -Dkarate.env=staging

### View Reports

After test execution, open:

    target/karate-reports/karate-summary.html

---

## Tech Stack

| Component | Technology |
|---|---|
| Test Framework | Karate DSL 1.4.1 |
| Language | Java 17 |
| Build Tool | Maven |
| Test Runner | JUnit 5 |
| API Under Test | ReqRes.in (public REST API) |
| CI/CD | GitHub Actions (JDK 17 + 21 matrix) |
| Reporting | Karate HTML Reports |
| Logging | Logback |

---

## Why Karate Framework

- **No Java coding required** for test scenarios (Gherkin-like DSL)
- **Built-in assertions** with powerful JSON match syntax
- **Native parallel execution** for fast CI pipelines
- **Data-driven testing** with Scenario Outline and external files
- **Request chaining** with variable extraction and reuse
- **Schema validation** without external libraries
- **Performance testing** with built-in response time assertions
- **HTML reports** generated automatically with every run
- **Multi-environment** support via karate-config.js

---

## Author

**Darrius Jones**
QA Automation Specialist | API Testing | Backend Engineering
