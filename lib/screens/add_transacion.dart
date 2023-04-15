import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/database/catecory_database.dart';
import 'package:money_manager/model/catecory_model/catecory_model.dart';
import 'package:money_manager/model/transacion_model/transacion_model.dart';
import 'package:money_manager/widgets/addAmountTextfeild.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'add_catecory.dart';
import '../constants.dart';

class AddTrasacionPage extends StatefulWidget {
  const AddTrasacionPage({super.key});

  @override
  State<AddTrasacionPage> createState() => _AddTrasacionPageState();
}

class _AddTrasacionPageState extends State<AddTrasacionPage> {
  final amountController = TextEditingController();

  CategoryModel? selectedCatecory;
  DateTime selectedDate = DateTime.now();
  ValueNotifier radioNotifear = ValueNotifier(CategoryType.income);
  String? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addTransacionButton(context),
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        backgroundColor: blackgradiant,
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: AmountTextfeild(amountController: amountController),
        ),
        toolbarHeight: MediaQuery.of(context).size.width * 0.25,
      ),
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              radioButton(CategoryType.income, 'Income', radioNotifear),
              radioButton(CategoryType.expanse, 'Expanse', radioNotifear),
            ],
          ),
          dateSelectionButton(context, selectedDate),
          addCatecoryButton(context),
          const SizedBox(
            height: 10,
          ),
          choiceClip()
        ],
      ),
    );
  }

  ValueListenableBuilder<Box<CategoryModel>> choiceClip() {
    return ValueListenableBuilder<Box<CategoryModel>>(
          valueListenable: CategoryDB.getCategory().listenable(),
          builder: (context, box, child) {
            final category = box.values.toList().cast<CategoryModel>();
            List<CategoryModel> filteredCategories;
            if (radioNotifear.value == CategoryType.income) {
              filteredCategories = category
                  .where((element) => element.type == CategoryType.income)
                  .toList();
            } else {
              filteredCategories = category
                  .where((element) => element.type == CategoryType.expanse)
                  .toList();
            }

            return filteredCategories.isEmpty
                ? emptyScreen(context)
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 1.5,
                        maxCrossAxisExtent:
                            MediaQuery.of(context).size.width / 4,
                      ),
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        return ChoiceChip(
                          label: Text(
                            filteredCategories[index].categoryName,
                            style: const TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                          onSelected: (selected) {
                            setState(() {
                              selectedCatecory = filteredCategories[index];
                            });
                          },
                          selected:
                              selectedCatecory == filteredCategories[index],
                          selectedColor: const Color(0xff007aff),
                          backgroundColor: blackgradiant,
                        );
                      },
                    ),
                  );
          },
        );
  }
  ElevatedButton addCatecoryButton(BuildContext context) {
    return ElevatedButton.icon(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              backgroundColor: blackgradiant,
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddCatecory();
              },
            );
          },
          icon: const Icon(Icons.add, color: Color(0xffffffff)),
          label: const Text(
            'Add Category',
            style: TextStyle(
              color: Color(0xffffffff),
            ),
          ),
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff007aff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
        );
  }

  TextButton dateSelectionButton(BuildContext context, DateTime selecteddate) {
    return TextButton.icon(
      onPressed: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 30)),
            lastDate: DateTime.now());
        setState(() {
          if (date == null) {
            return;
          }
          selecteddate = date;
        });
      },
      icon: const Icon(Icons.date_range, color: Color(0xff007aff)),
      label: Text(
        DateFormat.yMMMMEEEEd().format(selecteddate),
        style: const TextStyle(
          color: Color(0xffffffff),
        ),
      ),
    );
  }

  FloatingActionButton addTransacionButton(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text('A D D'),
      onPressed: () {
        final amount = double.tryParse(amountController.text);
        if (amountController.text.isEmpty) {
          return errInfo(context,
              'Please add an amount in the field as it is currently Empty');
        }
        if (selectedCatecory == null) {
          return errInfo(
              context, 'Please choose the income or expense category');
        }
        final newtransacion = TransacionModel(
            id: DateTime.now().microsecondsSinceEpoch.toString(),
            model: selectedCatecory!,
            date: selectedDate,
            amount: amount!,
            type: radioNotifear.value);
        TransacionDB.getTransacion().add(newtransacion);
        Navigator.of(context).pop();
      },
      backgroundColor: const Color(0xff007aff),
    );
  }

  void errInfo(BuildContext context, String text) {
    return showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: text),
    );
  }

  Row radioButton(
    CategoryType type,
    String title,
    ValueNotifier radiovalueNotifier,
  ) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.5,
          child: Radio(
            value: type,
            groupValue: radiovalueNotifier.value,
            onChanged: (value) {
              setState(() {
                radiovalueNotifier.value = value!;
              });
            },
            activeColor: const Color(0xff007aff),
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }
}
