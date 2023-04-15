import 'package:flutter/material.dart';

import '../model/catecory_model/catecory_model.dart';

class RadioButton extends StatelessWidget {
   const RadioButton({super.key, 
    required this.selectedRadioCategoryNotifer,
    required this.title,
    required this.type,
  });

  final ValueNotifier selectedRadioCategoryNotifer;
  final String title;
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedRadioCategoryNotifer,
      builder: (context, value, child) {
        return Row(
          children: [
            Transform.scale(
              scale: 1.5,
              child: Radio(
                value: type,
                groupValue: value,
                onChanged: (value) {
                  selectedRadioCategoryNotifer.value = value;
                  selectedRadioCategoryNotifer.notifyListeners();
                },
              ),
            ),
            Text(
              title,
              style:
                  const TextStyle(color: Colors.white54, fontWeight: FontWeight.w500),
            ),
          ],
        );
      },
    );
  }
}
