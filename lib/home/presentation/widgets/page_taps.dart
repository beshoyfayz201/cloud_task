import 'package:cloud_task/home/presentation/widgets/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SizedBox buildPageTabs() {
  return SizedBox(
    height: Get.height * 0.07,
    child: ListView(scrollDirection: Axis.horizontal, children: const [
      IconTextButton(
        icon: Icons.arrow_upward_rounded,
        txt: "Popular",
        index: 0,
      ),
      IconTextButton(
        icon: Icons.local_fire_department,
        txt: "Trending",
        index: 1,
      ),
      IconTextButton(
        icon: Icons.favorite,
        txt: "Favourite",
        index: 2,
      )
    ]),
  );
}
