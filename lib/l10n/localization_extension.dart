import 'package:ekyc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!;
}