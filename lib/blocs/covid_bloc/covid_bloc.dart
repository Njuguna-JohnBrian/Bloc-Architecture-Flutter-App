import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc_weather/models/covid_model.dart';
import 'package:bloc_weather/resources/api_repository.dart';

part 'covid_event.dart';
part 'covid_state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final ApiRepository _apiRepositoy = ApiRepository();

    on<GetCovidList>((event, emit) async {
      try {
        emit(CovidLoading());
        final mList = await _apiRepositoy.fetchCovidList();
        emit(CovidLoaded(mList));
        if (mList.error != null) {
          emit(CovidError(mList.error));
        }
      } on NetworkError {
        emit(const CovidError("Failed to fetch data"));
      }
    });
  }
}
