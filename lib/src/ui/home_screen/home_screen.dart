import 'package:flutter/material.dart';
import 'package:just_play_test/global_locator.dart';
import 'package:just_play_test/src/repository/model/event.dart';
import 'package:just_play_test/src/widgets/cards/home_cards.dart';
import 'package:just_play_test/src/widgets/side_menu/side_menu.dart';

import '../../bloc/cities/cities_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  final String? city;

  const HomeScreen({super.key, this.city});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<SoccerEvent>> futureEvents;
  @override
  void initState() {
    if (widget.city != null && widget.city != 'Todos') {
      futureEvents = global<CitiesBloc>().loadSoccerEventData().then((events) =>
          events.where((event) => event.stateName == widget.city).toList());
    } else {
      futureEvents = global<CitiesBloc>().loadSoccerEventData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title:
            Text(widget.city == 'Todos' ? 'Inicio' : widget.city ?? 'Inicio'),
      ),
      body: FutureBuilder<List<SoccerEvent>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return StateEventCard(stateEvent: snapshot.data![index]);
              },
            );
          }
        },
      ),
    );
  }
}
