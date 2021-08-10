# ExAws.Rekognition

[![Hex.pm version](https://img.shields.io/hexpm/v/ex_aws_rekognition.svg)](https://hex.pm/packages/ex_aws_rekognition)
[![Build Docs](https://img.shields.io/badge/hexdocs-release-blue.svg)](https://hexdocs.pm/ex_aws_rekognition/ExAws.Rekognition.html)

[![Hex.pm downloads](https://img.shields.io/hexpm/dt/ex_aws_rekognition.svg)](https://hex.pm/packages/ex_aws_rekognition)
[![Hex.pm weekly downloads](https://img.shields.io/hexpm/dw/ex_aws_rekognition.svg)](https://hex.pm/packages/ex_aws_rekognition)
[![Hex.pm daily downloads](https://img.shields.io/hexpm/dd/ex_aws_rekognition.svg)](https://hex.pm/packages/ex_aws_rekognition)

Rekognition uses [ex_aws](https://github.com/ex-aws/ex_aws) under the hood so you should go through their [README](https://github.com/ex-aws/ex_aws/blob/master/README.md) for more information on how to setup/configure the project, it's really easy.

You can check [AWS Rekognition documentation](https://docs.aws.amazon.com/rekognition/latest/dg/API_Operations.html) for the list of functionalities and available actions.

| Action                                                                                                            | Supported |
| ----------------------------------------------------------------------------------------------------------------- | --------- |
| [CompareFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_CompareFaces.html)                           | ✅        |
| [CreateCollection](https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateCollection.html)                   | ✅        |
| [CreateStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateStreamProcessor.html)         | ✅        |
| [DeleteCollection](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteCollection.html)                   | ✅        |
| [DeleteFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html)                             | ✅        |
| [DeleteStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteStreamProcessor.html)         | ✅        |
| [DescribeCollection](https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html)               | ✅        |
| [DescribeStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeStreamProcessor.html)     | ✅        |
| [DetectFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectFaces.html)                             | ✅        |
| [DetectLabels](https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectLabels.html)                           | ✅        |
| [DetectModerationLabels](https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectModerationLabels.html)       | ✅        |
| [DetectText](https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectText.html)                               | ✅        |
| [GetCelebrityInfo](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetCelebrityInfo.html)                   | ✅        |
| [GetCelebrityRecognition](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetCelebrityRecognition.html)     | ✅        |
| [GetContentModeration](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetContentModeration.html)           | ✅        |
| [GetFaceDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetFaceDetection.html)                   | ✅        |
| [GetFaceSearch](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetFaceSearch.html)                         | ✅        |
| [GetLabelDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetLabelDetection.html)                 | ✅        |
| [GetPersonTracking](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetPersonTracking.html)                 | ✅        |
| [IndexFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_IndexFaces.html)                               | ✅        |
| [ListCollections](https://docs.aws.amazon.com/rekognition/latest/dg/API_ListCollections.html)                     | ✅        |
| [ListFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_ListFaces.html)                                 | ✅        |
| [ListStreamProcessors](https://docs.aws.amazon.com/rekognition/latest/dg/API_ListStreamProcessors.html)           | ✅        |
| [RecognizeCelebrities](https://docs.aws.amazon.com/rekognition/latest/dg/API_RecognizeCelebrities.html)           | ✅        |
| [SearchFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_SearchFaces.html)                             | ✅        |
| [SearchFacesByImage](https://docs.aws.amazon.com/rekognition/latest/dg/API_SearchFacesByImage.html)               | ✅        |
| [StartCelebrityRecognition](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartCelebrityRecognition.html) | ✅        |
| [StartContentModeration](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartContentModeration.html)       | ✅        |
| [StartFaceDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartFaceDetection.html)               | ✅        |
| [StartFaceSearch](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartFaceSearch.html)                     | ✅        |
| [StartLabelDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartLabelDetection.html)             | ✅        |
| [StartPersonTracking](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartPersonTracking.html)             | ✅        |
| [StartStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartStreamProcessor.html)           | ✅        |
| [StopStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_StopStreamProcessor.html)             | ✅        |

## Installation

The package can be installed by adding `ex_aws_rekognition` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_aws_rekognition, "~> 0.6.0"}
  ]
end
```

## Usage
```elixir
  {:ok, source_image_binary} = File.read("path/to/face_source.jpeg")
  {:ok, target_image_binary} = File.read("path/to/face_target.jpeg")

  ExAws.Rekognition.compare_faces(
    source_image_binary,
    target_image_binary,
    similarity_threshold: 0.5
  )
  |> ExAws.request()
```

Complete documentation can be found at [https://hexdocs.pm/ex_aws_rekognition/ExAws.Rekognition.html](https://hexdocs.pm/ex_aws_rekognition/ExAws.Rekognition.html).
