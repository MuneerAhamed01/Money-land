part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class AddCategory extends CategoryEvent {
  final Categories list;
  AddCategory({required this.list});
}

class DeleteCategory extends CategoryEvent {
  final int key;
  final String name;
  DeleteCategory({required this.key,required this.name});
}

class EditCategory extends CategoryEvent {
  final int key;
  final Categories list;
  EditCategory({required this.key, required this.list});
}
