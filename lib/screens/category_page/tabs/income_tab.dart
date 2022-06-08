import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/logic/category/category_bloc.dart';
import 'package:money_land/main.dart';
import 'package:money_land/screens/category_page/assest/functions.dart';

import '../../../database/database_crud/db_crud_categories.dart';

class Income extends StatelessWidget {
  const Income({Key? key}) : super(key: key);

  @override
//  late int? accesKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        state as CategoryInitial;
        
        final inc = state.income;
        return inc.isEmpty
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center, 
                children: [
                  SvgPicture.asset(
                    "lib/global/images/sentiment_very_dissatisfied.svg",
                    color: Colors.grey, 
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const Text("No category available"),
                  ),
                ],
              ))
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    child: ListTile(
                      title: Text(
                        inc[index].category!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.sp),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              bottomSheet(
                                  context: context,
                                  dbType: CategoryType.income,
                                  type: "Edit Income",
                                  typeof: Creating.editing,
                                  index: inc[index].key,
                                  initial: inc[index].category);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showPopUp(inc[index], context);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: inc.length,
              );
      }),
    );
  }

  showPopUp(Categories delete, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(' Are you sure'),
        content: const Text('You Want to delete the item? '),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<CategoryBloc>().add(DeleteCategory(key: delete.key,name: delete.category!));
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  // dbConnect(String? inc) {
  //   final db = Hive.box<Categories>(db_Name).values.toList();

  //   for (int i = 0; i <= db.length; i++) {
  //     // if (db[i].category == inc) {
  //     //   setState(() {
  //     //     accesKey = i;
  //     //   });

  //     //   break;
  //     // }
  //   }
  // }
}
