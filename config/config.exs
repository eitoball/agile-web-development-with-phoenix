# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :demo, Demo.Endpoint,
  url: [host: "localhost"],
  root: Path.expand("..", __DIR__),
  secret_key_base: "hRtQZ9TB0EHnDQrL0lW/UKVFxgAAsC2dt28zrKZKf0ERU/8ypxvKB/xcY9LktmhH",
  debug_errors: false,
  pubsub: [name: Demo.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
