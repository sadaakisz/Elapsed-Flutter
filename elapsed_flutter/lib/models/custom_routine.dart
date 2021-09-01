import 'package:hive/hive.dart';

part 'custom_routine.g.dart';

@HiveType(typeId: 0)
class CustomRoutine {
  @HiveField(0)
  String name;
  @HiveField(1)
  int timerTime;
  @HiveField(2)
  int breakTime;
  @HiveField(3)
  String labelColor;
  @HiveField(4)
  String background;
  //TODO: Add notification sound variable
  @HiveField(5)
  int notificationVolume;
  @HiveField(6)
  bool vibrate;
  @HiveField(7)
  bool autoStart;
  //Do not change the number of the HiveField, if you want to add a field, do it in autoincrements.
  CustomRoutine(
      {required this.name,
      required this.timerTime,
      required this.breakTime,
      required this.labelColor,
      required this.background,
      required this.notificationVolume,
      required this.vibrate,
      required this.autoStart});
}
