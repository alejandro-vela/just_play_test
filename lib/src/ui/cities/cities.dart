import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_play_test/global_locator.dart';
import 'package:just_play_test/src/bloc/cities/cities_bloc.dart';
import 'package:just_play_test/src/services/navigation_service.dart';
import 'package:just_play_test/src/ui/home_screen/home_screen.dart';

class CitiesScreen extends StatefulWidget {
  static const String routeName = '/cities';
  const CitiesScreen({super.key});

  @override
  State<CitiesScreen> createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  @override
  void initState() {
    global<CitiesBloc>().add(GetCitiesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CitiesBloc, CitiesState>(
        bloc: global<CitiesBloc>(),
        listener: (context, state) async {
          if (state is ErrorCitiesState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is LoadingCitiesState) {
            return Scaffold(
              appBar: AppBar(
                title: Text(''),
                automaticallyImplyLeading: false,
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoadedCitiesState) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Ciudades'),
              ),
              body: ListView.builder(
                itemCount: state.cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.cities[index].stateName),
                    onTap: () => {
                      NavigationService.pushAndRemoveUntil(
                          context: context,
                          screen:
                              HomeScreen(city: state.cities[index].stateName),
                          routeName: HomeScreen.routeName),
                    },
                  );
                },
              ),
            );
          }
          return Center(
            child: Text('No hay ciudades'),
          );
        });
  }
}
