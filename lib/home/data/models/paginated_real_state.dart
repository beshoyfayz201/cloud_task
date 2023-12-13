import 'package:cloud_task/home/data/models/real_state.dart';

class PaginatedRealEstate {
  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;
  final List<RealEstateModel> data;

  PaginatedRealEstate({
    required this.currentPage,
    required this.lastPage,
    required this.perPage,
    required this.total,
    required this.data,
  });

  factory PaginatedRealEstate.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<RealEstateModel> realEstates =
        list.map((e) => RealEstateModel.fromJson(e)).toList();

    return PaginatedRealEstate(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
      data: realEstates,
    );
  }
}