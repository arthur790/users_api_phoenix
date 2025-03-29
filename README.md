# Required libraries

- Phoenix framework: Required to build API
- Ecto: Required for postgres database
- Commanded: Required to implement CQRS / ES (Configured to use EventStore postgres event store database)
- Guardian: Required to handle JWT for authentication

# UsersBackend

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).


## see routes
mix phx.routes

## Documentation
about de api, the documentation is in postman, link: https://documenter.getpostman.com/view/27525327/2sB2cPj5aP