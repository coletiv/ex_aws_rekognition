defmodule ExAws.Rekognition.S3Object do
  defstruct [:bucket, :name, version: nil]

  alias ExAws.Rekognition.S3Object

  def map(%S3Object{} = object) do
    %{
      "S3Object" => %{
        "Bucket" => object.bucket,
        "Name" => object.name,
        "Version" => object.version
      }
    }
  end
end
