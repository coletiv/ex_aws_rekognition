defmodule ExAws.Rekognition do
  @moduledoc """
  Operations on ExAws Rekognition
  """
  alias S3Object

  @actions %{
    compare_faces: :post,
    delete_faces: :post,
    detect_faces: :post,
    create_collection: :post,
    delete_collection: :post,
    describe_collection: :post,
    detect_text: :post
  }

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_CompareFaces.html
  def compare_faces(similarity_threshold, source_image, target_image) do
    request(:compare_faces, %{
      "SimilarityThreshold" => similarity_threshold,
      "SourceImage" => map_image(source_image),
      "TargetImage" => map_image(target_image)
    })
  end

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html
  def delete_faces(collection_id, face_ids) when is_binary(collection_id) and is_list(face_ids) do
    request(:delete_collection, %{
      "CollectionId" => collection_id,
      "FaceIds" => face_ids
    })
  end

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectFaces.html
  def detect_faces(attributes, image) when is_list(attributes) do
    request(:detect_faces, %{
      "Attributes" => attributes,
      "Image" => map_image(image)
    })
  end

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateCollection.html
  def create_collection(collection_id) when is_binary(collection_id) do
    request(:create_collection, %{
      "CollectionId" => collection_id
    })
  end

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteCollection.html
  def delete_collection(collection_id) when is_binary(collection_id) do
    request(:delete_collection, %{
      "CollectionId" => collection_id
    })
  end

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html
  def describe_collection(collection_id) when is_binary(collection_id) do
    request(:delete_collection, %{
      "CollectionId" => collection_id
    })
  end

  def detect_text(image) do
    request(:detect_text, %{
      "Image" => map_image(image)
    })
  end

  defp map_image(image) when is_binary(image) do
    %{"Bytes" => Base.encode64(image)}
  end

  defp map_image(%S3Object{} = object) do
    %{
      "S3Object" => %{
        "Bucket" => object.bucket,
        "Name" => object.name,
        "Version" => object.version
      }
    }
  end

  defp request(action, data) do
    http_method = @actions |> Map.fetch!(action)

    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    headers = [
      {"content-type", "application/x-amz-json-1.1"},
      {"x-amz-target", "RekognitionService.#{operation}"}
    ]

    ExAws.Operation.JSON.new(:rekognition, %{
      http_method: http_method,
      data: data,
      headers: headers
    })
  end
end
