# Chat Application API

This project is a chat application API built with Ruby on Rails, MySQL, and Elasticsearch. It allows for creating applications, chats, and messages, and includes search functionality for messages.

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Running the Project](#running-the-project)
- [API Endpoints](#api-endpoints)
- [Building and Running the Application](#building-and-running-the-application)

## Requirements

- Docker
- Docker Compose


## Running the Project
To run the project, follow these steps:
1. Ensure Docker and Docker Compose are installed on your machine.
2. Clone the repository:
    ```sh
    git clone <repository-url>
    cd <repository-directory>
3. Build and start the application using Docker Compose:
    ```sh   
    docker-compose up --build
4. Access the application:
    * After setting up the project with Docker Compose, the application will be accessible at http://localhost:3000.

    * To check the Elasticsearch status, visit http://localhost:9200.
## API Endpoints
   
  # Applications 
  * Create an Application 
    ```sh 
    POST /applications

  * Request Body:
    ```sh
    {
        "application": {
            "name": "My Application"
            }
    }

  * Get an Application
    ```sh
     GET /applications/:token
  # Chats
  * List Chats
    ```sh
    GET /applications/:application_token/chats 
   

   * Create a Chat
        ```sh
        POST /applications/:application_token/chats
   * Get a Chat by Number
        ```sh
        GET /applications/:application_token/chats/:number
# Messages
* List Messages
    ```sh
    GET /applications/:application_token/chats/:chat_number/messages

* Create a Message
    ```sh
    POST /applications/:application_token/chats/:chat_number/messages
    Request Body:
        {
            "message": {
                "body": "Hello, world!"
            }
        }
* Search Messages
    ```sh
    GET /applications/:application_token/chats/:chat_number/messages/search?query=text
## Building and Running the Application
* To build and run the application, use the following command:
    ```sh
    docker-compose up --build
* This will start the MySQL, Elasticsearch, and Rails services, making the application accessible at http://localhost:3000.
