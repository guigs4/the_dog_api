enum SortMethod { random, asc, desc }

class PreferencesModel {
  PreferencesModel({this.sortMethod = SortMethod.random, required this.selectedBreed});
  final SortMethod sortMethod;
  final BreedInfo selectedBreed;
}

//TODO: move to its own file
class BreedInfo {
  String? breedId;
  String? breedName;

  BreedInfo({this.breedId, this.breedName});

  factory BreedInfo.fromJson(Map<String, dynamic> json) =>
      BreedInfo(breedId: json['id'], breedName: json['name']);
}
