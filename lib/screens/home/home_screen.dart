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
    Future.microtask(() => context.read<HomeViewModel>().getPhotos());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var isLoading = context.select((HomeViewModel home) => home.isLoading);
    var photos = context.select((HomeViewModel home) => home.photos);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 30.h, bottom: 8.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const _Header(),
                  Padding(
                    padding: EdgeInsets.only(top:19.h),
                    child: Icon(Icons.search,size: 30.sp),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: GridView.builder(
                  itemCount: isLoading ? 9 : photos.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0.h,
                    mainAxisSpacing: 20.0.w,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return isLoading
                        ? const _LoadingImageIndicator()
                        : _Image(index: index);
                  },
                ),
              ),
            ),
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
        Constant.titles.home,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _LoadingImageIndicator extends StatelessWidget {
  const _LoadingImageIndicator();

  @override
  Widget build(BuildContext context) {
    return SkeletonItem(
        child: SkeletonItem(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey,
          ),
        ),
      ));
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

    return Container(
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
      );
  }
}
