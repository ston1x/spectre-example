# README

## Installation
1. Clone

    `https://github.com/ston1x/spectre-example.git`

2. Navigate to the project directory

    `$ cd spectre-example`

3. Execute

    `$ bundle install`

4. Create .env file in the root of the project and set the environment variables according to the .env.dist file:

    `$ cp .env.dist .env`


5. Create and migrate the db:

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
