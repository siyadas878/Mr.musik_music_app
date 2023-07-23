import 'package:Mr.musik/infrastructure/fetch.dart';
import 'package:Mr.musik/domain/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dataBase/recentlyplayed/recently.dart';
part 'recently_event.dart';
part 'recently_state.dart';

class RecentlyBloc extends Bloc<RecentlyEvent, RecentlyState> {
  RecentlyBloc() : super(RecentlyState(recentList: [])) {
    on<RecentFetch>((event, emit) async {
      List<Songs> recent = await recentfetch();
      return emit(RecentlyState(recentList: recent));
    });

    on<RecentAdd>((event, emit) async {
      List<Songs> data =
          await recentadd(id: event.songid, recentList: state.recentList);
      return emit(RecentlyState(recentList: data));
    });
  }
}
