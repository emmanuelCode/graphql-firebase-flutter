# flutter_firebase_graphql

A Flutter Project that uses firebase authentification with graphql backend

## Getting Started

Run this command to start the emulator:
`firebase emulators:start`

To run the graphql backend run this command:

`sudo docker run --rm -it -p 8080:8080 -p 9080:9080 dgraph/standalone:latest`

push schema with this command using curl:
`curl -X POST localhost:8080/admin/schema --data-binary '@schema.graphql'`
