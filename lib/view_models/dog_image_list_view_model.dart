import 'package:flutter/material.dart';
import 'package:the_dog_app/models/dog_image_model.dart';
import 'package:the_dog_app/services/web_service.dart';
import 'dog_image_view_model.dart';

enum LoadingStatus{ //REMEMBER TO USE THIS SHIT THIS TIME MF
  completed,
  searching,
  empty
}

class DogImageListViewModel with ChangeNotifier{
  LoadingStatus loadingStatus = LoadingStatus.empty;
  List<DogImageViewModel> images = <DogImageViewModel>[];

  void randomDogImages() async {
    List<DogImage> dogImages = await WebService().fetchRandomDogImages();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    images = dogImages.map((dogImage) => DogImageViewModel(image: dogImage)).toList();

    if (images.isEmpty){
      loadingStatus = LoadingStatus.empty;
    }else{
      loadingStatus = LoadingStatus.completed;
    }
    notifyListeners();
  }
}