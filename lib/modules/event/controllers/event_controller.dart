import 'package:event_manager/core/networkcheck/networkcheck.dart';
import '../../../core/flutter_notification/notification.dart';
import '../../../data/Network/http_manager.dart';
import '../../../data/firebase/firebase.dart';
import '../../../data/local/database_helper_checkin.dart';
import '../../../data/local/database_helper_events.dart';
import '../../../data/model/event_api_dto.dart';
import '../../../data/model/event_model.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  var events = <Events>[].obs; // Observable list of events
  var eventsLocals = <EventModel>[].obs; // Observable list of events
  var isLoading = false.obs;
  var Error = false.obs;
  DatabaseHelper _db_evenet = DatabaseHelper();// Observable loading state
  CheckInDatabaseHelper _db_check_in = CheckInDatabaseHelper();// Observable loading state
  final FirebaseHelper _firebaseHelper = FirebaseHelper();
  final NetworkService _networkService = Get.put(NetworkService());

  @override
  Future<void> onInit() async {
    super.onInit();
    Error.value = false;
    print(await _networkService.hasInternetConnection());
    // This will run when the controller is initialized
   if(await _networkService.hasInternetConnection() == true) {
      fetchEvents();
      getLocalDB();
      syncCheckIns();
    }
   else{

     getLocalDB();
   }

   // Initial fetch
  }

  // Method to fetch events (to be implemented)
  void fetchEvents() async {
    {
      isLoading.value = true;
      HTTPManager()
          .getEvents()
          .then((value) => {
            events.value = value.eEmbedded!.events!,
        _db_evenet.deleteAllEvents(),
        events.forEach((element) async {
         await _db_evenet.insertEvent(EventModel(eventName: element.name!, eventDate:element.dates!.start!.localDate.toString(), timestamp: "", img: element.images![0].url.toString(), eventTime:element.dates!.start!.localTime!,id: element.id.toString()));
          eventsLocals.add(EventModel(eventName: element.name!, eventDate:element.dates!.start!.localDate.toString(), timestamp: "", img: element.images![0].url.toString(), eventTime:element.dates!.start!.localTime!,id: element.id.toString()));
        }),
        isLoading.value = false,
      })
          .catchError((e) => {
        isLoading.value = false,
        Error.value = true,

        print(e),});
    }
  }

  void checkInToEvent(EventModel event) async {
print(await _networkService.hasInternetConnection() == true);
    event.timestamp = DateTime.now().toString();
    if (await _networkService.hasInternetConnection() != true) {
      try{
        _db_check_in.insertCheckIn(event);
        await LocalNotificationHelper.showNotification(
          id: 01, // Unique ID for the notification
          title: 'Check-in Successful Locally ',
          body: ' event: ${event.eventName}',
        );
         }
      catch (e)
    {
      await LocalNotificationHelper.showNotification(
        id: 0, // Unique ID for the notification
        title: 'Check-in Unsuccessful Locally ',
        body: ' Error:Somethings unusual happened ',
      );
    }

    }
    else {
      bool? result = await _firebaseHelper.createDocument('Checkin', event.id.toString(), event);
      if (result == true) {
        // ture mean data Exist
        await LocalNotificationHelper.showNotification(
          id: 1, // Unique ID for the notification
          title: 'Check-in Already Exist ',
          body: ' event: ${event.eventName}',
        );}
       else {
         // data dont exist in firebase
        await LocalNotificationHelper.showNotification(
          id: 2, // Unique ID for the notification
          title: 'Check-in Successful To Firebase ',
          body: ' event: ${event.eventName}',
        );
      }
    }
  }

  void getLocalDB() async {
      eventsLocals.value = await _db_evenet.getAllEvents();
  }

    void syncCheckIns() async {
    List<EventModel> unSendEvents = await _db_check_in.getAllCheckIns();
   unSendEvents.forEach((event) async {
     bool? result = await _firebaseHelper.createDocument('Checkin', event.id.toString(), event);
     if (result == true) {
       // ture mean data Exist
       await LocalNotificationHelper.showNotification(
         id: 1, // Unique ID for the notification
         title: 'Check-in Already Exist on Firebase ',
         body: ' event: ${event.eventName}',
       );}
     else {
       // data dont exist in firebase
       await LocalNotificationHelper.showNotification(
         id: 2, // Unique ID for the notification
         title: 'Check-in Sync  Successful To Firebase ',
         body: ' event: ${event.eventName}',
       );
       await _db_check_in.deleteCheckIn(event.id.toString());
     }
   });

  }

  refreshEvents() {
    onInit();
  }
}

