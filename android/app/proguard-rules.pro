# ==========================================
# ProGuard Rules for InstantDriver Rider App
# ==========================================

# 1. Keep your app's all classes (Flutter + Dart generated)
-keep class com.instantDriver.** { *; }

# 2. Keep Socket.IO event handlers (MOST CRITICAL)
-keepclassmembers class * {
    void _handleNewRequest(**);
    void _acceptRequest(**);
    void _handleAssigned(**);
    void _deliveryAcceptDelivery(**);
    void _acceptDelivery(**);
    void _skipDelivery(**);
    void _showRequestPopup(**);
}

# 3. Keep all socket event listeners (on*, emit*, etc.)
-keepclassmembers class * {
    void on*(***);
    void *(***);
}

# 4. Keep socket_io_client library (full)
-keep class io.socket.** { *; }
-keep class io.socket.client.** { *; }
-keep class io.socket.emitter.** { *; }
-keep class io.socket.engine.** { *; }
-keep class io.socket.parser.** { *; }

# 5. Keep Flutter engine & plugins
#-keep class io.flutter.** { *; }
#-keep class * extends GeneratedPluginRegistrant { *; }

# 6. Keep your models (DeliveryRequest, etc.)
-keep class com.instantDriver.delivery_rider_app.data.model.** { *; }

# 7. Keep NotificationService (sound, vibration, notification)
-keep class com.instantDriver.delivery_rider_app.notificationService.** { *; }

# 8. Keep print/log for debugging (optional)
-keepclassmembers class * {
    void print*(***);
    void log*(***);
}

# 9. Optional: Allow obfuscation but keep names readable in crash reports
-dontobfuscate