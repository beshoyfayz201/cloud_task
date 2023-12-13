import 'package:cloud_task/home/domain/entity/real_estate_entity.dart';

class RealEstateModel extends RealEstateEntity {


  RealEstateModel({
  required super.name,
  required super.description,
  required super.imageUrl,
  required super.location,
  required super.price,
  });
  factory RealEstateModel.fromJson(Map<String, dynamic> json) {
    return RealEstateModel(
      name: json['name'],
      description: json['description'],
      location: json['location'],
      price: json['price'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'description': description});
    result.addAll({'location': location});
    result.addAll({'price': price});
    result.addAll({'image_url': imageUrl});

    return result;
  }
}
