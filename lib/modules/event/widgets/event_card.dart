import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../core/app_theme/app_theme.dart';
import '../../../data/model/event_model.dart';
import 'check_in_button.dart';

class EventCard extends StatelessWidget {
  final EventModel? event ;//EventModel(eventName: "political show", eventDate: "22-2-25", timestamp: "23:11:00:00");

 EventCard({this.event});

  @override
  Widget build(BuildContext context) {
    print(event!.id);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Event Image Background
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
            ),
            child: CachedNetworkImage(
              imageUrl: event!.img,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Image(image: AssetImage("assts/event_img/event.jpg")),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  event!.eventName,
                  style: TextStyle(
                    color: AppColors.primaryTextColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(

                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          event!.eventDate.substring(5),
                          style: TextStyle(
                            color: AppColors.accentColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          event!.eventTime,
                          style: TextStyle(
                            color: AppColors.secondaryTextColor,
                            fontSize: 12,
                          ),
                        ),

                      ],
                    ),
                    CheckInButton(event: event!,),
                  ],
                ),

              ],
            ),
          ),


          // Event Details Overlay

        ],
      ),
    );
  }
}