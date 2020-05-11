# Conference App
## Introduction

You are working on the apllication for Conferences. A user of such application should be able to register on this application and interact with it on browsing the available events, be able to subscribe the current conference.

Implement a network service that is used to interact with the server.

## Problem Statement

You have to implement the following methods:

* The function registers users with a login and a password. In case of a successful registration, it returns the token in a success block. In case of an error, it calls a failure block.
```
func registerUserWith(login: String?, password: String?, success: @escaping (Data)->(), failure: @escaping (Error?) -> ())
```

* The function returns a list of all available events.  In case of an error, it calls a failure block.
```
func getAllEvents(success: @escaping (Data)->(), failure: @escaping (Error?) -> ())
```


* The function subscribes the current user on an event.  In case of an error, it calls a failure block.
```
func subscribeOnEvent(eventUUID: Int, success: @escaping (Data)->(), failure: @escaping (Error?) -> ())
```


Introduce all changes to existing file `NetworkService.swift` only.

## API reference

You should use `session` property from NetworkService.swift.

- User registration
(POST method)
creates a user. returns authToken

- Retrieving list of available events
(GET method)
returns list of events.

- Subscribing to event
(GET method)
adds the current user to an event.

Events structure:
```
{
    "events": [
        {
            "uuid": (int),
            "name": "..."
        }
        ...
    ]
}
```
User structure:
```
{
    "user": {
        "password": "...",
        "name": "...",
        "authToken": "...",
        "events": [
            {
                "uuid": (int)
            }
        ]
    }
}
```
Example request path:
```
/api/v1/events
```
## Hints
* URLs should always be provided with a leading slash and without a trailing slash.
## Technical requirements
*   Language: Swift 4.2
*   System version: 12+
