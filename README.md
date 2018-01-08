# Toronto Shelter Map

Mapping the capacity and current occupancy of City of Toronto emergency shelters.

This app is currently populated with **dummy data**.

This is a **citizen-led** project.

## Technologies Used

* [**Jekyll.**][jekyll] A static HTML website generator.
* [**GitHub Pages.**][gh-pages] A Jekyll website-hosting service provided by GitHub.
* [**Leaflet.**][leaflet] A JavaScript library for mobile-friendly interactive maps.

## :computer: Local Development

### Requirements

* Ruby 2.3+
* `rbenv` (optional)

### Setup

You'll first need to ensure you are using a compatible version of Ruby.
We recommend managing Ruby versions with `rbenv`. (Installing and
setting ruby versions is out of scope of these instructions.)

```
ruby --version
>>> ruby 2.3.0p0 (2015-12-25 revision 53290) [x86_64-linux]
git clone https://github.com/patcon/toronto-shelter-map
bundle install
bundle exec jekyll serve
```

## :muscle: Contributing

Please make sure to read the [Contributing Guide](CONTRIBUTING.md) before making a pull request.

## :copyright: License

[MIT](http://opensource.org/licenses/MIT)

<!-- Links -->
   [leaflet]: http://leafletjs.com/
   [gh-pages]: https://help.github.com/articles/what-is-github-pages/
   [jekyll]: https://jekyllrb.com/docs/home/
