import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_provider.g.dart';

@riverpod
class HomePageIndex extends _$HomePageIndex {
  @override
  int? build() => null; 

  void changeIndex(int newIndex){
    state = newIndex;
  }
}