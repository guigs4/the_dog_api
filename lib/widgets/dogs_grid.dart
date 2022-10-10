import 'package:flutter/material.dart';
import '../view_models/dog_image_view_model.dart';
import 'circle_widget.dart';

class DogsGrid extends StatelessWidget {
  final List<DogImageViewModel> dogImages;
  const DogsGrid({super.key, required this.dogImages});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        var dog = dogImages[index];
        return GridTile(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: CircleImage(imageUrl: dog.url,),
          ),
        );
      },
      itemCount: dogImages.length,
    );
  }
}
