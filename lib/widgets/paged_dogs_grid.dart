import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:the_dog_app/models/dog_image_model.dart';
import 'package:the_dog_app/services/web_service.dart';

import '../view_models/dog_image_view_model.dart';
import 'circle_widget.dart';

class PagedDogsGrid extends StatefulWidget {
  const PagedDogsGrid({
    required this.dogImages,
    super.key,
  });

  final List<DogImageViewModel> dogImages;

  @override
  _PagedDogsGridState createState() => _PagedDogsGridState();
}

class _PagedDogsGridState extends State<PagedDogsGrid> {
  final _pagingController = PagingController<int, DogImage>(
    firstPageKey: 0,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final web = WebService();
      final newPage = await web.fetchDogImages(
        page: pageKey,
        //TODO: FILTERING
      );

      final previouslyFetchedItemsCount =
          _pagingController.itemList?.length ?? 0;

      //TODO: Check if last page
      final isLastPage = false;
      // TODO: Implement the function's body.

      if (isLastPage) {
        _pagingController.appendLastPage(newPage);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newPage, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedGridView(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          builderDelegate: PagedChildBuilderDelegate<DogImage>(
            itemBuilder: (context, dog, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: CircleImage(
                imageUrl: dog.url,
              ),
            ),
            firstPageErrorIndicatorBuilder: (context) => const Placeholder(),
            noItemsFoundIndicatorBuilder: (context) => const Placeholder(),
          ),
        ),
      );
}
