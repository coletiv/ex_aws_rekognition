defmodule ExAws.OperationsTest do
  use ExUnit.Case, async: true
  doctest ExAws.Rekognition
  alias ExAws.Rekognition.S3Object

  setup do
    similarity_threshold = 0.0
    {:ok, source_image_binary} = File.read("test/assets/face_source.jpeg")
    {:ok, target_image_binary} = File.read("test/assets/face_target.jpeg")

    s3_source_object = %S3Object{
      bucket: "test-bucket",
      name: "source.jpg"
    }

    s3_target_object = %S3Object{
      bucket: "test-bucket",
      name: "target.jpg"
    }

    {:ok,
     source_binary: source_image_binary,
     target_binary: target_image_binary,
     source_s3: s3_source_object,
     target_s3: s3_target_object,
     similarity_threshold: similarity_threshold}
  end

  test "compare faces", %{
    source_binary: source_binary,
    target_binary: target_binary,
    source_s3: source_s3,
    target_s3: target_s3,
    similarity_threshold: similarity_threshold
  } do
    source_base64 = Base.encode64(source_binary)
    target_base64 = Base.encode64(target_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "SimilarityThreshold" => ^similarity_threshold,
               "SourceImage" => %{"Bytes" => ^source_base64},
               "TargetImage" => %{"Bytes" => ^target_base64}
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.CompareFaces"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } =
             ExAws.Rekognition.compare_faces(
               source_binary,
               target_binary,
               similarity_threshold: similarity_threshold
             )

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "SimilarityThreshold" => ^similarity_threshold,
               "SourceImage" => %{
                 "S3Object" => %{
                   "Bucket" => "test-bucket",
                   "Name" => "source.jpg",
                   "Version" => nil
                 }
               },
               "TargetImage" => %{
                 "S3Object" => %{
                   "Bucket" => "test-bucket",
                   "Name" => "target.jpg",
                   "Version" => nil
                 }
               }
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.CompareFaces"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } =
             ExAws.Rekognition.compare_faces(
               source_s3,
               target_s3,
               similarity_threshold: similarity_threshold
             )
  end

  test "detect_faces", %{source_binary: image_binary, source_s3: image_s3} do
    image_base64 = Base.encode64(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "Image" => %{"Bytes" => ^image_base64}
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectFaces"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.detect_faces(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "Image" => %{
                 "S3Object" => %{
                   "Bucket" => "test-bucket",
                   "Name" => "source.jpg",
                   "Version" => nil
                 }
               }
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectFaces"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.detect_faces(image_s3)
  end

  test "detect_text", %{source_binary: image_binary, source_s3: image_s3} do
    image_base64 = Base.encode64(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "Image" => %{"Bytes" => ^image_base64}
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectText"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.detect_text(image_binary)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "Image" => %{
                 "S3Object" => %{
                   "Bucket" => "test-bucket",
                   "Name" => "source.jpg",
                   "Version" => nil
                 }
               }
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DetectText"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.detect_text(image_s3)
  end

  test "create/describe/list/delete collection" do
    collection_id = "ex_aws_rekognition_test_collection"

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "CollectionId" => ^collection_id
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.CreateCollection"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.create_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "CollectionId" => ^collection_id
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DescribeCollection"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.describe_collection(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: ^collection_id,
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.ListCollections"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.list_collections(collection_id)

    assert %ExAws.Operation.JSON{
             before_request: nil,
             data: %{
               "CollectionId" => ^collection_id
             },
             headers: [
               {"content-type", "application/x-amz-json-1.1"},
               {"x-amz-target", "RekognitionService.DeleteCollection"}
             ],
             http_method: :post,
             params: %{},
             path: "/",
             service: :rekognition,
             stream_builder: nil
           } = ExAws.Rekognition.delete_collection(collection_id)
  end
end
