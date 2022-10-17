enum SortMethod { random, asc, desc }

class PreferencesModel {
  PreferencesModel({this.sortMethod = SortMethod.random, required this.selectedBreed});
  final SortMethod sortMethod;
  final BreedInfo selectedBreed;
}

//TODO: move to its own file
class BreedInfo {
  String breedId;
  String breedName;

  BreedInfo({this.breedId = "", this.breedName = "None"});

  //'id' is supposed to come as a String but it's being passed as an int so the
  //conversion is necessary
  factory BreedInfo.fromJson(Map<String, dynamic> json) =>
      BreedInfo(breedId: json['id'].toString(), breedName: json['name']);
}
