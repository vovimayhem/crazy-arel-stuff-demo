# Crazy Arel Stuff Demo

## Running this demo

This demo is made to work with Docker. If you haven't installed it yet, check out [Docker for Mac](https://docs.docker.com/docker-for-mac/), [Docker for Windows](https://docs.docker.com/docker-for-windows/) or [run it natively if your'e using Linux](https://docs.docker.com/engine/installation/linux/). You'll also need to install [Docker Compose](https://docs.docker.com/compose/install) to bring up all the services and follow the walkthrough.

Once your'e ready, you can clone & start the project:

```bash
git clone https://github.com/vovimayhem/crazy-arel-stuff-demo.git \
  && cd crazy-arel-stuff-demo \
  && docker-compose run --rm app bash
  
# That will take you into the app container... then...

# TODO: make the `create_type` migration appear in the schema.rb file... so we can use db:setup...
rails db:create
rails db:migrate

exit
```

## Ruby version, system dependencies

This demo uses Ruby 2.3.1, and NodeJS installed as the Javascript Runtime. You shouldn't need to install these, as your'e already using

If you want more details, you can check out the project's [dev.Dockerfile](https://github.com/vovimayhem/crazy-arel-stuff-demo/blob/master/dev.Dockerfile).

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
