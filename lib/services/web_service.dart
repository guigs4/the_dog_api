import 'package:dio/dio.dart';
import 'package:the_dog_app/models/dog_image_model.dart';
import 'package:the_dog_app/secrets.dart';

import '../view_models/dog_image_list_view_model.dart'; //pseudo 'UserSecrets'

class WebService {
  var dio = Dio();
  Map<String, dynamic> headers = {'x-api-key': Secrets.apiString};

  Future<List<DogImage>> fetchRandomDogImages() async {
    return await fetchDogImages();
  }

  Future<List<DogImage>> fetchDogImages(
      {int page = 0,
      String size = "full",
      String order = "RANDOM",
      String breedId = ""}) async {
    String url = "https://api.thedogapi.com/v1/images/search";
    dio.options.headers = headers;
    var response = await dio.get(url, queryParameters: {
      'page': page,
      'size': size,
      'order': order,
      'limit': 100,
      'breed_id': breedId
    });

    if (response.statusCode == 200) {
      final result = response.data;
      List<DogImage> output = [];
      for (var image in result) {
        output.add(DogImage.fromJson(image));
      }
      return output;
    } else {
      throw Exception('failed to get dog images');
    }
  }
}