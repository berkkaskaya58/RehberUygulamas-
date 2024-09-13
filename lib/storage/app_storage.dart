import 'package:hive_flutter/hive_flutter.dart';

class AppStorage {
  static Future  <void> appStorageInitialize ()async{
await Hive.initFlutter();
await Hive.openBox("local_box");
  }
  static final Box localBox=Hive.box("local_box");
}