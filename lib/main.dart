import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';

import 'package:money_land/themes/routes/routes.dart';

final db_Categories = CategoryDB();


main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoriesAdapter().typeId)) {
    Hive.registerAdapter(CategoriesAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  Hive.openBox<Categories>(db_Name);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          canvasColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
