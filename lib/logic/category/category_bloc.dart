import 'package:bloc/bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meta/meta.dart';
import 'package:money_land/database/database_crud/db_crud_categories.dart';
import 'package:money_land/database/moneyland_model_class.dart';
part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final box = Hive.box<Categories>(db_Name);
  CategoryBloc()
      : super(CategoryInitial(
            categoriesList: Hive.box<Categories>(db_Name).values.toList())) {
    on<AddCategory>((event, emit) {
      box.add(event.list);
      emit(CategoryInitial(categoriesList: box.values.toList()));
    });
    on<DeleteCategory>((event, emit) {
      box.delete(event.key);
      emit(CategoryInitial(categoriesList: box.values.toList()));
    });
    on<EditCategory>((event, emit) { 
         box.put(event.key, event.list);
      emit(CategoryInitial(categoriesList: box.values.toList()));
    }); 
  }
}
