Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://12v2gnm2tl.execute-api.us-west-2.amazonaws.com/dev/'


Scenario: Avenger not found

Given path 'avengers','avenger-not-found'
When method get
Then status 404


Scenario: Creates a new Avenger

Given path 'avengers'
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method post
Then status 201
And match response == {id: '#string', name: 'Captain America', secretIdentity: 'Steve Rogers'}

* def savedAvenger = response

Given path 'avengers',savedAvenger.id
When method get
Then status 200
And match $ == savedAvenger



Scenario: Creates a new Avenger without  the required data

Given path 'avengers'
And request {name: 'Captain America'}
When method post
Then status 400

Scenario: Delete a new Avenger without  the required data

Given path 'avengers','aaaa-bbbb-cccc-dddd'
When method delete 
Then status 204

Scenario: Update a Avenger

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method put 
Then status 200
And match response == {id: '#string', name: '#string', secretIdentity: '#string'}

Scenario: Update a Avenger notFound

Given path 'avengers','avenger-not-found'
And request {name: 'eu', secretIdentity: 'eu'}
When method put 
Then status 404



Scenario: Update a Avenger invalid body

Given path 'avengers','aaaa-bbbb-cccc-dddd'
And request {name: 'Captain America'}
When method put 
Then status 400







