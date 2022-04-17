// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_land/database/database_crud/db_crud_transaction.dart';
import 'package:money_land/themes/routes/routes.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:month_year_picker/month_year_picker.dart';

final db_trans = TransactionDB();
final db_Categories = CategoryDB();
final db_transaction = 'Transaction';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoriesAdapter().typeId)) {
    Hive.registerAdapter(CategoriesAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(AddTransactionAdapter().typeId)) {
    Hive.registerAdapter(AddTransactionAdapter());
  }

  await Hive.openBox<Categories>(db_Name);
  await Hive.openBox<AddTransaction>(db_transaction);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        MonthYearPickerLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        errorColor: Colors.grey,

      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
