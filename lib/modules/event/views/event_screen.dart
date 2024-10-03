import 'package:event_manager/modules/event/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/app_theme/app_theme.dart';
import '../controllers/event_controller.dart';

class EventScreen extends StatelessWidget {
  final EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.list, color: Colors.white, size: 30),
      ),
      body: RefreshIndicator(
        onRefresh:() async {
          await eventController.refreshEvents();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Event List',
                style: TextStyle(
                  color: AppColors.accentColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Using Obx to observe eventController state
              Expanded(
                child: Obx(() {
                  if (eventController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if (eventController.Error.isTrue)
                    {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Failed to load events.',
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: eventController.refreshEvents, // Retry fetching events
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                  else if (eventController.eventsLocals.isEmpty) {
                    return  Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No events available.',
                            style: TextStyle(color: Colors.white),
                          ),
                          ElevatedButton(
                            onPressed: eventController.refreshEvents, // Retry fetching events
                            child: const Text('Reload'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: eventController.eventsLocals.length,
                      itemBuilder: (context, index) {
                        return EventCard(event: eventController.eventsLocals[index]);
                      },
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
