class PushNotifications {
  late final String title;
  late final String body;
  late final DateTime time;
  final String image;
  final String routeName;

  PushNotifications(
      {required this.title,
      required this.body,
      required this.time,
      required this.image,
      required this.routeName});
}
