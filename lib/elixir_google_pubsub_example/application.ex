defmodule ElixirGooglePubsubExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    # Starts a worker by calling: ElixirGooglePubsubExample.Worker.start_link(arg)
    # {ElixirGooglePubsubExample.Worker, arg},
    children =
      case Application.get_env(:elixir_google_pubsub_example, :pubsub_role) do
        :publisher -> [{ElixirGooglePubsubExample.Publisher, []}]
        :subscriber -> [{ElixirGooglePubsubExample.Subscriber, []}]
        _ -> []
      end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirGooglePubsubExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
