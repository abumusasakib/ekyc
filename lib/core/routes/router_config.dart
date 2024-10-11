import 'package:ekyc/core/dependency/injector.dart';
import 'package:ekyc/core/routes/navigation_observer.dart';
import 'package:ekyc/core/routes/router_paths.dart';
import 'package:ekyc/feature/presentation/screens/ekyc_home_screen.dart';
import 'package:ekyc/feature/presentation/screens/ekyc_precaution_screen.dart';
import 'package:ekyc/feature/presentation/screens/image_taker_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';

class RouterManager {
  static getCurrentPath(BuildContext context) {
    return GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .uri
        .toString();
  }

  static GoRouter config(Injector injector) => GoRouter(
        observers: [
          CustomNavigatorObserver(),
        ],
        initialLocation: RouterPaths.ekycPrecautionScreen,
        routes: [
          GoRoute(
            path: RouterPaths.ekycPrecautionScreen,
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                start: -1,
                child: const EkycPrecautionScreen()),
          ),
          GoRoute(
            path: RouterPaths.ekycHomeScreen,
            pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                start: 1,
                child: const EkycHomeScreen()),
          ),
          GoRoute(
            path: '${RouterPaths.imageTakerScreen}/:captureType',
            pageBuilder: (context, state) {
              final captureType = state.pathParameters['captureType']!;
              return buildPageWithDefaultTransition(
                  context: context,
                  state: state,
                  start: 0,
                  child: ImageTakerScreen(captureType: captureType),
              );
            },
          ),
        ],
      );
}

class MyTickerProvider implements TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) => Ticker(onTick);
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required double start,
}) {
  MyTickerProvider tickerProvider = MyTickerProvider();

  AnimationController controller = AnimationController(
    vsync: tickerProvider,
    duration: const Duration(seconds: 1),
  );

  // Animation<Offset> slideAnimation =
  //     Tween<Offset>(begin: Offset(0, start), end: const Offset(0, 0))
  //         .animate(CurvedAnimation(
  //   parent: controller,
  //   // curve: const Interval(
  //   //   0.0,
  //   //   1.0,
  //   curve: Curves.easeInOut,
  //   // ),
  // ));

  Animation<double> fadeAnimation =
      Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
    parent: controller,
    curve: const Interval(
      0.4,
      1.0,
      curve: Curves.easeInOut,
    ),
  ));
  controller.forward();

  return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(start, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );

        // return FadeTransition(
        //   opacity: fadeAnimation,
        //   child: child,
        // );
        
        // return ScaleTransition(
        //   scale: controller,
        //   child: child,
        // );
        // return SlideTransition(
        //   position: slideAnimation,
        //   child: child,
        // );
      });
}
