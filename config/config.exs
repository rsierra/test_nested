# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :test_nested,
  ecto_repos: [TestNested.Repo]

# Configures the endpoint
config :test_nested, TestNestedWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GiBYQuOZ+WRVI+Y3taYE0uQjiXKVM0+4Av6RIrqgKKCClOyA5DmwKQ8gn7Avck99",
  render_errors: [view: TestNestedWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TestNested.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
