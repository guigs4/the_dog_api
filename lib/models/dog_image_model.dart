class DogImage{
  final String id;
  final String url;
  String categories = ""; //TODO: Category Class
  String breeds = ""; //TODO: Breed Class

  DogImage({required this.id, required this.url});

  factory DogImage.fromJson(Map<String,dynamic> json){
    return DogImage(
      id: json['id'],
      url: json['url']
    );
  }
}