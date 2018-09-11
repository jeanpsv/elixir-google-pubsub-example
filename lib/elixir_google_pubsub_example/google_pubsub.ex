defmodule ElixirGooglePubsubExample.GooglePubsub do

  def list_topics(project_id) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_topics_list(project_id)
  end

  def get_topic(project_id, topic_name) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_topics_get(project_id, topic_name)
  end

  def create_topic(project_id, topic_name) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_topics_create(project_id, topic_name, [body: %{}])
  end

  def get_or_create_topic(project_id, topic_name) do
    case get_topic(project_id, topic_name) do
      {:ok, topic} -> {:ok, topic}
      {:error, _} -> create_topic(project_id, topic_name)
    end
  end

  def publish_message(project_id, topic_name, message) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_topics_publish(project_id, topic_name, [body: build_publish_request(message)])
  end

  def list_subscriptions(project_id) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_subscriptions_list(project_id)
  end

  def get_subscription(project_id, subscription_name) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_subscriptions_get(project_id, subscription_name)
  end

  def create_subscription(project_id, topic_name, subscription_name) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_subscriptions_create(project_id, subscription_name, [body: %{ topic: "projects/#{project_id}/topics/#{topic_name}"}])
  end

  def get_or_create_subscription(project_id, topic_name, subscription_name) do
    case get_subscription(project_id, subscription_name) do
      {:ok, subscription} -> {:ok, subscription}
      {:error, _} -> create_subscription(project_id, topic_name, subscription_name)
    end
  end

  def pull_message(project_id, subscription_name) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_subscriptions_pull(project_id, subscription_name, [body: build_pull_request()])
  end

  def ack_message(project_id, subscription_name, message_id) do
    create_new_pubsub_connection()
    |> GoogleApi.PubSub.V1.Api.Projects.pubsub_projects_subscriptions_acknowledge(project_id, subscription_name, [body: build_acknowledge_request(message_id)])
  end

  defp create_new_pubsub_connection, do: GoogleApi.PubSub.V1.Connection.new

  defp build_publish_request(message) do
    %GoogleApi.PubSub.V1.Model.PublishRequest{
      messages: [
        %GoogleApi.PubSub.V1.Model.PubsubMessage{
          data: Base.encode64(message)
        }
      ]
    }
  end

  defp build_pull_request do
    %GoogleApi.PubSub.V1.Model.PullRequest{
      maxMessages: 1
    }
  end

  defp build_acknowledge_request(message_id) do
    %GoogleApi.PubSub.V1.Model.AcknowledgeRequest{
      ackIds: [message.ackId]
    }
  end
end
