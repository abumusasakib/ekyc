import 'dart:io';
import 'package:ekyc/core/routes/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:camera/camera.dart';
import 'package:ekyc/feature/presentation/bloc/image_capture_bloc.dart';
import 'package:image/image.dart' as img;

class ImageTakerScreen extends StatefulWidget {
  final String captureType;

  const ImageTakerScreen({super.key, required this.captureType});

  @override
  ImageTakerScreenState createState() => ImageTakerScreenState();
}

class ImageTakerScreenState extends State<ImageTakerScreen> {
  CameraController? controller;
  String? photoPath;
  late ImageCaptureBloc imgCapBloc;
  bool isCropped = false;

  @override
  void initState() {
    super.initState();
    imgCapBloc = context.read<ImageCaptureBloc>();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.firstWhere(
      (camera) =>
          camera.lensDirection ==
          (widget.captureType == 'Customer Photo'
              ? CameraLensDirection.front
              : CameraLensDirection.back),
    );
    controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    isCropped = widget.captureType == 'Customer Photo' ? false : true;

    try {
      await controller!.initialize();
      setState(() {});
    } catch (e) {
      print('Error initializing camera: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: ClipRect(
                child: Align(
                  alignment: Alignment.center,
                  heightFactor: isCropped ? 0.5 : 1.0,
                  child: CameraPreview(controller!),
                ),
              ),
            ),
          ),
          _buildControlBar(),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.go(RouterPaths.ekycHomeScreen),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: _captureImage,
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_ios),
            onPressed: _switchCamera,
          ),
          IconButton(
            icon: const Icon(Icons.crop),
            onPressed: _toggleCrop,
          ),
        ],
      ),
    );
  }

  void _toggleCrop() {
    setState(() {
      isCropped = !isCropped;
    });
  }

  Future<void> _captureImage() async {
    if (!controller!.value.isInitialized) {
      return;
    }
    final Directory appDir = await getTemporaryDirectory();
    final String filePath = path.join(appDir.path, '${DateTime.now()}.jpg');

    try {
      XFile picture = await controller!.takePicture();
      await picture.saveTo(filePath);

      if (isCropped) {
        await _cropImage(filePath);
      }

      imgCapBloc.add(CaptureImage(widget.captureType, File(filePath)));
      if (mounted) {
        context.go(RouterPaths.ekycHomeScreen);
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<void> _cropImage(String filePath) async {
    final image = img.decodeImage(File(filePath).readAsBytesSync());
    if (image != null) {
      final croppedImage = img.copyCrop(
        image,
        0,
        image.height ~/ 4,
        image.width,
        image.height ~/ 2,
      );
      final croppedFilePath = path.join(
        path.dirname(filePath),
        'cropped_${path.basename(filePath)}',
      );
      File(croppedFilePath).writeAsBytesSync(img.encodeJpg(croppedImage));
      File(filePath).deleteSync();
      File(croppedFilePath).renameSync(filePath);
    }
  }

  Future<void> _switchCamera() async {
    final cameras = await availableCameras();
    final newCameraDescription =
        controller!.description == cameras.first ? cameras.last : cameras.first;

    await controller!.dispose();
    controller = CameraController(
      newCameraDescription,
      ResolutionPreset.high,
    );

    try {
      await controller!.initialize();
      setState(() {});
    } catch (e) {
      print('Error switching camera: $e');
    }
  }
}
