import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_dog_app/view_models/dog_image_list_view_model.dart';
import 'package:the_dog_app/widgets/dogs_grid.dart';
import 'package:the_dog_app/widgets/paged_dogs_grid.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<DogImageListViewModel>(context, listen: false)
        .randomDogImages();
  }

  @override
  Widget build(BuildContext context) {
    var listViewModel = Provider.of<DogImageListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              // open prefs screen
            },
          )
        ],
        title: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Doggos :D',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PagedDogsGrid(
                dogImages: listViewModel.images,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
