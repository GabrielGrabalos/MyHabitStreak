class HabitCompletion {
  static const int currentVersion = 1;

  int version;
  String text; // A brief description of that habit completion
  // e.g., "ran 5 miles", "ate rice and beans", etc.
  DateTime date; // The date and time when the habit was completed

  HabitCompletion({
    this.version = currentVersion,
    required this.text,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'version': currentVersion,
      'text': text,
      'date': date.toIso8601String(),
    };
  }

  factory HabitCompletion.fromJson(Map<String, dynamic> json) {
    return HabitCompletion(
      version: json['version'] as int? ?? 1,
      text: json['text'] as String? ?? '',
      date: DateTime.parse(
          json['date'] as String? ?? DateTime.now().toIso8601String()),
    );
  }
}
