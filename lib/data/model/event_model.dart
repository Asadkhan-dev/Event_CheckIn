import 'dart:convert';

class EventModel {
  String id;
  String eventName;
  String eventDate;
  String eventTime;
  String img;
  String timestamp;

  EventModel({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.img,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'event_name': eventName,
      'event_date': eventDate,
      'event_time': eventTime,
      'img': img,
      'timestamp': timestamp,
    };
  }

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'],
      eventName: map['event_name'],
      eventDate: map['event_date'],
      eventTime: map['event_time'],
      img: map['img'],
      timestamp: map['timestamp'],
    );
  }
  factory EventModel.fromJson(String source) => EventModel.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}