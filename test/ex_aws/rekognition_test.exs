defmodule ExAws.RekognitionTest do
  use ExUnit.Case, async: true
  doctest ExAws.Rekognition

  # alias ExAws.Rekognition.S3Object

  # Usage example - to run this test you need an existent
  # s3 bucket with an image.
  #
  # test "detect text - s3 image" do
  #   s3_object = %S3Object{
  #     bucket: "test-bucket",
  #     name: "test.jpg"
  #   }

  #   assert {:ok, %{"TextDetections" => _}} =
  #            ExAws.Rekognition.detect_text(s3_object)
  #            |> ExAws.request(region: "us-east-2")
  # end

  test "compare faces - image" do
    similarity_threshold = 0.0
    {:ok, source_image_binary} = File.read("test/assets/face_source.jpeg")
    {:ok, target_image_binary} = File.read("test/assets/face_target.jpeg")

    assert {:ok, %{"FaceMatches" => _}} =
             ExAws.Rekognition.compare_faces(
               source_image_binary,
               target_image_binary,
               similarity_threshold
             )
             |> ExAws.request()
  end

  test "detect faces - image" do
    {:ok, image_binary} = File.read("test/assets/face_source.jpeg")

    assert {:ok, %{"FaceDetails" => _}} =
             ExAws.Rekognition.detect_faces(image_binary)
             |> ExAws.request()
  end

  test "detect text - image" do
    {:ok, image_binary} = File.read("test/assets/test.jpg")

    assert {:ok, %{"TextDetections" => _}} =
             ExAws.Rekognition.detect_text(image_binary)
             |> ExAws.request(region: "us-east-2")
  end

  test "create/describe/list/delete collection" do
    collection_id = "ex_aws_rekognition_test_collection"

    assert {:ok,
            %{
              "CollectionArn" => _,
              "FaceModelVersion" => _,
              "StatusCode" => 200
            }} = ExAws.Rekognition.create_collection(collection_id) |> ExAws.request()

    assert {:ok,
            %{
              "CollectionARN" => _,
              "CreationTimestamp" => _,
              "FaceCount" => _,
              "FaceModelVersion" => _
            }} = ExAws.Rekognition.describe_collection(collection_id) |> ExAws.request()

    assert {:ok, %{"CollectionIds" => _, "FaceModelVersions" => _}} =
             ExAws.Rekognition.list_collections() |> ExAws.request()

    assert {:ok, %{"StatusCode" => 200}} =
             ExAws.Rekognition.delete_collection(collection_id) |> ExAws.request()
  end
end
