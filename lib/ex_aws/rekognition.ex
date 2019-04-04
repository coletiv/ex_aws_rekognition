defmodule ExAws.Rekognition do
  @moduledoc """
  Operations on ExAws Rekognition
  """

  @actions %{
    detect_text: :post
  }

  def detect_text(image) when is_binary(image) do
    image_64 =
      image
      |> Base.encode64()

    data = %{
      "Image" => %{
        "Bytes" => image_64
      }
    }

    request(:detect_text, data)
  end

  def detect_text(s3_object_bucket, s3_object_name, s3_object_version \\ nil) do
    data = %{
      "Image" => %{
        "S3Object" => %{
          "Bucket" => s3_object_bucket,
          "Name" => s3_object_name,
          "Version" => s3_object_version
        }
      }
    }

    request(:detect_text, data)
  end

  defp request(action, data) do
    http_method = @actions |> Map.fetch!(action)

    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    ExAws.Operation.JSON.new(:rekognition, %{
      http_method: http_method,
      data: data,
      headers: [
        {"content-type", "application/x-amz-json-1.1"},
        {"x-amz-target", "RekognitionService.#{operation}"}
      ]
    })
  end
end
