// ignore_for_file: non_constant_identifier_names, prefer_const_declarations

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_land/database/database_crud/db_crud_transaction.dart';
import 'package:money_land/themes/colors/colors.dart';
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
  await ScreenUtil.ensureScreenSize();
  AwesomeNotifications()
      .initialize("resource://drawable/res_notification_icon", [
    NotificationChannel(
        locked: true,
        onlyAlertOnce: true,
        importance: NotificationImportance.High,
        channelKey: "Channel_key",
        channelName: "Basic_notification",
        channelDescription: "channelDescription")
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.72727272727275, 825.4545454545455),
        // splitScreenMode: true,
        minTextAdapt: false,
        builder: (context) {
          return MaterialApp(
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 0.8),
                child: child!),
            useInheritedMediaQuery: true,
            localizationsDelegates: const [
              MonthYearPickerLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: TextTheme(
                  bodyText2: TextStyle(fontSize: 14.sp),
                  button: TextStyle(fontSize: 13.sp)),
              errorColor: Colors.grey,
              canvasColor: transparent,
            ),
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        });
  }
}
