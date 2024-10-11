import 'package:flutter/material.dart';

class RootStack extends StatelessWidget {
  final Widget firstChild;
  final Widget snackbar;
  final Widget progressIndicator;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? fab;
  final bool isRegistered;
  final bool resizeToAvoidBottomInset;

  const RootStack({
    super.key,
    required this.firstChild,
    required this.snackbar,
    required this.progressIndicator,
    this.appBar,
    this.bottomNavigationBar,
    this.fab,
    this.isRegistered = true,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _firstChildContainer(context),
        _snackBarContainer(),
      ],
    );
  }

  bool isRouteSelected(String routeName, BuildContext context) {
    return ModalRoute.of(context)!.settings.name == routeName;
  }

  Widget _firstChildContainer(BuildContext context) {
    return Scaffold(
      appBar: appBar as PreferredSizeWidget?,
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: firstChild),
      floatingActionButton: fab,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }

  Widget _snackBarContainer() {
    return SafeArea(
      child: Material(child: snackbar),
    );
  }
}
