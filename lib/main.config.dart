// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'contract/services/i_connection_service.dart' as _i3;
import 'contract/services/i_firebase_service.dart' as _i5;
import 'contract/services/i_message_service.dart' as _i7;
import 'screens/login/login_view_model.dart' as _i9;
import 'screens/register/register_view_model.dart' as _i10;
import 'services/connection_service.dart' as _i4;
import 'services/firebase_service.dart' as _i6;
import 'services/message_service.dart' as _i8;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.IConnectionService>(_i4.ConnectionService());
  gh.singleton<_i5.IFirebaseService>(_i6.FirebaseService());
  gh.singleton<_i7.IMessageService>(_i8.MessageService());
  gh.factory<_i9.LoginViewModel>(() => _i9.LoginViewModel(
        connectionService: gh<_i3.IConnectionService>(),
        firebaseService: gh<_i5.IFirebaseService>(),
        messageService: gh<_i7.IMessageService>(),
      ));
  gh.factory<_i10.RegisterViewModel>(() => _i10.RegisterViewModel(
        connectionService: gh<_i3.IConnectionService>(),
        firebaseService: gh<_i5.IFirebaseService>(),
        messageService: gh<_i7.IMessageService>(),
      ));
  return getIt;
}
