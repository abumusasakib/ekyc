import 'package:ekyc/feature/presentation/widgets/image_capture_view.dart';
import 'package:ekyc/feature/presentation/widgets/riit_stack.dart';
import 'package:ekyc/l10n/localization_extension.dart';
import 'package:flutter/material.dart';

class EkycHomeScreen extends StatelessWidget {
  const EkycHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootStack(
      snackbar: const SizedBox(),
      progressIndicator: const SizedBox(),
      appBar: AppBar(
        title: Text(context.tr.appTitle),
      ),
      firstChild: const EkycHomeWidget(),
    );
  }
}

class EkycHomeWidget extends StatelessWidget {
  const EkycHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageCaptureView();
  }
}
