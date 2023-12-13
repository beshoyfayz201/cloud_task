import 'package:cloud_task/home/data/models/real_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RealEstateWidget extends StatelessWidget {
  const RealEstateWidget({
    super.key,
    required this.realEstate,
  });

  final RealEstateModel realEstate;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.2,
            width: Get.width,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  realEstate.imageUrl,
                  fit: BoxFit.fitWidth,
                  isAntiAlias: true,
                ),
                Positioned(
                  right: 10,
                  bottom: 5,
                  child: Chip(
                    label: Text('${realEstate.price}\$'),
                  ),
                )
              ],
            ),
          ),
          ListTile(
              title: Text(realEstate.name),
              subtitle: Text(realEstate.description)),
        ],
      ),
    );
  }
}
