## Introduction

The `burning-bush-api` was part of my Computer Engineering graduation project. It is a Ruby on Rails API that serves the [burning-bush-web](https://github.com/Gfreschi/burning-bush-web) Next.js application. The API is responsible for handling user authentication and authorization, as well as storing and retrieving data from the database, necessary for the application to function. Its also possible to perform data analysis and classification using a Decision Tree algorithm.

The API is not finished and is not deployed.

## Key Features

- Authentication and authorization (Devise and Doorkeeper)
- Data analysis and classification (Desision Tree) (not finished)
- Geolocation (Geocoder)
- General CRUD operations

## Technologies and gems used

- Ruby on Rails
- SQLite
- Sidekiq
- Redis
- Devise
- Doorkeeper
- Geocoder
- Decision Tree
- RSpec

## Getting Started

First, bundle and install dependencies:

```bash
bundle
```

Then, run the development server:

```bash
rails s

```

### License
This project is licensed under the [MIT LICENSE]. For more details, please see the LICENSE file.
