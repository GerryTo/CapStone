import 'package:equatable/equatable.dart';
import 'package:state_notifier/state_notifier.dart';

class HomeViewModel extends StateNotifier<HomeIndex> {
  HomeViewModel(int index) : super(HomeIndex(index));

  void changeIndex(int index) => state = HomeIndex(index);
}

class HomeIndex extends Equatable {
  final int index;
  const HomeIndex(this.index);

  @override
  List<Object?> get props => [index];
}
