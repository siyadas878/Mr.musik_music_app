import 'package:Mr.musik/infrastructure/search.dart';
import 'package:bloc/bloc.dart';
import '../../domain/model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState(searchdata: [])) {
        on<SearchEvent>((event, emit) {
      List<Songs> searchdata = search(event.querry);
      return emit(SearchState(searchdata: searchdata));
    });
  }
}
