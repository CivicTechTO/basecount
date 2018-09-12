# Basecount
Helping respite centres communicate their population counts. This is a **citizen-led** project.

## Starting the app

## Technologies Used
- [**Ruby on Rails**](https://rubyonrails.org/)
- [**Node JS**](https://nodejs.org/)
- [**React**](https://reactjs.org/)

### Requirements
- ruby 2.4.4
  - using [rvm](https://rvm.io/) or [rbenv](https://github.com/rbenv/rbenv) is recommended
- node JS v >= 8

### Local Development
```
  bundle install;
  cd client; 
  npm install;
  cd ../;
  rake db:create db:setup;
  bundle exec foreman start;
```

`foreman` will start the back end, as well as the front end with hot reloading. The site will be served on port 3000, with the rails server at 3001 being proxied into 3000.

During development, you may need to 
 todo: env.development

### Testing
```
  rails test;
```

### Diagrams
Diagrams are edited using [Draw.io](https://www.draw.io/)

- [Database Diagram](https://github.com/CivicTechTO/basecount/blob/master/diagrams/backend.png)

## :muscle: Contributing

Please make sure to read the [Contributing Guide](CONTRIBUTING.md) before making a pull request.

## :copyright: License

[MIT](http://opensource.org/licenses/MIT)