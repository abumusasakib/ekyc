part of 'image_capture_bloc.dart';

abstract class ImageCaptureState {
  final Map<String, File> images;
  final ScrollController scrollController;

  ImageCaptureState({
    required this.images,
    required this.scrollController,
  });
}

class ImageCaptureInitial extends ImageCaptureState {
  ImageCaptureInitial()
      : super(
          images: {},
          scrollController: ScrollController(),
        );
}

class ImageCaptureLoaded extends ImageCaptureState {
  ImageCaptureLoaded({
    required super.images,
    required super.scrollController,
  });
}

class ImageCaptureFailure extends ImageCaptureState {
  final String captureType;
  final String error;

  ImageCaptureFailure({
    required this.captureType,
    required this.error,
    required super.images,
    required super.scrollController,
  });
}
