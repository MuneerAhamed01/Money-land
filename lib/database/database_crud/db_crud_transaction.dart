import 'package:hive_flutter/adapters.dart';

import '../../main.dart';
import '../moneyland_model_class.dart';

class TransactionDB {
  Future<void> addTransactions(AddTransaction value) async {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);

    await dbOpen.add(value);
    
  }

  Future<List<AddTransaction>> getTrasaction() async {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);
    return dbOpen.values.toList();
  }

 

  deleteTransaction(int key) {
    Hive.box<AddTransaction>(db_transaction).delete(key);
  }

  updateTransaction(int index, AddTransaction value) {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);
    dbOpen.putAt(index, value);
  
  }

  clearTransactionHive() {
    final dbOpen = Hive.box<AddTransaction>(db_transaction);
    dbOpen.clear();
  }
}
