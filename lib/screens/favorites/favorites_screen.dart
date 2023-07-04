import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/main.dart';
import 'package:zetaton_task/screens/favorites/favorites_view_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesViewModel>.value(
        value: getIt<FavoritesViewModel>(), child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    Future.microtask(
        () => context.read<FavoritesViewModel>().getFavoriteWallpapers());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var isLoading = context.select((FavoritesViewModel home) => home.isLoading);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 30.h, bottom: 8.h, left: 16.w, right: 16.w),
              child: const _Header(),
            ),
            isLoading ? const _LoadingGrid() : const _Photos(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0.h, right: 8.0.w, left: 8.0.w),
      child: Text(
        Constant.firebaseQueryParam.favorites,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _Image extends StatelessWidget {
  const _Image({
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    var photos = context.select((FavoritesViewModel home) => home.photos);

    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            photos[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _LoadingGrid extends StatelessWidget {
  const _LoadingGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0.h,
            mainAxisSpacing: 20.0.w,
          ),
          itemBuilder: (context, int index) {
            return SkeletonItem(
              child: SkeletonItem(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Photos extends StatelessWidget {
  const _Photos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photos = context.select((FavoritesViewModel home) => home.photos);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          itemCount: photos.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20.0.h,
            mainAxisSpacing: 20.0.w,
          ),
          itemBuilder: (context, int index) {
            return _Image(index: index);
          },
        ),
      ),
    );
  }
}
