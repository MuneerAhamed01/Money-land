import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'notificaton_state.dart';

class NotificatonCubit extends Cubit<NotificatonState> {
  static final boxList = Hive.box<AddTransaction>(db_transaction);
//  static SharedPreferences prefs = await SharedPreferences.getInstance();

  NotificatonCubit()
      : super(NotificationInitial(
            totalExp: 0,
            totalInc: 0,
            transactionList: boxList.values.toList()));

  void getNotification() {
    final list = boxList.values.toList();
    double? amountExp;
    double? amountInc;
    for (var i = 0; i < list.length; i++) {
      if (list[i].type == CategoryType.expense) {
        amountExp = list[i].amount! + amountExp!;
      } else {
        amountInc = list[i].amount! + amountInc!;
      }
    }

    emit(NotificationInitial(
      totalExp: amountExp!,
      totalInc: amountInc!,
      transactionList: list,
    ));
  }

  getSwitchValues() async {
    // isSwitchedFT = await getSwitchState();
  }

  

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState") ?? false;

    return isSwitchedFT;
  }

  changeOf(bool value) async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("switchState", value);
    emit(ChangeListTail(value: value));
  }
}
