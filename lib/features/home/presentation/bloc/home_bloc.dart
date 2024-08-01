import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soundspace/core/usecase/usecase.dart';
import 'package:soundspace/features/home/domain/usecase/load_track.dart';

import '../../domain/entitites/track.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadData _loadData;
  HomeBloc({
    required LoadData loadData,
  })  : _loadData = loadData,
        super(HomeInitial()) {
    on<HomeEvent>((_, emit) => emit(HomeLoading()));
    on<TrackLoadData>(_onTrackLoadData);
  }
  void _onTrackLoadData(
    TrackLoadData event,
    Emitter<HomeState> emit,
  ) async {
    final res = await _loadData(NoParams());
    res.fold(
      (failure) => emit(TrackFailure(failure.message)),
      (tracks) => emit(TrackSuccess(tracks)),
    );
  }
}
