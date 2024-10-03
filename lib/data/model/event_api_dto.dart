class EventListDTO {
  Embedded? eEmbedded;

  EventListDTO({this.eEmbedded});

  EventListDTO.fromJson(Map<String, dynamic> json) {
    eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eEmbedded != null) {
      data['_embedded'] = this.eEmbedded!.toJson();
    }
    return data;
  }
}

class Embedded {
  List<Events>? events;

  Embedded({this.events});

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? name;
  String? type;
  String? id;
  bool? test;
  String? url;
  String? locale;
  List<Images>? images;
  Dates? dates;

  Events(
      {this.name,
        this.type,
        this.id,
        this.test,
        this.url,
        this.locale,
        this.images,
        this.dates});

  Events.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    id = json['id'];
    test = json['test'];
    url = json['url'];
    locale = json['locale'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    dates = json['dates'] != null ? new Dates.fromJson(json['dates']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['id'] = this.id;
    data['test'] = this.test;
    data['url'] = this.url;
    data['locale'] = this.locale;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.dates != null) {
      data['dates'] = this.dates!.toJson();
    }
    return data;
  }
}

class Images {
  String? ratio;
  String? url;
  int? width;
  int? height;
  bool? fallback;

  Images({this.ratio, this.url, this.width, this.height, this.fallback});

  Images.fromJson(Map<String, dynamic> json) {
    ratio = json['ratio'];
    url = json['url'];
    width = json['width'];
    height = json['height'];
    fallback = json['fallback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ratio'] = this.ratio;
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['fallback'] = this.fallback;
    return data;
  }
}

class Dates {
  Start? start;
  String? timezone;

  Dates({this.start, this.timezone});

  Dates.fromJson(Map<String, dynamic> json) {
    start = json['start'] != null ? new Start.fromJson(json['start']) : null;
    timezone = json['timezone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.start != null) {
      data['start'] = this.start!.toJson();
    }
    data['timezone'] = this.timezone;
    return data;
  }
}

class Start {
  String? localDate;
  String? localTime;
  String? dateTime;

  Start({this.localDate, this.localTime, this.dateTime});

  Start.fromJson(Map<String, dynamic> json) {
    localDate = json['localDate'];
    localTime = json['localTime'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localDate'] = this.localDate;
    data['localTime'] = this.localTime;
    data['dateTime'] = this.dateTime;
    return data;
  }
}
