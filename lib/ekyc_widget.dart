library ekyc;

import 'package:ekyc/application/theme/my_dark_theme.dart';
import 'package:ekyc/core/dependency/auto_injector.dart';
import 'package:ekyc/core/dependency/injector.dart';
import 'package:ekyc/core/routes/router_config.dart';
import 'package:ekyc/feature/presentation/bloc/image_capture_bloc.dart';
import 'package:ekyc/l10n/app_localizations.dart';
import 'package:ekyc/l10n/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EkycWidget extends StatefulWidget {
  final Injector injector = AppInjector();

  EkycWidget({super.key});

  @override
  State<EkycWidget> createState() => _EkycWidgetState();
}

class _EkycWidgetState extends State<EkycWidget> {
  @override
  void initState() {
    configureDependencies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImageCaptureBloc>(
          create: (context) => ImageCaptureBloc(),
        ),
      ],
      child: MaterialApp.router(
        onGenerateTitle: (cxt) => cxt.tr.appTitle,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: AppLocalizations.supportedLocales.last,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: MyDarkTheme.colorScheme,
          textTheme: Theme.of(context).textTheme.copyWith(
                displayMedium: GoogleFonts.robotoMono(
                  color: MyDarkTheme.textColor,
                ),
              ),
        ),
        themeMode: ThemeMode.dark,
        routerConfig: RouterManager.config(widget.injector),
      ),
    );
  }
}
