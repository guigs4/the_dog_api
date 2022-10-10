import '../models/dog_image_model.dart';

class DogImageViewModel{
  final DogImage _dogImage;

  DogImageViewModel({required DogImage image}) : _dogImage = image;

  String get id{
    return _dogImage.id;
  }

  String get url{
    return _dogImage.url;
  }

  String get categories{ //PLACEHOLDER: See dog_image_model.dart
    return _dogImage.categories;
  }

  String get breeds{ //PLACEHOLDER: See dog_image_model.dart
    return _dogImage.breeds;
  }
}