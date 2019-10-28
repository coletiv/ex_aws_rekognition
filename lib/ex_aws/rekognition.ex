defmodule ExAws.Rekognition do
  @moduledoc """
  Operations on ExAws Rekognition
  """
  use ExAws.Utils,
    format_type: :json,
    non_standard_keys: %{}

  alias ExAws.Rekognition.S3Object
  alias ExAws.Rekognition.NotificationChannelObject

  # https://docs.aws.amazon.com/rekognition/latest/dg/API_Operations.html

  @type image :: binary() | S3Object.t()

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_CompareFaces.html

  NOTE: When using an S3Object, you may need to ensure that
  the S3 uses the same region as Rekognition
  """
  @type compare_faces_opt :: {:similarity_threshold, 0..100}
  @spec compare_faces(image(), image()) :: ExAws.Operation.JSON.t()
  @spec compare_faces(image(), image(), list(compare_faces_opt())) :: ExAws.Operation.JSON.t()
  def compare_faces(source_image, target_image, opts \\ []) do
    request(:compare_faces, %{
      "SourceImage" => map_image(source_image),
      "TargetImage" => map_image(target_image)
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateCollection.html
  """
  @spec create_collection(binary()) :: ExAws.Operation.JSON.t()
  def create_collection(collection_id) when is_binary(collection_id) do
    request(:create_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateStreamProcessor.html
  """
  @type create_stream_processor_opt :: {:collection_id, binary()} | {:face_match_threshold, 0..100}
  @spec create_stream_processor(binary(), binary(), binary(), binary()) :: ExAws.Operation.JSON.t()
  @spec create_stream_processor(binary(), binary(), binary(), binary(), list(create_stream_processor_opt())) :: ExAws.Operation.JSON.t()
  def create_stream_processor(input, output, name, role_arn, opts \\ [])
      when is_binary(input) and is_binary(output) and is_binary(name) and is_binary(role_arn) do
    request(:create_stream_processor, %{
      "Input" => %{
        "KinesisVideoStream" => %{
          "Arn" => input
        }
      },
      "Name" => name,
      "Output" => %{
        "KinesisDataStream" => %{
          "Arn" => output
        }
      },
      "RoleArn" => role_arn,
      "Settings" => %{
        "FaceSearch" => camelize_keys(opts)
      }
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteCollection.html
  """
  @spec delete_collection(binary()) :: ExAws.Operation.JSON.t()
  def delete_collection(collection_id) when is_binary(collection_id) do
    request(:delete_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html
  """
  @spec delete_faces(binary(), list(binary())) :: ExAws.Operation.JSON.t()
  def delete_faces(collection_id, face_ids) when is_binary(collection_id) and is_list(face_ids) do
    request(:delete_faces, %{
      "CollectionId" => collection_id,
      "FaceIds" => face_ids
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteStreamProcessor.html
  """
  @spec delete_stream_processor(binary()) :: ExAws.Operation.JSON.t()
  def delete_stream_processor(name) when is_binary(name) do
    request(:delete_stream_processor, %{
      "Name" => name
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html
  """
  @spec describe_collection(binary()) :: ExAws.Operation.JSON.t()
  def describe_collection(collection_id) when is_binary(collection_id) do
    request(:describe_collection, %{
      "CollectionId" => collection_id
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeStreamProcessor.html
  """
  @spec describe_stream_processor(binary()) :: ExAws.Operation.JSON.t()
  def describe_stream_processor(name) when is_binary(name) do
    request(:describe_stream_processor, %{
      "Name" => name
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectFaces.html

  NOTE: When using an S3Object, you may need to ensure that
  the S3 uses the same region as Rekognition
  """
  @type detect_faces_opt :: {:attributes, list(binary())}
  @spec detect_faces(image()) :: ExAws.Operation.JSON.t()
  @spec detect_faces(image(), list(detect_faces_opt())) :: ExAws.Operation.JSON.t()
  def detect_faces(image, opts \\ []) do
    request(:detect_faces, %{
      "Image" => map_image(image)
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectLabels.html

  NOTE: When using an S3Object, you may need to ensure that
  the S3 uses the same region as Rekognition
  """
  @type detect_labels_opt :: {:max_labels, non_neg_integer()} | {:min_confidence, 0..100}
  @spec detect_labels(image()) :: ExAws.Operation.JSON.t()
  @spec detect_labels(image(), list(detect_labels_opt())) :: ExAws.Operation.JSON.t()
  def detect_labels(image, opts \\ []) do
    request(:detect_labels, %{
      "Image" => map_image(image)
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectModerationLabels.html

  NOTE: When using an S3Object, you may need to ensure that
  the S3 uses the same region as Rekognition
  """
  @type detect_moderation_labels_opt :: {:min_confidence, 0..100}
  @spec detect_moderation_labels(image()) :: ExAws.Operation.JSON.t()
  @spec detect_moderation_labels(image(), list(detect_moderation_labels_opt())) :: ExAws.Operation.JSON.t()
  def detect_moderation_labels(image, opts \\ []) do
    request(:detect_moderation_labels, %{
      "Image" => map_image(image)
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectText.html

  NOTE: When using an S3Object, you may need to ensure that
  the S3 uses the same region as Rekognition
  """
  @spec detect_text(image()) :: ExAws.Operation.JSON.t()
  def detect_text(image) do
    request(:detect_text, %{
      "Image" => map_image(image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_IndexFaces.html

  NOTE: When using an S3Object, you may need to ensure that
  the S3 uses the same region as Rekognition
  """
  @type index_faces_opt :: {:external_image_id, binary()} | {:detection_attributes, list(binary())} | {:max_faces, pos_integer()} | {:quality_filter, :auto | :none}
  @spec index_faces(binary(), image()) :: ExAws.Operation.JSON.t()
  @spec index_faces(binary(), image(), list(index_faces_opt())) :: ExAws.Operation.JSON.t()
  def index_faces(collection_id, image, opts \\ []) when is_binary(collection_id) do
    request(:index_faces, %{
      "CollectionId" => collection_id,
      "Image" => map_image(image),
    } |> Map.merge(opts |> stringify_enum_opts([:quality_filter]) |> camelize_keys()))
  end

  @type list_opt :: {:max_results, 0..4096} | {:next_token, binary()}

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListCollections.html
  """
  @type list_collections_opt :: list_opt()
  @spec list_collections() :: ExAws.Operation.JSON.t()
  @spec list_collections(list(list_collections_opt())) :: ExAws.Operation.JSON.t()
  def list_collections(opts \\ []) do
    request(:list_collections, camelize_keys(opts))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListFaces.html
  """
  @type list_faces_opt :: list_opt()
  @spec list_faces(binary()) :: ExAws.Operation.JSON.t()
  @spec list_faces(binary(), list(list_faces_opt())) :: ExAws.Operation.JSON.t()
  def list_faces(collection_id, opts \\ []) when is_binary(collection_id) do
    request(:list_faces, %{
      "CollectionId" => collection_id
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_ListStreamProcessors.html
  """
  @type list_stream_processors_opt :: list_opt()
  @spec list_stream_processors() :: ExAws.Operation.JSON.t()
  @spec list_stream_processors(list(list_stream_processors_opt())) :: ExAws.Operation.JSON.t()
  def list_stream_processors(opts \\ []) do
    request(:list_stream_processors, camelize_keys(opts))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetCelebrityInfo.html
  """
  @spec get_celebrity_info(binary()) :: ExAws.Operation.JSON.t()
  def get_celebrity_info(id) when is_binary(id) do
    request(:get_celebrity_info, %{
      "Id" => id
    })
  end

  @type get_opt :: {:max_results, pos_integer()} | {:next_token, binary()}

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetCelebrityRecognition.html
  """
  @type get_celebrity_recognition_opt :: get_opt() | {:sort_by, :id | :timestamp}
  @spec get_celebrity_recognition(binary()) :: ExAws.Operation.JSON.t()
  @spec get_celebrity_recognition(binary(), list(get_celebrity_recognition_opt())) :: ExAws.Operation.JSON.t()
  def get_celebrity_recognition(job_id, opts \\ []) when is_binary(job_id) do
    request(:get_celebrity_recognition, %{
      "JobId" => job_id
    } |> Map.merge(opts |> stringify_enum_opts([:sort_by]) |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetContentModeration.html
  """
  @type get_content_moderation_opt :: get_opt() | {:sort_by, :name | :timestamp}
  @spec get_content_moderation(binary()) :: ExAws.Operation.JSON.t()
  @spec get_content_moderation(binary(), list(get_content_moderation_opt())) :: ExAws.Operation.JSON.t()
  def get_content_moderation(job_id, opts \\ []) when is_binary(job_id) do
    request(:get_content_moderation, %{
      "JobId" => job_id
    } |> Map.merge(opts |> stringify_enum_opts([:sort_by]) |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetFaceDetection.html
  """
  @type get_face_detection_opt :: get_opt()
  @spec get_face_detection(binary()) :: ExAws.Operation.JSON.t()
  @spec get_face_detection(binary(), list(get_face_detection_opt())) :: ExAws.Operation.JSON.t()
  def get_face_detection(job_id, opts \\ []) when is_binary(job_id) do
    request(:get_face_detection, %{
      "JobId" => job_id
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetFaceSearch.html
  """
  @type get_face_search_opt :: get_opt() | {:sort_by, :index | :timestamp}
  @spec get_face_search(binary()) :: ExAws.Operation.JSON.t()
  @spec get_face_search(binary(), list(get_face_search_opt())) :: ExAws.Operation.JSON.t()
  def get_face_search(job_id, opts \\ []) when is_binary(job_id) do
    request(:get_face_search, %{
      "JobId" => job_id
    } |> Map.merge(opts |> stringify_enum_opts([:sort_by]) |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetLabelDetection.html
  """
  @type get_label_detection_opt :: get_opt() | {:sort_by, :name | :timestamp}
  @spec get_label_detection(binary()) :: ExAws.Operation.JSON.t()
  @spec get_label_detection(binary(), list(get_label_detection_opt())) :: ExAws.Operation.JSON.t()
  def get_label_detection(job_id, opts \\ []) when is_binary(job_id) do
    request(:get_label_detection, %{
      "JobId" => job_id
    } |> Map.merge(opts |> stringify_enum_opts([:sort_by]) |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_GetPersonTracking.html
  """
  @type get_person_tracking_opt :: get_opt() | {:sort_by, :index | :timestamp}
  @spec get_person_tracking(binary()) :: ExAws.Operation.JSON.t()
  @spec get_person_tracking(binary(), list(get_person_tracking_opt())) :: ExAws.Operation.JSON.t()
  def get_person_tracking(job_id, opts \\ []) when is_binary(job_id) do
    request(:get_person_tracking, %{
      "JobId" => job_id
    } |> Map.merge(opts |> stringify_enum_opts([:sort_by]) |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_RecognizeCelebrities.html
  """
  @spec recognize_celebrities(image()) :: ExAws.Operation.JSON.t()
  def recognize_celebrities(image) do
    request(:recognize_celebrities, %{
      "Image" => map_image(image)
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_SearchFaces.html
  """
  @type search_faces_opt :: {:face_match_threshold, 0..100} | {:max_faces, 1..4096}
  @spec search_faces(binary(), binary()) :: ExAws.Operation.JSON.t()
  @spec search_faces(binary(), binary(), list(search_faces_opt())) :: ExAws.Operation.JSON.t()
  def search_faces(collection_id, face_id, opts \\ []) when is_binary(collection_id) and is_binary(face_id) do
    request(:search_faces, %{
      "CollectionId" => collection_id,
      "FaceId" => face_id
    } |> Map.merge(camelize_keys(opts)))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_SearchFacesByImage.html

  NOTE: When using an S3Object, you may need to ensure that the S3 uses the
  same region as Rekognition.
  """
  @type search_faces_by_image_opt :: search_faces_opt()
  @spec search_faces_by_image(binary(), image()) :: ExAws.Operation.JSON.t()
  @spec search_faces_by_image(binary(), image(), list(search_faces_by_image_opt())) :: ExAws.Operation.JSON.t()
  def search_faces_by_image(collection_id, image, opts \\ []) when is_binary(collection_id) do
    request(:search_faces_by_image, %{
      "CollectionId" => collection_id,
      "Image" => map_image(image)
    } |> Map.merge(camelize_keys(opts)))
  end

  @type start_opt :: {:client_request_token, binary()} | {:job_tag, binary()} | {:notification_channel, NotificationChannelObject.t()}

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartCelebrityRecognition.html
  """
  @type start_celebrity_recognition_opt :: start_opt()
  @spec start_celebrity_recognition(S3Object.t()) :: ExAws.Operation.JSON.t()
  @spec start_celebrity_recognition(S3Object.t(), list(start_celebrity_recognition_opt())) :: ExAws.Operation.JSON.t()
  def start_celebrity_recognition(video, opts \\ []) do
    request(:start_celebrity_recognition, %{
      "Video" => S3Object.map(video)
    } |> Map.merge(opts |> map_notification_channel() |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartContentModeration.html
  """
  @type start_content_moderation_opt :: start_opt() | {:min_confidence, 0..100}
  @spec start_content_moderation(S3Object.t()) :: ExAws.Operation.JSON.t()
  @spec start_content_moderation(S3Object.t(), list(start_content_moderation_opt())) :: ExAws.Operation.JSON.t()
  def start_content_moderation(video, opts \\ []) do
    request(:start_content_moderation, %{
      "Video" => S3Object.map(video)
    } |> Map.merge(opts |> map_notification_channel() |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartFaceDetection.html
  """
  @type start_face_detection_opt :: start_opt() | {:face_attributes, :default | :all}
  @spec start_face_detection(S3Object.t()) :: ExAws.Operation.JSON.t()
  @spec start_face_detection(S3Object.t(), list(start_face_detection_opt())) :: ExAws.Operation.JSON.t()
  def start_face_detection(video, opts \\ []) do
    request(:start_face_detection, %{
      "Video" => S3Object.map(video)
    } |> Map.merge(opts |> map_notification_channel()
                        |> stringify_enum_opts([:face_attributes])
                        |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartFaceSearch.html
  """
  @type start_face_search_opt :: start_opt() | {:face_match_threshold, 0..100}
  @spec start_face_search(S3Object.t(), binary()) :: ExAws.Operation.JSON.t()
  @spec start_face_search(S3Object.t(), binary(), list(start_face_search_opt())) :: ExAws.Operation.JSON.t()
  def start_face_search(video, collection_id, opts \\ []) when is_binary(collection_id) do
    request(:start_face_search, %{
      "CollectionId" => collection_id,
      "Video" => S3Object.map(video)
    } |> Map.merge(opts |> map_notification_channel() |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartLabelDetection.html
  """
  @type start_label_detection_opt :: start_opt() | {:min_confidence, 0..100}
  @spec start_label_detection(S3Object.t()) :: ExAws.Operation.JSON.t()
  @spec start_label_detection(S3Object.t(), list(start_label_detection_opt())) :: ExAws.Operation.JSON.t()
  def start_label_detection(video, opts \\ []) do
    request(:start_label_detection, %{
      "Video" => S3Object.map(video)
    } |> Map.merge(opts |> map_notification_channel() |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartPersonTracking.html
  """
  @type start_person_tracking_opt :: start_opt()
  @spec start_person_tracking(S3Object.t()) :: ExAws.Operation.JSON.t()
  @spec start_person_tracking(S3Object.t(), list(start_person_tracking_opt())) :: ExAws.Operation.JSON.t()
  def start_person_tracking(video, opts \\ []) do
    request(:start_celebrity_recognition, %{
      "Video" => S3Object.map(video)
    } |> Map.merge(opts |> map_notification_channel() |> camelize_keys()))
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StartStreamProcessor.html
  """
  @spec start_stream_processor(binary()) :: ExAws.Operation.JSON.t()
  def start_stream_processor(name) when is_binary(name) do
    request(:start_stream_processor, %{
      "Name" => name
    })
  end

  @doc """
  https://docs.aws.amazon.com/rekognition/latest/dg/API_StopStreamProcessor.html
  """
  @spec stop_stream_processor(binary()) :: ExAws.Operation.JSON.t()
  def stop_stream_processor(name) when is_binary(name) do
    request(:stop_stream_processor, %{
      "Name" => name
    })
  end

  # Utility

  defp map_image(image) when is_binary(image) do
    %{"Bytes" => Base.encode64(image)}
  end

  defp map_image(%S3Object{} = object) do
    S3Object.map(object)
  end

  # NOTE: Does not preserve order, unlike the name "map" might imply
  defp kw_map(kwl, keys, fun) do
    {split_kws, kws} = Keyword.split(kwl, keys)
    kws ++ Enum.map(split_kws, fun)
  end

  defp stringify_enum_opts(opts, keys) do
    kw_map(opts, keys, &stringify_enum/1)
  end

  defp stringify_enum(value) do
    value |> Atom.to_string() |> String.upcase()
  end

  defp map_notification_channel(opts) do
    kw_map(opts, [:notification_channel], &NotificationChannelObject.map/1)
  end

  defp request(action, data) do
    operation =
      action
      |> Atom.to_string()
      |> Macro.camelize()

    headers = [
      {"content-type", "application/x-amz-json-1.1"},
      {"x-amz-target", "RekognitionService.#{operation}"}
    ]

    ExAws.Operation.JSON.new(:rekognition, %{
      data: data,
      headers: headers
    })
  end
end
