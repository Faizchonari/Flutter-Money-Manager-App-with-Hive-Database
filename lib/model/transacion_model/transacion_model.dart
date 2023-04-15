import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/model/catecory_model/catecory_model.dart';
part 'transacion_model.g.dart';

@HiveType(typeId: 3)
class TransacionModel extends HiveObject {
  @HiveField(1)
  String id;
  @HiveField(2)
  CategoryModel model;
  @HiveField(3)
  CategoryType type;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  double amount;
  TransacionModel(
      {required this.id,
      required this.model,
      required this.date,
      required this.amount,
      required this.type});
}
