import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/contract/remote/i_details_repository.dart';
import 'package:zetaton_task/contract/services/i_connection_service.dart';
import 'package:zetaton_task/contract/services/i_firebase_service.dart';
import 'package:zetaton_task/contract/services/i_message_service.dart';
import 'package:zetaton_task/contract/services/i_request_service.dart';
import 'package:zetaton_task/main.dart';
import 'package:zetaton_task/models/photos.dart';
import 'package:zetaton_task/screens/photo_details/photo_details_view_model.dart';

class PhotoDetailsScreen extends StatelessWidget {
  const PhotoDetailsScreen({Key? key, required this.photo}) : super(key: key);

  final Photos photo;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PhotoDetailsViewModel>(
        create: (_) => PhotoDetailsViewModel(
              connectionService: getIt<IConnectionService>(),
              messageService: getIt<IMessageService>(),
              firebaseService: getIt<IFirebaseService>(),
              requestService: getIt<IRequestService>(),
              detailsRepository: getIt<IDetailsRepository>(),
              photo: photo,
            ),
        child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _Image(),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.85,
          bottom: MediaQuery.of(context).size.height * 0.09,
          left: MediaQuery.of(context).size.width * 0.60,
          right: MediaQuery.of(context).size.width * 0.06,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_DownloadButton(), _FavouriteButton()],
          ),
        ),
      ],
    );
  }
}

class _FavouriteButton extends StatelessWidget {
  const _FavouriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isAddedToFav =
        context.select((PhotoDetailsViewModel vm) => vm.isAddedToFav);

    return ElevatedButton(
      onPressed: () =>
          context.read<PhotoDetailsViewModel>().onFavoriteSelectedActionAsync(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Icon(isAddedToFav ? Icons.favorite : Icons.favorite_border,
          color: Colors.red),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photo =
        context.select((PhotoDetailsViewModel viewModel) => viewModel.photo);

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.network(
          photo.src!.large!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _DownloadButton extends StatelessWidget {
  const _DownloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photo =
        context.select((PhotoDetailsViewModel viewModel) => viewModel.photo);

    return ElevatedButton(
      onPressed: () => context
              .read<PhotoDetailsViewModel>()
              .onDownloadImageSelectedAction(photo.src!.large!),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      child: Icon(Icons.download, color: Theme.of(context).primaryColor),
    );
  }
}
