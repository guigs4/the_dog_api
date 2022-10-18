import 'package:dio/dio.dart';
import 'package:the_dog_app/models/dog_image_model.dart';
import 'package:the_dog_app/models/preferences_model.dart';
import 'package:the_dog_app/secrets.dart';

class WebService {
  var dio = Dio(BaseOptions(baseUrl: 'https://api.thedogapi.com/v1', headers: {'x-api-key': Secrets.apiString}));

  Future<List<DogImage>> fetchRandomDogImages() async {
    return await fetchDogImages(order: 'RANDOM', breedId: '');
  }

  Future<List<DogImage>> fetchDogImages(
      {int page = 0,
      String size = "full",
      required String order,
      required String breedId}) async {
    String url = "/images/search";
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

  Future<List<BreedInfo>> fetchAllAvailableBreeds () async {
    String url = "/breeds";
    var response = await dio.get(url);
    List<BreedInfo> output = [];
    if (response.statusCode == 200) {
      final result = response.data;
      for(var breed in result){
        output.add(BreedInfo.fromJson(breed));
      }
      return output;
    } else {
      throw Exception('failed to get breeds');
    }
  }
}