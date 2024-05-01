class Entry {
  final String title;
  final List<int> days;
  final bool enabled;
  final int hour;
  final int minute;
  final List<int> ids;

  Entry(this.title, this.days, this.enabled, this.hour, this.minute, this.ids);

  Entry.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        enabled = json['enabled'] as bool,
        days = (json['days'] as List<int>),
        hour = (json['hour'] as int),
        minute = (json['minute'] as int),
        ids = (json['ids'] as List<int>);

  Map<String, dynamic> toJson() => {
        'title': title,
        'enabled': enabled,
        'days': days,
        'hour': hour,
        'minute': minute,
        'ids' : ids
      };
}

enum Day {
  monday("Mon", 1),
  tuesday("Tue", 2),
  wednesday("Wed",3),
  thursday("Thu", 4),
  friday("Fri",5),
  saturday("Sat",6),
  sunday("Sun", 7);

  const Day(this.short, this.id);

  final String short;
  final int id;
}
