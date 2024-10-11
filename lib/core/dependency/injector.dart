import 'package:get_it/get_it.dart';

abstract class Injector {
  void registerLazySingleton<T extends Object>(T Function() fn);
  void registerFactory<T extends Object>(T Function() fn);
  T get<T extends Object>();
  T call<T extends Object>();
}

class AppInjector implements Injector {
  final GetIt _getIt = GetIt.instance;
  @override
  T get<T extends Object>() {
    return _getIt<T>();
  }

  @override
  void registerFactory<T extends Object>(T Function() fn) {
    _getIt.registerFactory<T>(fn);
  }

  @override
  void registerLazySingleton<T extends Object>(T Function() fn) {
    _getIt.registerLazySingleton<T>(fn);
  }

  @override
  T call<T extends Object>() {
    return get<T>();
  }
}
