part of 'cities_bloc.dart';

sealed class CitiesState extends Equatable {
  const CitiesState();

  @override
  List<Object> get props => [];
}

final class CitiesInitial extends CitiesState {}

final class LoadedCitiesState extends CitiesState {
  final List<CitiesModel> cities;

  const LoadedCitiesState({required this.cities});
}

final class LoadingCitiesState extends CitiesState {}

final class ErrorCitiesState extends CitiesState {
  final String error;

  const ErrorCitiesState({required this.error});
}
