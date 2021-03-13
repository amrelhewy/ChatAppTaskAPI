# Chat API

### Ruby version v2.7.0

### Gems used:
* rails
* mysql2
* active_model_serializers
* elasticsearch-model
* elasticsearch-rails
* sidekiq
* foreman

### Database Models
* Application model
* Chat model
* Message model

### Services 
- we have two workers message_queue and a chat_queue to process message and chat creation asynchronusly.
- both workers were created using sidekiq gem and foreman runs the two workers along with the web server.
## API routes
* all routes are versioned with the namespace api/v1.

### Application routes

#### /api/v1/applications (POST)
*  takes name as paramater. 
* Returns JSON wuth created application token and info.

#### /api/v1/applications/:token (GET)
* returns application info specified via token param.

#### /api/v1/applications/:token (PUT)
* takes name as payload and token as param
* updates application with sent name.

#### /api/v1/applications (GET)
* gets all applications.
---
### Chat routes

#### /api/v1/chats (POST)
* takes application_token as payload 
* returns created chat with auto incrementing number based on token.

#### api/v1/applications/:token/chats (GET)
* takes token as param
* returns chats that only belong to specific application.
---
### Message routes

#### api/v1/messages (POST)
* takes application_token , chat_number and body as payload.
* returns body and number of message created.

#### api/v1/chats/:token/:number/messages (GET)
* takes token and chat number as params
* returns all messages in the specified chat room.

#### api/v1/messages/search?query=asd&token=asd&number=2
* takes query, token and number of chat as query strings as shown in the example above.
* returns any messages that contain the query specified for example if "i love pizza" was in the database as a message in the specified chat room and application and we searched for the word "love" the search will return "i love pizza" and so on.
---
## Indexes
* token in application model
* application_token + chat number in chat model
* chat_id in messages model
* application_token in chat model
#### To Run docker-compose run the following command
```
sudo sh ./runScript.sh
```
#### The reason for using a script is beacause elastic search container needs to run the first command to run otherwise it crashes, if you don't want to run the script you can also run the following:
```
sysctl -w vm.max_map_count=262144
```
#### Followed by
```
docker-compose up
```
##### if anything goes wrong please email me at amrelhewi@gmail.com , i enjoyed this task alot because it made me learn alot of new exciting things so thank you for the challenge and hope to hear from you soon! 
