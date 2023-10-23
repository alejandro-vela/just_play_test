import 'package:flutter/material.dart';
import 'package:just_play_test/src/theme/colors.dart';
import 'package:just_play_test/src/widgets/images/custom_image.dart';

import '../../repository/model/event.dart';

class StateEventCard extends StatelessWidget {
  final SoccerEvent stateEvent;

  const StateEventCard({super.key, required this.stateEvent});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(stateEvent.stateName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            CustomImage(
              image: stateEvent.img,
              height: 200,
              borderRadius: 20,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 12),
            ...stateEvent.events
                .map((event) => EventDetailWidget(event: event))
                .toList(),
          ],
        ),
      ),
    );
  }
}

class EventDetailWidget extends StatelessWidget {
  final EventDetail event;

  const EventDetailWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.secondaryColor.withOpacity(.07),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Number of Players:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(width: 8),
                Expanded(child: Text('${event.numberOfPlayers}')),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Location:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(event.location)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Field Name:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(event.fieldName)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Time:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(event.time)),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Date:',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                SizedBox(width: 8),
                Expanded(child: Text(event.date)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
