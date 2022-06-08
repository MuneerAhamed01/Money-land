import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_land/database/moneyland_model_class.dart';

import 'package:money_land/screens/category_page/assest/functions.dart';
import 'package:money_land/logic/category/category_bloc.dart';

// ignore: must_be_immutable

class Expense extends StatelessWidget {
  const Expense({Key? key}) : super(key: key);
  

  @override

  // int? accesKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:
          BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
        state as CategoryInitial;

        final exp = state.expense;

        return exp.isEmpty
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
                        exp[index].category!,
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
                                  dbType: CategoryType.expense,
                                  type: "Edit Expense",
                                  typeof: Creating.editing,
                                  index: exp[index].key,
                                  initial: exp[index].category);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showPopUp(exp[index], context);
                            },
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: exp.length,
              );
      }),
    );
  }

  showPopUp(Categories delete, BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text(' Are  you sure'),
        content: const Text('You Want to delete the item?'),
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
}
