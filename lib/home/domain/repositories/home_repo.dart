
import 'dart:convert';

import 'package:cloud_task/core/errors/api_error_handler.dart';
import 'package:cloud_task/core/errors/general_error_message.dart';

import 'package:cloud_task/home/data/models/paginated_real_state.dart';
import 'package:cloud_task/services/network/json_data.dart';

import 'package:dartz/dartz.dart';

class HomeRepo {

  Future<Either<ErrorMessage, PaginatedRealEstate>> getData(int page) async {
    try {
     Map<String, dynamic> jsonString = await jsonDecode(jsonResponse[page]!);//json api simulation

      return Right( 
      PaginatedRealEstate.fromJson(jsonString));
    } on PrimaryServerException catch (e) {
      return Left(ErrorMessage(message: e.message, status: false));
    } catch (e) {
      return Left(ErrorMessage(message: "fail to load Data", status: false));
    }
  }
}
