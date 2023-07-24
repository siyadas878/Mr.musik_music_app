import 'package:bloc/bloc.dart';

import '../../dataBase/mostPLayed/MostFunction.dart';
import '../../infrastructure/fetch.dart';
import '../../domain/model.dart';
part 'most_event.dart';
part 'most_state.dart';

class MostBloc extends Bloc<MostEvent, MostState> {
  MostBloc() : super(MostState(mostPlayedList: [])) {
    on<MostPlayedFetch>((event, emit) async {
      List<Songs> data = await mostplayedfetch();
      return emit(MostState(mostPlayedList: data));
    });

    on<MostPlayedAdd>((event, emit) async {
      List<Songs> data = await mostplayedaddtodb(
          id: event.songid, mostPlayedList: state.mostPlayedList);
      return emit(MostState(mostPlayedList: data));
    });
  }
}
