import 'package:hive_flutter/adapters.dart';
part 'moneyland_model_class.g.dart';

@HiveType(typeId: 1)
enum CategoryType {
  @HiveField(0)
  income,
  @HiveField(1)
  expense
}

@HiveType(typeId: 0)
class Categories extends HiveObject {
  @HiveField(0)
  String? category;

  @HiveField(1)
  CategoryType? type;

  Categories({this.category, this.type});
}

@HiveType(typeId: 2)
class AddTransaction extends HiveObject {
  @HiveField(0)
  DateTime? date;
  @HiveField(1)
  Categories? category;
  @HiveField(2)
  double? amount;
  @HiveField(3)
  String? notes;
  @HiveField(4)
  CategoryType? type;
  @HiveField(5)
  bool visible;

  AddTransaction({
    this.visible = false,
    this.date,
    this.category,
    this.amount,
    this.notes,
    this.type,
  });
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs

