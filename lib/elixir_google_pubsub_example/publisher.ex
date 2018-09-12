defmodule ElixirGooglePubsubExample.Publisher do
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
        publish()
        run()
    end
  end

  defp publish do
    project_id = Application.get_env(:elixir_google_pubsub_example, :gcp_project_id)
    topic_name = Application.get_env(:elixir_google_pubsub_example, :pubsub_topic)
    publisher_name = Application.get_env(:elixir_google_pubsub_example, :name)
    current_millis = :os.system_time(:millisecond)
    message = "#{publisher_name} === #{current_millis}"

    {:ok, _topic} = GooglePubsub.get_or_create_topic(project_id, topic_name)
    {:ok, _publish_response} = GooglePubsub.publish_message(project_id, topic_name, message)
    Logger.info message
  end
end
