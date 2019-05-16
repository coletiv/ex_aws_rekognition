defmodule ExAws.Rekognition do
  @moduledoc """
  Operations on ExAws Rekognition
  """
  alias ExAws.Rekognition.S3Object
  alias ExAws.Rekognition.NotificationChannelObject

  #
  # https://docs.aws.amazon.com/rekognition/latest/dg/API_Operations.html
  #
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
    detect_labels: :post,
    detect_moderation_labels: :post,
    detect_text: :post,
    get_celebrity_info: :post,
    get_celebrity_recognition: :post,
    # get_content_moderation: :post,
    # get_face_detection: :post,
    # get_face_search: :post,
    # get_label_detection: :post,
    # get_person_tracking: :post,
    index_faces: :post,
    list_collections: :post,
    list_faces: :post,
    # list_stream_processors: :post,
    recognize_celebrities: :post,
    search_faces: :post,
    search_faces_by_image: :post,
    start_celebrity_recognition: :post
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

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec compare_faces(binary() | S3Object.t(), binary() | S3Object.t(), number()) ::
          %ExAws.Operation.JSON{}
  def compare_faces(source_image, target_image, similarity_threshold \\ 80)
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
  @spec create_collection(binary()) :: %ExAws.Operation.JSON{}
  def create_collection(collection_id) when is_binary(collection_id) do
    request(:create_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteCollection.html
  """
  @spec delete_collection(binary()) :: %ExAws.Operation.JSON{}
  def delete_collection(collection_id) when is_binary(collection_id) do
    request(:delete_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html
  """
  @spec delete_faces(binary(), list(binary())) :: %ExAws.Operation.JSON{}
  def delete_faces(collection_id, face_ids) when is_binary(collection_id) and is_list(face_ids) do
    request(:delete_faces, %{
      "CollectionId" => collection_id,
      "FaceIds" => face_ids
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html
  """
  @spec describe_collection(binary()) :: %ExAws.Operation.JSON{}
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
  @spec detect_faces(binary() | S3Object.t(), list(binary())) :: %ExAws.Operation.JSON{}
  def detect_faces(image, attributes \\ ["DEFAULT"]) when is_list(attributes) do
    request(:detect_faces, %{
      "Attributes" => attributes,
      "Image" => map_image(image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectLabels.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_labels(binary() | ExAws.Rekognition.S3Object.t(), nil | integer(), number()) ::
          %ExAws.Operation.JSON{}
  def detect_labels(image, max_labels \\ nil, min_confidence \\ 55)
      when (is_integer(max_labels) or is_nil(max_labels)) and is_number(min_confidence) do
    request(:detect_labels, %{
      "Image" => map_image(image),
      "MaxLabels" => max_labels,
      "MinConfidence" => min_confidence
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectModerationLabels.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_moderation_labels(binary() | ExAws.Rekognition.S3Object.t(), number()) ::
          %ExAws.Operation.JSON{}
  def detect_moderation_labels(image, min_confidence \\ 50) when is_number(min_confidence) do
    request(:detect_moderation_labels, %{
      "Image" => map_image(image),
      "MinConfidence" => min_confidence
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectText.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_text(binary() | S3Object.t()) :: %ExAws.Operation.JSON{}
  def detect_text(image) do
    request(:detect_text, %{
      "Image" => map_image(image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_IndexFaces.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec index_faces(
          binary(),
          binary() | ExAws.Rekognition.S3Object.t(),
          nil | binary(),
          list(binary()),
          nil | integer(),
          :auto | :none
        ) :: %ExAws.Operation.JSON{}
  def index_faces(
        collection_id,
        image,
        external_image_id \\ nil,
        detection_attributes \\ ["DEFAULT"],
        max_faces \\ 100,
        quality_filter \\ :auto
      )
      when is_binary(collection_id) and
             (is_binary(external_image_id) or is_nil(external_image_id)) and
             is_list(detection_attributes) and
             is_integer(max_faces) and max_faces > 1 and
             quality_filter in [:auto, :none] do
    request(:index_faces, %{
      "CollectionId" => collection_id,
      "DetectionAttributes" => detection_attributes,
      "ExternalImageId" => external_image_id,
      "Image" => map_image(image),
      "MaxFaces" => max_faces,
      "QualityFilter" => Atom.to_string(quality_filter) |> String.upcase()
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListCollections.html
  """
  @spec list_collections(nil | integer(), nil | binary()) :: %ExAws.Operation.JSON{}
  def list_collections(max_results \\ nil, next_token \\ nil)
      when (is_integer(max_results) or is_nil(max_results)) and
             (is_binary(next_token) or is_nil(next_token)) do
    request(:list_collections, %{
      "MaxResults" => max_results,
      "NextToken" => next_token
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListFaces.html
  """
  @spec list_faces(binary(), nil | integer(), nil | binary()) :: %ExAws.Operation.JSON{}
  def list_faces(collection_id, max_results \\ nil, next_token \\ nil)
      when is_binary(collection_id) and
             (is_integer(max_results) or is_nil(max_results)) and
             (is_binary(next_token) or is_nil(next_token)) do
    request(:list_faces, %{
      "CollectionId" => collection_id,
      "MaxResults" => max_results,
      "NextToken" => next_token
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetCelebrityInfo.html
  """
  @spec get_celebrity_info(binary()) :: %ExAws.Operation.JSON{}
  def get_celebrity_info(id) when is_binary(id) do
    request(:get_celebrity_info, %{
      "Id" => id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetCelebrityRecognition.html
  """
  @spec get_celebrity_recognition(binary(), pos_integer(), nil | binary(), :id | :timestamp) ::
          %ExAws.Operation.JSON{}
  def get_celebrity_recognition(job_id, max_results \\ 1000, next_token \\ nil, sort_by \\ :id)
      when is_binary(job_id) and
             (is_integer(max_results) and max_results > 0) and
             (is_binary(next_token) or is_nil(next_token)) and
             sort_by in [:id, :timestamp] do
    request(:get_celebrity_recognition, %{
      "JobId" => job_id,
      "MaxResults" => max_results,
      "NextToken" => next_token,
      "SortBy" => Atom.to_string(sort_by) |> String.upcase()
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_RecognizeCelebrities.html
  """
  @spec recognize_celebrities(binary() | ExAws.Rekognition.S3Object.t()) ::
          %ExAws.Operation.JSON{}
  def recognize_celebrities(image) do
    request(:recognize_celebrities, %{
      "Image" => map_image(image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_SearchFaces.html
  """
  @spec search_faces(binary(), binary(), number(), integer()) :: %ExAws.Operation.JSON{}
  def search_faces(collection_id, face_id, face_match_threshold \\ 80, max_faces \\ 100)
      when is_binary(collection_id) and is_binary(face_id) and
             is_number(face_match_threshold) and is_integer(max_faces) do
    request(:search_faces, %{
      "CollectionId" => collection_id,
      "FaceId" => face_id,
      "FaceMatchThreshold" => face_match_threshold,
      "MaxFaces" => max_faces
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_SearchFacesByImage.html

  NOTE: When using an S3Object, you may need to insure that
  the S3 uses the same region as Rekognition
  """
  @spec search_faces_by_image(
          binary(),
          binary() | ExAws.Rekognition.S3Object.t(),
          number(),
          integer()
        ) :: %ExAws.Operation.JSON{}
  def search_faces_by_image(collection_id, image, face_match_threshold \\ 80, max_faces \\ 100)
      when is_binary(collection_id) and
             is_number(face_match_threshold) and is_integer(max_faces) do
    request(:search_faces_by_image, %{
      "CollectionId" => collection_id,
      "Image" => map_image(image),
      "FaceMatchThreshold" => face_match_threshold,
      "MaxFaces" => max_faces
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartCelebrityRecognition.html
  """
  @spec start_celebrity_recognition(
          ExAws.Rekognition.S3Object.t(),
          nil | binary(),
          nil | binary(),
          nil | ExAws.Rekognition.NotificationChannelObject.t()
        ) :: %ExAws.Operation.JSON{}
  def start_celebrity_recognition(
        video,
        client_request_token \\ nil,
        job_tag \\ nil,
        notification_channel \\ nil
      )
      when (is_binary(client_request_token) or is_nil(client_request_token)) and
             (is_binary(job_tag) or is_nil(job_tag)) do
    request(:start_celebrity_recognition, %{
      "ClientRequestToken" => client_request_token,
      "JobTag" => job_tag,
      "NotificationChannel" => NotificationChannelObject.map(notification_channel),
      "Video" => S3Object.map(video)
    })
  end

  # Utility

  defp map_image(image) when is_binary(image) do
    %{"Bytes" => Base.encode64(image)}
  end

  defp map_image(%S3Object{} = object) do
    S3Object.map(object)
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
