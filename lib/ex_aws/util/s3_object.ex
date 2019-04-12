defmodule S3Object do
  defstruct [:bucket, :name, version: nil]
end
