

import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'home.page.dart';


class NotificationService {
  static final NotificationService instance = NotificationService._internal();
  factory NotificationService() => instance; // ← यही सिंगलटन देगा
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> init() async {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notificationsPlugin.initialize(settings);
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      'delivery_requests_channel',
      'Delivery Requests',
      description: 'New delivery request alerts',
      importance: Importance.max,
      // priority: Priority.high,
      playSound: true,
      enableVibration: true,
      vibrationPattern: Int64List.fromList(const [0, 1000, 500, 1000]),
      // vibrationPattern: [0, 1000, 500, 1000], // Strong vibration
      sound: const RawResourceAndroidNotificationSound('buzzer'), // buzzer.wav
    );

    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  // Future<void> triggerDeliveryAlert(DeliveryRequest request) async {
  //   // 1. Strong vibration
  //   if (await Vibration.hasVibrator() ?? false) {
  //     Vibration.vibrate(
  //       pattern: [0, 800, 400, 800, 400, 800],
  //       intensities: [255, 0, 255, 0, 255, 0],
  //     );
  //   }
  //
  //   // 2. HIGH PRIORITY NOTIFICATION with raw sound
  //   final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  //     'delivery_requests_channel',
  //     'Delivery Requests',
  //     importance: Importance.max,
  //     priority: Priority.max,  // ← जरूरी!
  //     playSound: true,
  //     sound: const RawResourceAndroidNotificationSound('buzzer'),
  //     enableVibration: true,
  //     vibrationPattern: Int64List.fromList([0, 800, 400, 800, 400, 800]),
  //     ongoing: true,
  //     autoCancel: false,
  //     ticker: 'New Delivery Request!',
  //     audioAttributesUsage: AudioAttributesUsage.alarm, // ← Alarm की तरह बजेगा
  //     category: AndroidNotificationCategory.alarm,     // ← Do Not Disturb में भी बजेगा
  //   );
  //
  //   const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //     sound: 'buzzer.wav',
  //   );
  //
  //   final NotificationDetails details = NotificationDetails(
  //     android: androidDetails,
  //     iOS: iosDetails,
  //   );
  //
  //   await _notificationsPlugin.show(
  //     999,
  //     'New Delivery Request!',
  //     'Recipient: ${request.recipient} | ${request.countdown}s left',
  //     details,
  //   );
  // }


  Future<void> triggerDeliveryAlert(DeliveryRequest request) async {
    // Vibration
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(
        pattern: [0, 800, 400, 800, 400, 800],
        intensities: [255, 0, 255, 0, 255, 0],
      );
    }

    // Notification with RAW sound
    final AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'delivery_requests_channel',
      'Delivery Requests',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: const RawResourceAndroidNotificationSound('buzzer'), // .wav मत लिखो
      enableVibration: true,
      vibrationPattern: Int64List.fromList([0, 800, 400, 800]),
      audioAttributesUsage: AudioAttributesUsage.alarm,
      category: AndroidNotificationCategory.alarm,
      ongoing: false,
      autoCancel: true,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      sound: 'buzzer.wav',
    );

    await _notificationsPlugin.show(
      999,
      'New Delivery Request!',
      'Pickup: ${request.pickupName} → Drop: ${request.dropOffLocations}',
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );
  }


  void stopBuzzer() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose(); // ← पूरी तरह बंद कर दो
    await Vibration.cancel();

    // Notification भी हटाओ (अगर चाहो)
    await _notificationsPlugin.cancel(999);

    print("BUZZER + VIBRATION + NOTIFICATION STOPPED!");
  }
}