defmodule ExAws.Rekognition.NotificationChannelObject do
  defstruct [:role_arn, :sns_topic_arn]

  alias ExAws.Rekognition.NotificationChannelObject

  def map(%NotificationChannelObject{} = object) do
    %{
      "RoleArn" => object.role_arn,
      "SNSTopicArn" => object.sns_topic_arn
    }
  end

  def map(nil) do
    nil
  end
end
