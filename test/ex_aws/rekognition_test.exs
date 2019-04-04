defmodule ExAws.RekognitionTest do
  use ExUnit.Case, async: true
  doctest ExAws.Rekognition

  test "detect text image" do
    {:ok, image_binary} = File.read("test/assets/test.jpg")

    assert {:ok, %{"TextDetections" => _}} =
             ExAws.Rekognition.detect_text(image_binary)
             |> ExAws.request(region: "us-east-2")
  end

  test "detect text s3 image" do
    s3_object_bucket = "example_bucket"
    s3_object_name = "example_image_jpg"

    assert {:ok, %{"TextDetections" => _}} =
             ExAws.Rekognition.detect_text(s3_object_bucket, s3_object_name)
             |> ExAws.request(region: "us-east-2")
  end
end
