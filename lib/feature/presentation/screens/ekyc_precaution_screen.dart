import 'package:ekyc/core/routes/router_paths.dart';
import 'package:ekyc/feature/presentation/widgets/riit_stack.dart';
import 'package:ekyc/l10n/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EkycPrecautionScreen extends StatelessWidget {
  const EkycPrecautionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RootStack(
      snackbar: const SizedBox(),
      progressIndicator: const SizedBox(),
      appBar: AppBar(
        title: Text(context.tr.appTitle),
      ),
      firstChild: const EkycPrecautionWidget(),
    );
  }
}

class EkycPrecautionWidget extends StatelessWidget {
  const EkycPrecautionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go(RouterPaths.ekycHomeScreen);
            },
            child: const Text('Go to Home Screen'),
          ),
        ],
      ),
    );
  }
}
