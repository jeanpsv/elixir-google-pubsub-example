defmodule ElixirGooglePubsubExample.Subscriber do
  use Task
  require Logger
  alias ElixirGooglePubsubExample.GooglePubsub

  def start_link(_arg), do: Task.start_link(__MODULE__, :run, [])

  def run do
    interval =
      Application.get_env(:elixir_google_pubsub_example, :interval)
      |> String.to_integer
    receive do
    after
      interval ->
        pull()
        run()
    end
  end

  defp pull do
    project_id = Application.get_env(:elixir_google_pubsub_example, :gcp_project_id)
    topic_name = Application.get_env(:elixir_google_pubsub_example, :pubsub_topic)
    subscription_name  = Application.get_env(:elixir_google_pubsub_example, :name)

    {:ok, _topic} = GooglePubsub.get_or_create_topic(project_id, topic_name)
    {:ok, _subscription} = GooglePubsub.get_or_create_subscription(project_id, topic_name, subscription_name)
    {:ok, response} = GooglePubsub.pull_message(project_id, subscription_name)
    case GooglePubsub.pull_message(project_id, subscription_name) do
      {:ok, :no_messages} -> Logger.info "#{subscription_name} === no messages"
      {:ok, messages} -> print_message(messages)
    end
  end

  defp print_message([first | others]) do
    do_print_message(first)
    print_message(others)
  end

  defp print_message([]), do: nil

  defp do_print_message(%GoogleApi.PubSub.V1.Model.PubsubMessage{data: data, messageId: messageId}) do
    {:ok, decoded} = Base.decode64(data)
    Logger.info "#{messageId} === #{decoded}"
  end
end
