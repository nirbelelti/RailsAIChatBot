# RailsChatBot

## Description

RailsChatBot is a Ruby on Rails application that provides a real-time chat interface for users. 
This application integrates Devise for user authentication, ensuring secure access, and utilizes Turbo Rails for smooth,
dynamic interactions, allowing messages to update without refreshing the page.

The core functionality of RailsChatBot demonstrates seamless communication with the Gemini API, a powerful language 
generation tool. Through an initializer, the application establishes a connection with the Gemini API, sending user queries
and receiving intelligent, conversational responses. This setup highlights how Rails applications can efficiently leverage
external APIs for enhanced functionality and user engagement within a Turbo-powered chat interface.
## Features

- User authentication with Devise
- CRUD operations for chats utilize Turbo Rails and Hot wire
- Integration with the Gemini API for language generation
- Dynamic interactions with Turbo Rails
- Real-time chat interface
- Responsive design with Bootstrap CSS
- Asynchronously views rendering with Hotwire
- RSpec tests for models, requests, and routes

## Requirements

- Ruby 3.0.2
- Rails 7.2.0
- PostgreSQL
- Redis
- Gemini API key
- Bundler
- Yarn
- Node.js (npm)

## Setup

1. **Clone the repository**:
   ```sh
   git clone https://github.com/yourusername/rails_chat_bot.git
   cd rails_chat_bot
   
    ```
2. **Install dependencies**:
3. **Install dependencies**:
   ```sh
   bundle install
   yarn install
   ```
4. **Create the database and seed**:
   ```sh 
     rails db:prepare
   ```
   FYI: This command will create the database, load the schema, and initialize it with the seed data. For demonstration
purposes, the seed data includes a user with the following credentials: email: 'email@email.com', password: 'Password'
5. **Set up the Gemini API key**:
   - Create a `.env` file in the root directory.
   - Add the following line to the `.env` file
   
6. **Start the server**:
   ```sh
   rails server OR bin/dev
   ```
7. **Start the Redis server**:
   ```sh 
    redis-server
    ```
8. **Start the Sidekiq server**:
   ```sh
    bundle exec sidekiq
    ```
9. **Access the application**: The application will be available at `http://localhost:3000`.

## Testing
 Run the RSpec tests with the following command:
 ```sh
    rspec
 ```
The tests include model, request, and routing specs, ensuring the application's core functionality is working as expected.

