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
| [CreateProject](https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateProject.html)                         | ❌        |
| [CreateProjectVersion](https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateProjectVersion.html)           | ❌        |
| [CreateStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_CreateStreamProcessor.html)         | ✅        |
| [DeleteCollection](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteCollection.html)                   | ✅        |
| [DeleteFaces](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteFaces.html)                             | ✅        |
| [DeleteProject](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteProject.html)                         | ❌        |
| [DeleteProjectVersion](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteProjectVersion.html)           | ❌        |
| [DeleteStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_DeleteStreamProcessor.html)         | ✅        |
| [DescribeCollection](https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeCollection.html)               | ✅        |
| [DescribeProjects](https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeProjects.html)                   | ❌        |
| [DescribeProjectVersions](https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeProjectVersions.html)     | ❌        |
| [DescribeStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_DescribeStreamProcessor.html)     | ✅        |
| [DetectCustomLabels](https://docs.aws.amazon.com/rekognition/latest/dg/API_DetectCustomLabels.html)               | ❌        |
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
| [GetSegmentDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetSegmentDetection.html)             | ❌        |
| [GetTextDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_GetTextDetection.html)                   | ❌        |
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
| [StartProjectVersion](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartProjectVersion.html)             | ❌        |
| [StartSegmentDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartSegmentDetection.html)         | ❌        |
| [StartStreamProcessor](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartStreamProcessor.html)           | ✅        |
| [StartTextDetection](https://docs.aws.amazon.com/rekognition/latest/dg/API_StartTextDetection.html)               | ❌        |
| [StopProjectVersion](https://docs.aws.amazon.com/rekognition/latest/dg/API_StopProjectVersion.html)               | ❌        |
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

Documentation can be found at [https://hexdocs.pm/ex_aws_rekognition/ExAws.Rekognition.html](https://hexdocs.pm/ex_aws_rekognition/ExAws.Rekognition.html).
