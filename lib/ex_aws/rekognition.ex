defmodule ExAws.Rekognition do
  @moduledoc """
  Operations on ExAws Rekognition
  """
  alias ExAws.Rekognition.S3Object

  @actions %{
    compare_faces: :post,
    delete_faces: :post,
    detect_faces: :post,
    create_collection: :post,
    delete_collection: :post,
    describe_collection: :post,
    list_collections: :post,
    detect_text: :post
  }

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_CompareFaces.html
  """
  @spec compare_faces(binary() | S3Object.t(), binary() | S3Object.t(), number()) :: %{
          optional(any) => any
        }
  def compare_faces(source_image, target_image, similarity_threshold \\ 0.8)
      when is_number(similarity_threshold) do
    request(:compare_faces, %{
      "SimilarityThreshold" => similarity_threshold,
      "SourceImage" => map_image(source_image),
      "TargetImage" => map_image(target_image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html
  """
  @spec delete_faces(binary(), maybe_improper_list()) :: %{optional(any) => any}
  def delete_faces(collection_id, face_ids) when is_binary(collection_id) and is_list(face_ids) do
    request(:delete_collection, %{
      "CollectionId" => collection_id,
      "FaceIds" => face_ids
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectFaces.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_faces(maybe_improper_list(), binary() | S3Object.t()) :: %{optional(any) => any}
  def detect_faces(attributes \\ ["DEFAULT"], image) when is_list(attributes) do
    request(:detect_faces, %{
      "Attributes" => attributes,
      "Image" => map_image(image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateCollection.html
  """
  @spec create_collection(binary()) :: %{optional(any) => any}
  def create_collection(collection_id) when is_binary(collection_id) do
    request(:create_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteCollection.html
  """
  @spec delete_collection(binary()) :: %{optional(any) => any}
  def delete_collection(collection_id) when is_binary(collection_id) do
    request(:delete_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html
  """
  @spec describe_collection(binary()) :: %{optional(any) => any}
  def describe_collection(collection_id) when is_binary(collection_id) do
    request(:delete_collection, %{
      "CollectionId" => collection_id
    })
  end

  def list_collections(next_token \\ nil, max_results \\ nil)

  def list_collections(nil, nil) do
    request(:list_collections, %{})
  end

  def list_collections(next_token, nil) do
    request(:list_collections, %{
      "NextToken" => next_token
    })
  end

  def list_collections(nil, max_results) do
    request(:list_collections, %{
      "MaxResults" => max_results
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListCollections.html
  """
  @spec list_collections(integer(), binary()) :: %{optional(any) => any}
  def list_collections(next_token, max_results)
      when is_binary(next_token) and is_integer(max_results) do
    request(:list_collections, %{
      "MaxResults" => max_results,
      "NextToken" => next_token
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectText.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_text(binary() | S3Object.t()) :: %{optional(any) => any}
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
