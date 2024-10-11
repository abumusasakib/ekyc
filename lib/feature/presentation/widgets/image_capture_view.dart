import 'dart:io';

import 'package:ekyc/feature/presentation/bloc/image_capture_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ekyc/core/routes/router_paths.dart';

class ImageCaptureView extends StatelessWidget {
  final List<String> captureTypes = [
    'Customer Photo',
    'NID Front',
    'NID Back',
    'Signature'
  ];

  ImageCaptureView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImageCaptureBloc, ImageCaptureState>(
      listener: (context, state) {
        if (state is ImageCaptureLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image captured successfully!')),
          );
        } else if (state is ImageCaptureFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    '${state.captureType} capture failed: ${state.error}')),
          );
        }
      },
      builder: (context, state) {
        final imageMap = state.images;
        final currentIndex = imageMap
            .length; // Determine the current capture type index based on the number of captured images

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView.builder(
                  controller: state.scrollController,
                  itemCount: currentIndex < captureTypes.length
                      ? currentIndex + 1
                      : captureTypes
                          .length, // Show only one capture type at a time
                  itemBuilder: (context, index) {
                    var type = captureTypes[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onLongPress: () {
                            if (imageMap.containsKey(type)) {
                              _showPreviewDialog(context, imageMap[type]!);
                            }
                          },
                          child: AspectRatio(
                            aspectRatio: 13 / 9,
                            child: imageMap.containsKey(type)
                                ? GestureDetector(
                                    onTap: () => context.go(
                                        '${RouterPaths.imageTakerScreen}/${type}'),
                                    child: Image.file(imageMap[type]!,
                                        fit: BoxFit.cover),
                                  )
                                : GestureDetector(
                                    onTap: () => context.go(
                                        '${RouterPaths.imageTakerScreen}/$type'),
                                    child: Container(
                                      color: Colors.grey[300],
                                      child: Center(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Opacity(
                                              opacity: 0.5,
                                              child: Image.asset(
                                                'assets/images/placeholder-614.jpg',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Text(
                                              'Tap to capture $type',
                                              style: const TextStyle(
                                                backgroundColor: Colors.black45,
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _showExitConfirmationDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement next step logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Next step - To be implemented')),
                      );
                    },
                    child: const Text('Next'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    final bool? exitConfirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit eKYC?'),
          content:
              const Text('Are you sure you want to exit the eKYC process?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );

    if (exitConfirmed == true) {
      // Navigate back to the precautions screen
      if (context.mounted) {
        context.go(RouterPaths.ekycPrecautionScreen);
      }
    }
  }

  void _showPreviewDialog(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(imageFile),
              SizedBox(
                width:
                    double.infinity, // Make the button take up the full width
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
