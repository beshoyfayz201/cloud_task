import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: () {},
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "New Offers",
              style: TextStyle(
                  color: Color.fromRGBO(255, 253, 253, 1),
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}
