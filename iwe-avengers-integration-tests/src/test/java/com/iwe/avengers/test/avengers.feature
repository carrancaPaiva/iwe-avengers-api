Feature: Perform integrated tests on the Avengers registration API

Background:
* url 'https://12v2gnm2tl.execute-api.us-west-2.amazonaws.com/dev/'


 * def getToken =
"""
function() {
 var TokenGenerator = Java.type('com.iwe.avengers.test.authorization.TokenGenerator');
 var sg = new TokenGenerator();
 return sg.getToken();
}
"""
* def token = call getToken


Scenario: Should return non-authenticated access 

Given path 'avengers','anyid'
When method get
Then status 401


Scenario: Should return non-authorized access

Given path 'avengers', 'anyid' 
And header Authorization = 'Bearer ' + token + 'a'
When method get
Then status 403



Scenario: Avenger not found

Given path 'avengers','avenger-not-found'
And header Authorization = 'Bearer ' + token
When method get
Then status 404


Scenario: Creates a new Avenger

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Captain America', secretIdentity: 'Steve Rogers'}
When method post
Then status 201
And match response == {id: '#string', name: 'Captain America', secretIdentity: 'Steve Rogers'}

* def savedAvenger = response

Given path 'avengers',savedAvenger.id
And header Authorization = 'Bearer ' + token
When method get
Then status 200
And match $ == savedAvenger



Scenario: Creates a new Avenger without  the required data

Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Captain America'}
When method post
Then status 400


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



Scenario: Deletes the Avenger by Id

#Create a new Avenger
Given path 'avengers'
And header Authorization = 'Bearer ' + token
And request {name: 'Hulk', secretIdentity: 'Bruce Banner'}
When method post
Then status 201

* def avengerToDelete = response


#Delete the Avenger
Given path 'avengers', avengerToDelete.id
And header Authorization = 'Bearer ' + token
When method delete
Then status 204

#Search deleted Avenger
Given path 'avengers', avengerToDelete.id
And header Authorization = 'Bearer ' + token
When method get
Then status 404





