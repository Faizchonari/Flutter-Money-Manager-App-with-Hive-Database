import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/model/catecory_model/catecory_model.dart';
import 'package:money_manager/model/transacion_model/transacion_model.dart';
import 'database/catecory_database.dart';
import 'screens/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryTypeAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(TransacionModelAdapter());
  await Hive.openBox<TransacionModel>(transacionDB_name);
  await Hive.openBox<CategoryModel>(categoryDB_name);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
