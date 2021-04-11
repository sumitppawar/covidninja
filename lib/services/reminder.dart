

import 'dart:async';

import 'package:vibration/vibration.dart';

import 'keystore.dart';

class ReminderService {
    Timer t;

    Future<void> update( String lat, String long, int reminderInterval,bool isReminderOn) async {
    KeyValueStore keyVal = KeyValueStore();
    await keyVal.write("lat", lat);
    await keyVal.write("long", long);
    await keyVal.write("reminderInterval", reminderInterval.toString());
    await keyVal.write("isReminderOn", isReminderOn.toString());
    updateReminder(lat, long, (reminderInterval*60), isReminderOn);
  }

  void updateReminder(String lat, String long, int reminderInterval,bool isReminderOn) {
    if(isReminderOn) {
      t.cancel();
    } else {
      Duration duration = Duration(seconds: reminderInterval);
      t = new Timer.periodic(duration, onTimerInvoke);
    }
  }

  void onTimerInvoke(Timer t) {
    // Set local notification
    // Set notification sound
    //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    //audioPlayer.play("https://github.com/sumitppawar/covidninja/notifcation.mp3");
    Vibration.vibrate(duration: 1000);
  }

  bool isOutSideOfHouse() {
    KeyValueStore keyVal = KeyValueStore();
    // Here calculate based Home address
    return true;
  }


}