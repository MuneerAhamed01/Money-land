part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  final List<Categories> categoriesList;
  final List<Categories> expense;
  final List<Categories> income;
  CategoryInitial(
      {required this.categoriesList,
      required this.expense,
      required this.income});
}
