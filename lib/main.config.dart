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

import 'contract/remote/i_home_repository.dart' as _i18;
import 'contract/services/i_connection_service.dart' as _i4;
import 'contract/services/i_firebase_service.dart' as _i6;
import 'contract/services/i_message_service.dart' as _i8;
import 'contract/services/i_request_service.dart' as _i10;
import 'models/photos.dart' as _i14;
import 'repositories/home_repository.dart' as _i19;
import 'screens/favorites/favorites_view_model.dart' as _i17;
import 'screens/home/home_view_model.dart' as _i20;
import 'screens/login/login_view_model.dart' as _i12;
import 'screens/photo_details/photo_details_view_model.dart' as _i13;
import 'screens/register/register_view_model.dart' as _i15;
import 'screens/splash/splash_view_model.dart' as _i16;
import 'services/connection_service.dart' as _i5;
import 'services/favorites_service.dart' as _i3;
import 'services/firebase_service.dart' as _i7;
import 'services/message_service.dart' as _i9;
import 'services/request_service.dart' as _i11;

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
  gh.singleton<_i3.FavoritesDataService>(_i3.FavoritesDataService());
  gh.singleton<_i4.IConnectionService>(_i5.ConnectionService());
  gh.singleton<_i6.IFirebaseService>(_i7.FirebaseService());
  gh.singleton<_i8.IMessageService>(_i9.MessageService());
  gh.singleton<_i10.IRequestService>(_i11.RequestService());
  gh.factory<_i12.LoginViewModel>(() => _i12.LoginViewModel(
        connectionService: gh<_i4.IConnectionService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        messageService: gh<_i8.IMessageService>(),
      ));
  gh.factory<_i13.PhotoDetailsViewModel>(() => _i13.PhotoDetailsViewModel(
        connectionService: gh<_i4.IConnectionService>(),
        messageService: gh<_i8.IMessageService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        requestService: gh<_i10.IRequestService>(),
        photo: gh<_i14.Photos>(),
      ));
  gh.factory<_i15.RegisterViewModel>(() => _i15.RegisterViewModel(
        connectionService: gh<_i4.IConnectionService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        messageService: gh<_i8.IMessageService>(),
      ));
  gh.factory<_i16.SplashViewModel>(
      () => _i16.SplashViewModel(firebaseService: gh<_i6.IFirebaseService>()));
  gh.factory<_i17.FavoritesViewModel>(() => _i17.FavoritesViewModel(
        favDataService: gh<_i3.FavoritesDataService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        connectionService: gh<_i4.IConnectionService>(),
      ));
  gh.factory<_i18.IHomeRepository>(
      () => _i19.HomeRepository(requestService: gh<_i10.IRequestService>()));
  gh.factory<_i20.HomeViewModel>(() => _i20.HomeViewModel(
        homeRepository: gh<_i18.IHomeRepository>(),
        connectionService: gh<_i4.IConnectionService>(),
        messageService: gh<_i8.IMessageService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        favDataService: gh<_i3.FavoritesDataService>(),
      ));
  return getIt;
}
