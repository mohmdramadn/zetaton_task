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

import 'contract/remote/i_details_repository.dart' as _i13;
import 'contract/remote/i_home_repository.dart' as _i15;
import 'contract/services/i_connection_service.dart' as _i3;
import 'contract/services/i_firebase_service.dart' as _i5;
import 'contract/services/i_message_service.dart' as _i7;
import 'contract/services/i_request_service.dart' as _i9;
import 'models/photos.dart' as _i18;
import 'repositories/details_repository.dart' as _i14;
import 'repositories/home_repository.dart' as _i16;
import 'screens/home/home_view_model.dart' as _i19;
import 'screens/login/login_view_model.dart' as _i11;
import 'screens/photo_details/photo_details_view_model.dart' as _i17;
import 'screens/register/register_view_model.dart' as _i12;
import 'services/connection_service.dart' as _i4;
import 'services/firebase_service.dart' as _i6;
import 'services/message_service.dart' as _i8;
import 'services/request_service.dart' as _i10;

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
  gh.singleton<_i9.IRequestService>(_i10.RequestService());
  gh.factory<_i11.LoginViewModel>(() => _i11.LoginViewModel(
        connectionService: gh<_i3.IConnectionService>(),
        firebaseService: gh<_i5.IFirebaseService>(),
        messageService: gh<_i7.IMessageService>(),
      ));
  gh.factory<_i12.RegisterViewModel>(() => _i12.RegisterViewModel(
        connectionService: gh<_i3.IConnectionService>(),
        firebaseService: gh<_i5.IFirebaseService>(),
        messageService: gh<_i7.IMessageService>(),
      ));
  gh.factory<_i13.IDetailsRepository>(
      () => _i14.DetailsRepository(requestService: gh<_i9.IRequestService>()));
  gh.factory<_i15.IHomeRepository>(
      () => _i16.HomeRepository(requestService: gh<_i9.IRequestService>()));
  gh.factory<_i17.PhotoDetailsViewModel>(() => _i17.PhotoDetailsViewModel(
        connectionService: gh<_i3.IConnectionService>(),
        messageService: gh<_i7.IMessageService>(),
        firebaseService: gh<_i5.IFirebaseService>(),
        requestService: gh<_i9.IRequestService>(),
        detailsRepository: gh<_i13.IDetailsRepository>(),
        photo: gh<_i18.Photos>(),
      ));
  gh.factory<_i19.HomeViewModel>(() => _i19.HomeViewModel(
        homeRepository: gh<_i15.IHomeRepository>(),
        connectionService: gh<_i3.IConnectionService>(),
        messageService: gh<_i7.IMessageService>(),
      ));
  return getIt;
}
