# README

## Installation
1. Navigate to the directory where you want to store the app:

    `$ cd ~/dev`
    
2. Type:

    `$ git init`
    
3. Clone this repository:

    `https://github.com/ston1x/spectre-example.git`
    
4. Navigate to the repo directory:

    `$ cd spectre-example`

5. Execute:

    `$ bundle install`

6. Create .env file in the root of the project and set the environment variables according to the .env.dist file:

    `$ cp .env.dist .env`

7. Start the Rails server:

    `$ rails server`
    
8. Don't forget to create and migrate the db:

    `$ rails db:create`
    `$ rails db:migrate`

## Usage
1. Execute `$ rails server`

2. Go to `localhost:3000` in your web browser

### Before you start the app
Make sure you have installed:
* Ruby 2.5.0 or later
* Rails 5.2.0 or later
* PostgreSQL