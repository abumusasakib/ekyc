import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'image_capture_event.dart';
part 'image_capture_state.dart';

class ImageCaptureBloc extends Bloc<ImageCaptureEvent, ImageCaptureState> {
  ImageCaptureBloc() : super(ImageCaptureInitial()) {
    on<CaptureImage>(_onCaptureImage);
  }

  void _onCaptureImage(CaptureImage event, Emitter<ImageCaptureState> emit) {
    final images = Map<String, File>.from(state.images);
    images[event.captureType] = event.image;

    emit(ImageCaptureLoaded(
      images: images,
      scrollController: state.scrollController,
    ));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      state.scrollController.animateTo(
        state.scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
  }
}
