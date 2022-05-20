import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:money_land/database/moneyland_model_class.dart';
import 'package:money_land/main.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  static final box = Hive.box<AddTransaction>(db_transaction);
  TransactionBloc()
      : super(TransactionInitial(
            list: box.values.toList())) {
    on<AddTrans>((event, emit) {
      box.add(event.transaction);
      emit(TransactionInitial(list: box.values.toList()));
    });
       on<DeleteTransaction>((event, emit) {
      box.delete(event.key);
      emit(TransactionInitial(list: box.values.toList()));
    });
    on<EditEvent>((event, emit) {
      box.put(event.key,event.transaction);
      emit(TransactionInitial(list: box.values.toList()));
    });
  }
}
 