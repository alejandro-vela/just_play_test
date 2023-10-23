import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_play_test/global_locator.dart';
import 'package:just_play_test/src/repository/cities/cities_repository.dart';
import 'package:just_play_test/src/repository/model/cities.dart';
import 'package:just_play_test/src/services/local_storage.dart';
import 'package:just_play_test/src/repository/model/event.dart';
import 'package:flutter/services.dart' show rootBundle;
part 'cities_event.dart';
part 'cities_state.dart';

class CitiesBloc extends Bloc<CitiesEvent, CitiesState> {
  final _api = global<CitiesRepository>();
  CitiesBloc() : super(CitiesInitial()) {
    on<CitiesEvent>((event, emit) {
      emit(CitiesInitial());
    });
    on<GetCitiesEvent>(_getCities);
  }

  Future<void> _getCities(
      GetCitiesEvent event, Emitter<CitiesState> emit) async {
    emit(LoadingCitiesState());
    try {
      if (LocalStorage().apiToken == '') {
        final response = await _api.getToken();
        if (response['statusCode'] == 200) {
          final token = response['auth_token'];
          LocalStorage().setApiToken = token;
        }
      }

      final response = await _api.getCities();
      if (response['statusCode'] == 200) {
        final List<CitiesModel> checks = response['data']
            .map<CitiesModel>((e) => CitiesModel.fromJson(e))
            .toList();
        final citiesResponse = checks.take(10).toList();
        citiesResponse.add(CitiesModel(stateName: 'Todos'));
        emit(
          LoadedCitiesState(cities: citiesResponse),
        );
      } else {
        emit(ErrorCitiesState(
            error: response['massage'] ?? 'Error al cargar las ciudades'));
      }
    } catch (e) {
      emit(ErrorCitiesState(error: e.toString()));
    }
  }

  Future<List<SoccerEvent>> loadSoccerEventData() async {
    String jsonString =
        await rootBundle.loadString('assets/static/json/events.json');

    final List<dynamic> parsedJson = json.decode(jsonString);

    return parsedJson.map((json) => SoccerEvent.fromJson(json)).toList();
  }
}
