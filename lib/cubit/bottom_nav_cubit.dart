import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  /// update index function to update the index onTap in BottomNavigationBar
  void updateIndex(int index) => emit(index);

  /// for navigation button on single page
  void getBasket() => emit(0);
  void getCatalogue() => emit(1);
  void getProfile() => emit(2);
}
