defmodule ElixirGooglePubsubExample do
  @moduledoc """
  Documentation for ElixirGooglePubsubExample.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ElixirGooglePubsubExample.hello()
      :world

  """
  def hello do
    :world
  end

  def test do
    IO.puts "set project id"
    project_id = System.get_env("GCP_PROJECT_ID")
    IO.puts "configure client"
    client = GoogleApi.PubSub.V1.Connection.new()
    IO.puts "get topics"
    {:ok, topics} =
      client
      |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_topics_list(project_id)
    IO.puts "show topics"
    IO.inspect topics
  end
end
