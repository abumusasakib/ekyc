// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'api_module.dart' as _i804;
import 'module.dart' as _i946;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final apiModule = _$ApiModule();
    final registerModule = _$RegisterModule();
    gh.factory<_i361.Dio>(() => apiModule.dio);
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.getPerf(),
      preResolve: true,
    );
    gh.factory<String>(
      () => apiModule.baseUrl,
      instanceName: 'BASEURL',
    );
    return this;
  }
}

class _$ApiModule extends _i804.ApiModule {}

class _$RegisterModule extends _i946.RegisterModule {}
