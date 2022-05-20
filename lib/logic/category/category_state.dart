part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  final List<Categories> categoriesList;
  CategoryInitial({required this.categoriesList});
}
