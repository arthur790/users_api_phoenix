# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :users_backend,
  ecto_repos: [UsersBackend.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :users_backend, UsersBackendWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: UsersBackendWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: UsersBackend.PubSub,
  live_view: [signing_salt: "EHETk7Lf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :users_backend, UsersBackend.App,
  event_store: [
    adapter: Commanded.EventStore.Adapters.EventStore,
    event_store: UsersBackend.EventStore
  ],
  pubsub: :local,
  registry: :local

#config :commanded_ecto_projections, repo: UsersBackend.Repo

config :users_backend, event_stores: [UsersBackend.EventStore]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
