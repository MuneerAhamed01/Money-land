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
  bool? valueOf;

  @HiveField(3)
  CategoryType? type;

  Categories({this.category, this.valueOf = false, this.type});
}

// flutter packages pub run build_runner watch --use-polling-watcher --delete-conflicting-outputs

