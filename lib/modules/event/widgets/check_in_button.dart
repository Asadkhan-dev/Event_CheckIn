import 'package:event_manager/core/app_theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../../data/model/event_model.dart';
import '../controllers/event_controller.dart';
import 'package:get/get.dart';
class CheckInButton extends StatelessWidget {
  final EventModel event;

 CheckInButton({required this.event});
EventController controller = Get.find<EventController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){controller.checkInToEvent(event);},
      child: Container(
        height: 30,
        width: 80,
        alignment: Alignment.center,
        decoration:
        BoxDecoration(
            color: AppColors.accentColor,
            borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Text("Check In",style: TextStyle(color: Colors.white),),
      ),
    );

  }
}