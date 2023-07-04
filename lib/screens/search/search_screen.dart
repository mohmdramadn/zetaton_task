import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:zetaton_task/components/app_button.dart';
import 'package:zetaton_task/components/app_fields.dart';
import 'package:zetaton_task/constants/constant_strings.dart';
import 'package:zetaton_task/main.dart';
import 'package:zetaton_task/screens/search/search_view_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>.value(
        value: getIt<SearchViewModel>(), child: const _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = context.select((SearchViewModel vm) => vm.searchController);
    var isLoading = context.select((SearchViewModel vm) => vm.isLoading);
    var photos = context.select((SearchViewModel vm) => vm.photos);

    return  Scaffold(
      body: Column(
        children: [
          const _Header(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Field(
              labelText: Constant.titles.search,
              validator: (value) {
                return null;
              },
              controller: controller,
            ),
          ),
          _SearchButton(isLoading: isLoading),
          if(photos.isNotEmpty) const _Photos(),
        ],
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: AppButton(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : const Icon(Icons.search),
          onPressed: () =>
              context.read<SearchViewModel>().onSearchAction(),
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
      padding: EdgeInsets.only(top: 50.0.h, right: 8.0.w, left: 8.0.w),
      child: Row(
        children: [
          Text(
            Constant.titles.search,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            Constant.titles.wallpaper,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontFamily: Constant.fonts.nexa),
          )
        ],
      ),
    );
  }
}

class _Photos extends StatelessWidget {
  const _Photos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var photos = context.select((SearchViewModel viewModel) => viewModel.photos);

    return Expanded(
      child: SizedBox(
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
    var photos = context.select((SearchViewModel vm) => vm.photos);

    return InkWell(
      onTap: () => context
          .read<SearchViewModel>()
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
