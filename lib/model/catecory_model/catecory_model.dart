import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'catecory_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String categoryName;
  @HiveField(2)
  late CategoryType type;

  CategoryModel(
      {required this.id, required this.categoryName, required this.type});
}

@HiveType(typeId: 2)
enum CategoryType {
  @HiveField(1)
  income,
  @HiveField(2)
  expanse
}
