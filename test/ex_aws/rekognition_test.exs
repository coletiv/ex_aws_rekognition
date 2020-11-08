defmodule ExAws.RekognitionTest do
  use ExUnit.Case, async: true
  doctest ExAws.Rekognition

  test "compare faces - image" do
    similarity_threshold = 0.0
    {:ok, source_image_binary} = File.read("test/assets/face_source.jpeg")
    {:ok, target_image_binary} = File.read("test/assets/face_target.jpeg")

    operation_json =
      ExAws.Rekognition.compare_faces(
        source_image_binary,
        target_image_binary,
        similarity_threshold: similarity_threshold
      )

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "SimilarityThreshold" => 0.0,
               "SourceImage" => %{
                 "Bytes" => _
               },
               "TargetImage" => %{
                 "Bytes" => _
               }
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.CompareFaces"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end

  test "detect faces - image" do
    {:ok, image_binary} = File.read("test/assets/face_source.jpeg")

    operation_json = ExAws.Rekognition.detect_faces(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"Image" => %{"Bytes" => _}},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectFaces"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end

  test "detect text - image" do
    {:ok, image_binary} = File.read("test/assets/test.jpg")

    operation_json = ExAws.Rekognition.detect_text(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"Image" => %{"Bytes" => _}},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectText"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end

  test "create/describe/list/delete collection" do
    collection_id = "ex_aws_rekognition_test_collection"

    operation_json = ExAws.Rekognition.create_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"CollectionId" => ^collection_id},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.CreateCollection"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    operation_json = ExAws.Rekognition.describe_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"CollectionId" => ^collection_id},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DescribeCollection"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    operation_json = ExAws.Rekognition.list_collections()

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.ListCollections"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    operation_json = ExAws.Rekognition.delete_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"CollectionId" => ^collection_id},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DeleteCollection"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end

  test "index/list/search_by_image faces" do
    collection_id = "ex_aws_rekognition_test_collection"
    operation_json = ExAws.Rekognition.create_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"CollectionId" => ^collection_id},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.CreateCollection"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    {:ok, image_binary} = File.read("test/assets/face_target.jpeg")

    operation_json = ExAws.Rekognition.index_faces(collection_id, image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "CollectionId" => ^collection_id,
               "Image" => %{"Bytes" => _}
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.IndexFaces"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    operation_json = ExAws.Rekognition.list_faces(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"CollectionId" => ^collection_id},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.ListFaces"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    {:ok, image_binary} = File.read("test/assets/face_source.jpeg")

    operation_json = ExAws.Rekognition.search_faces_by_image(collection_id, image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "CollectionId" => ^collection_id,
               "Image" => %{"Bytes" => _}
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.SearchFacesByImage"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    operation_json = ExAws.Rekognition.delete_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"CollectionId" => ^collection_id},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DeleteCollection"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end

  test "recognize celebrities" do
    {:ok, image_binary} = File.read("test/assets/face_target.jpeg")

    operation_json = ExAws.Rekognition.recognize_celebrities(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"Image" => %{"Bytes" => _}},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.RecognizeCelebrities"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end

  test "detect labels/moderation labels" do
    {:ok, image_binary} = File.read("test/assets/face_target.jpeg")

    operation_json = ExAws.Rekognition.detect_labels(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{"Image" => %{"Bytes" => _}},
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectLabels"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json

    operation_json = ExAws.Rekognition.detect_moderation_labels(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "Image" => %{"Bytes" => _}
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectModerationLabels"}
             ],
             http_method: :post,
             params: %{},
             parser: _,
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = operation_json
  end
end
