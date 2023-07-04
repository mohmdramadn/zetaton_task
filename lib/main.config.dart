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

import 'contract/remote/i_home_repository.dart' as _i21;
import 'contract/remote/i_search_repository.dart' as _i12;
import 'contract/services/i_connection_service.dart' as _i4;
import 'contract/services/i_firebase_service.dart' as _i6;
import 'contract/services/i_message_service.dart' as _i8;
import 'contract/services/i_request_service.dart' as _i10;
import 'models/photos.dart' as _i16;
import 'repositories/home_repository.dart' as _i22;
import 'repositories/search_repository.dart' as _i13;
import 'screens/favorites/favorites_view_model.dart' as _i20;
import 'screens/home/home_view_model.dart' as _i23;
import 'screens/login/login_view_model.dart' as _i14;
import 'screens/photo_details/photo_details_view_model.dart' as _i15;
import 'screens/register/register_view_model.dart' as _i17;
import 'screens/search/search_view_model.dart' as _i18;
import 'screens/splash/splash_view_model.dart' as _i19;
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
  gh.factory<_i12.ISearchRepository>(
      () => _i13.SearchRepository(requestService: gh<_i10.IRequestService>()));
  gh.factory<_i14.LoginViewModel>(() => _i14.LoginViewModel(
        connectionService: gh<_i4.IConnectionService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        messageService: gh<_i8.IMessageService>(),
      ));
  gh.factory<_i15.PhotoDetailsViewModel>(() => _i15.PhotoDetailsViewModel(
        connectionService: gh<_i4.IConnectionService>(),
        messageService: gh<_i8.IMessageService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        requestService: gh<_i10.IRequestService>(),
        photo: gh<_i16.Photos>(),
      ));
  gh.factory<_i17.RegisterViewModel>(() => _i17.RegisterViewModel(
        connectionService: gh<_i4.IConnectionService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        messageService: gh<_i8.IMessageService>(),
      ));
  gh.factory<_i18.SearchViewModel>(() => _i18.SearchViewModel(
        requestService: gh<_i10.IRequestService>(),
        connectionService: gh<_i4.IConnectionService>(),
        messageService: gh<_i8.IMessageService>(),
        searchRepository: gh<_i12.ISearchRepository>(),
      ));
  gh.factory<_i19.SplashViewModel>(
      () => _i19.SplashViewModel(firebaseService: gh<_i6.IFirebaseService>()));
  gh.factory<_i20.FavoritesViewModel>(() => _i20.FavoritesViewModel(
        favDataService: gh<_i3.FavoritesDataService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        connectionService: gh<_i4.IConnectionService>(),
      ));
  gh.factory<_i21.IHomeRepository>(
      () => _i22.HomeRepository(requestService: gh<_i10.IRequestService>()));
  gh.factory<_i23.HomeViewModel>(() => _i23.HomeViewModel(
        homeRepository: gh<_i21.IHomeRepository>(),
        connectionService: gh<_i4.IConnectionService>(),
        messageService: gh<_i8.IMessageService>(),
        firebaseService: gh<_i6.IFirebaseService>(),
        favDataService: gh<_i3.FavoritesDataService>(),
      ));
  return getIt;
}
