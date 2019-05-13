defmodule ExAws.Rekognition do
  @moduledoc """
  Operations on ExAws Rekognition
  """
  alias ExAws.Rekognition.S3Object

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_Operations.html
  @actions %{
    compare_faces: :post,
    create_collection: :post,
    # create_stream_processor: :post,
    delete_collection: :post,
    delete_faces: :post,
    # delete_stream_processor: :post,
    describe_collection: :post,
    # describe_stream_processor: :post,
    detect_faces: :post,
    # detect_labels: :post,
    # detect_moderation_labels: :post,
    detect_text: :post,
    # get_celebrity_info: :post,
    # get_celebrity_recognition: :post,
    # get_content_moderation: :post,
    # get_face_detection: :post,
    # get_face_search: :post,
    # get_label_detection: :post,
    # get_person_tracking: :post,
    # index_faces: :post,
    list_collections: :post
    # list_faces: :post,
    # list_stream_processors: :post,
    # recognize_celebrities: :post,
    # search_faces: :post,
    # search_faces_by_image: :post,
    # start_celebrity_recognition: :post,
    # start_content_moderation: :post,
    # start_face_detection: :post,
    # start_face_search: :post,
    # start_label_detection: :post,
    # start_person_tracking: :post,
    # start_stream_processor: :post,
    # stop_stream_processor: :post
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
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html
  """
  @spec delete_faces(binary(), maybe_improper_list()) :: %{optional(any) => any}
  def delete_faces(collection_id, face_ids) when is_binary(collection_id) and is_list(face_ids) do
    request(:delete_faces, %{
      "CollectionId" => collection_id,
      "FaceIds" => face_ids
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html
  """
  @spec describe_collection(binary()) :: %{optional(any) => any}
  def describe_collection(collection_id) when is_binary(collection_id) do
    request(:describe_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectFaces.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_faces(binary() | S3Object.t(), maybe_improper_list()) :: %{optional(any) => any}
  def detect_faces(image, attributes \\ ["DEFAULT"]) when is_list(attributes) do
    request(:detect_faces, %{
      "Attributes" => attributes,
      "Image" => map_image(image)
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

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListCollections.html
  """
  @spec list_collections(nil | binary(), nil | integer()) :: %{
          :__struct__ => atom(),
          optional(atom()) => any()
        }
  def list_collections(next_token \\ nil, max_results \\ nil)
      when (is_binary(next_token) or is_nil(next_token)) and
             (is_integer(max_results) or is_nil(max_results)) do
    request(:list_collections, %{
      "NextToken" => next_token,
      "MaxResults" => max_results
    })
  end

  # Utility

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
