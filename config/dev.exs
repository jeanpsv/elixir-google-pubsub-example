use Mix.Config

config :elixir_google_pubsub_example,
  env: :dev,
  gcp_project_id: System.get_env("GCP_PROJECT_ID"),
  pubsub_topic: System.get_env("PUBSUB_TOPIC"),
  pubsub_role: System.get_env("PUBSUB_ROLE") |> String.to_atom,
  name: System.get_env("NAME"),
  interval: System.get_env("INTERVAL")

config :logger,
  level: :info

config :google_api_pub_sub, :base_url, System.get_env("PUBSUB_HOST")
