import 'package:cloud_task/home/data/models/paginated_real_state.dart';
import 'package:cloud_task/home/data/models/real_state.dart';
import 'package:cloud_task/home/domain/repositories/home_repo.dart';
import 'package:cloud_task/services/local_db/sql_helper.dart';
import 'package:cloud_task/shared/widgets/custom_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = RxBool(false);
  Rxn<PaginatedRealEstate?> data = Rxn<PaginatedRealEstate?>();
  int currentPage = 0;
  RxBool hasMore = RxBool(true);
  ScrollController scrollController = ScrollController();

  @override
  onInit() async {
    await getCashedData();
    scrollController.addListener(() {
      scrollListener();
    });
    super.onInit();
  }

  @override
  onClose() {
    scrollController.dispose();
  }

  Future<void> getData() async {
    if (hasMore.value) {
      isLoading.value = true;
      var response = await HomeRepo().getData(++currentPage);
      response.fold((err) {
        buildCustomSnackbar(err.message);
      }, (result) async {
        if (data.value == null) {
          data.value = result;
        } else {
          data.value!.data.addAll(result.data);
        }
        await cashData(result);
      });
      isLoading.value = false;
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getData();
    }
  }

  Future<void> getCashedData() async {
    isLoading.value = true;
    if (data.value == null) {
      // Try loading from the database
      List<RealEstateModel> cachedData =
          await DatabaseHelper.instance.getRealEstates();
      int? cachedTotalPages =
          await DatabaseHelper.instance.getSetting('last_page');
      if (cachedData.isNotEmpty) {
        createIntialDataOpject(cachedData, cachedTotalPages);
      } else {
        await getData();
      }
    }
    isLoading.value = false;
  }

  void createIntialDataOpject(
      List<RealEstateModel> cachedData, int? cachedTotalPages) {
    PaginatedRealEstate initalOpj = PaginatedRealEstate(
        currentPage: cachedData.length ~/ 10,
        lastPage: cachedTotalPages!,
        perPage: 10,
        total: cachedTotalPages,
        data: cachedData);
                hasMore.value = cachedTotalPages > initalOpj.currentPage;

    data.value = initalOpj;
  }

  Future<void> cashData(PaginatedRealEstate nextPage) async {
    await DatabaseHelper.instance
        .insertSettings('last_page', nextPage.lastPage.toString());
        currentPage = nextPage.currentPage;
    hasMore.value = nextPage.lastPage > currentPage;

    for (RealEstateModel realEstate in nextPage.data) {
      await DatabaseHelper.instance.insertRealEstate(realEstate);
    }
  }
}
