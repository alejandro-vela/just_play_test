class SoccerEvent {
  final String stateName;
  final String img;
  final List<EventDetail> events;

  SoccerEvent(
      {required this.stateName, required this.events, required this.img});

  factory SoccerEvent.fromJson(Map<String, dynamic> json) {
    var list = json['events'] as List;

    List<EventDetail> eventsList =
        list.map((i) => EventDetail.fromJson(i)).toList();

    return SoccerEvent(
      stateName: json['state_name'],
      events: eventsList,
      img: json['img'],
    );
  }
}

class EventDetail {
  final int numberOfPlayers;
  final String location;
  final String fieldName;
  final String time;
  final String date;

  EventDetail(
      {required this.numberOfPlayers,
      required this.location,
      required this.fieldName,
      required this.time,
      required this.date});

  factory EventDetail.fromJson(Map<String, dynamic> json) {
    return EventDetail(
      numberOfPlayers: json['number_of_players'],
      location: json['location'],
      fieldName: json['field_name'],
      time: json['time'],
      date: json['date'],
    );
  }
}
