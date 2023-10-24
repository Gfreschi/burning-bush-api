## Introduction

The `burning-bush-web` and `burning-bush-api` was part of the construction of my Computer Engineering graduation project.

The idea behind the project is to create a web application that allows users to report environmental incidents and crimes. The application is intended to be used by the general public, as well as by the authorities responsible for the environment.
In summary, an individual connected to the internet would be able to anonymously disseminate and report a specific incident in such a way that ecosystem control and oversight are highlighted in the media for the relevant authorities. The application is premised on the use by registered individuals, enabling them to easily and swiftly file complaints. The system relies on the regular input of data by various users; consequently, the more reports are submitted, the greater the emphasis on a particular incident. With the goal of spreading information, the primary aim is to achieve better control over crimes and environmental incidents, always focusing on the preservation of nature.

It is a Ruby on Rails API that serves the [burning-bush-web](https://github.com/Gfreschi/burning-bush-web) Next.js application. The API is responsible for handling user authentication and authorization, as well as storing and retrieving data from the database, necessary for the application to function. Its also possible to perform data analysis and classification using a Decision Tree algorithm.

The API remains unfinished.

## Key Features

- Authentication and authorization (Devise and Doorkeeper)
- Data analysis and classification (Decision tree) [WIP]
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
This project is licensed under the terms of the [MIT license](https://github.com/Gfreschi/burning-bush-api/blob/main/LICENSE).
