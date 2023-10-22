part of 'cities_bloc.dart';

sealed class CitiesEvent extends Equatable {
  const CitiesEvent();

  @override
  List<Object> get props => [];
}

final class CitiesInitialEvent extends CitiesEvent {}

final class GetCitiesEvent extends CitiesEvent {}
