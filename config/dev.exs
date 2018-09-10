use Mix.Config

config :elixir_google_pubsub_example, :env, :dev

config :logger,
  level: :info

config :google_api_pub_sub, :base_url, System.get_env("PUBSUB_HOST")
