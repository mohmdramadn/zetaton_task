import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/main.dart';
import 'package:zetaton_task/screens/home/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
        value: getIt<HomeViewModel>(), child: const _Body());
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  @override
  void initState() {
    Future.microtask(() => context.read<HomeViewModel>().initialGetAllPhotos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = context.select((HomeViewModel home) => home.isLoading);

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: 30.h, bottom: 8.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const _Header(),
                Row(
                  children: [
                    const _SearchButton(),
                    SizedBox(width: 10.w),
                    const _FavoriteButton(),
                  ],
                ),
              ],
            ),
          ),
          isLoading ? const _LoadingGrid() : const _Photos(),
        ],
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 19.h),
      child: InkWell(
        onTap: () {},
        child: Icon(
          Icons.search,
          size: 30.sp,
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 19.h),
      child: InkWell(
        onTap: () => context
            .read<HomeViewModel>()
            .navigateToFavoritesScreenAction(),
        child: Icon(
          Icons.favorite,
          size: 30.sp,
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
    var photos = context.select((HomeViewModel home) => home.photos);

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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0.h, right: 8.0.w, left: 8.0.w),
      child: Text(
        Constant.titles.home,
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
    var photos = context.select((HomeViewModel home) => home.photos);

    return InkWell(
      onTap: () => context
          .read<HomeViewModel>()
          .navigateToDetailsScreenAction(photos[index]),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            photos[index].src!.medium!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
