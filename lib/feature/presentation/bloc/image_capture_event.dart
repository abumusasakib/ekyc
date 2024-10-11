part of 'image_capture_bloc.dart';

abstract class ImageCaptureEvent {}

class CaptureImage extends ImageCaptureEvent {
  final String captureType;
  final File image;

  CaptureImage(this.captureType, this.image);
}
