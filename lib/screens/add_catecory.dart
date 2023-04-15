import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:money_manager/constants.dart';
import 'package:money_manager/database/catecory_database.dart';
import 'package:money_manager/widgets/radio_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../model/catecory_model/catecory_model.dart';

class AddCatecory extends StatefulWidget {
  const AddCatecory({
    super.key,
  });

  @override
  State<AddCatecory> createState() => _AddCatecoryState();
}

class _AddCatecoryState extends State<AddCatecory> {
  final _categoryNameController = TextEditingController();

  ValueNotifier selectedRadioCategoryNotifer =
      ValueNotifier(CategoryType.income);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Neumorphic(
                style: NeumorphicStyle(
                  color: blackgradiant,
                  intensity: 0.5,
                  depth: 3,
                  shape: NeumorphicShape.convex,
                  lightSource: LightSource.topLeft,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white70),
                  textAlign: TextAlign.center,
                  maxLength: 20,
                  controller: _categoryNameController,
                  decoration: InputDecoration(
                      hintStyle: const TextStyle(color: Colors.white54),
                      helperText: ' Example : Salary, Bills...',
                      helperStyle: const TextStyle(color: Colors.white38),
                      hintText: 'Add Catecory',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RadioButton(
                  selectedRadioCategoryNotifer: selectedRadioCategoryNotifer,
                  title: 'Income',
                  type: CategoryType.income),
              RadioButton(
                  selectedRadioCategoryNotifer: selectedRadioCategoryNotifer,
                  title: 'Expanse',
                  type: CategoryType.expanse),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  padding: const EdgeInsets.all(10),
                  shape: const CircleBorder()),
              onPressed: () {
                final title = _categoryNameController.text;
                if (title.isEmpty) {
                  showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.info(
                          message:
                              'Enter income or expenses (e.g. salary, electricity) in empty category field.'));
                  return;
                }

                final category = CategoryModel(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    categoryName: title,
                    type: selectedRadioCategoryNotifer.value);
                final box = CategoryDB.getCategory();
                box.add(category);
                _categoryNameController.clear();
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
