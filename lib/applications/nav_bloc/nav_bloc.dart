import 'package:flutter_bloc/flutter_bloc.dart';
part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState(navIndex: 0)) {
    on<NavEvent>((event, emit) {
      return emit(NavState(navIndex: event.index)); 
    });
  }
}
