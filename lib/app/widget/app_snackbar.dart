import 'package:flutter/material.dart';

/// Snackbar helper that uses Flutter's native [ScaffoldMessenger].
///
/// The app previously used `Get.snackbar`, which resolves an [Overlay] via
/// GetX's internal queue. In this app that lookup fails at runtime with
/// "Unhandled Exception: No Overlay widget found." (thrown from
/// `SnackbarController._configureOverlay`), so no snackbar was ever rendered.
///
/// [ScaffoldMessenger] shows the snackbar on the nearest [Scaffold], which
/// always exists in this app's pages, so messages render reliably.
class AppSnackbar {
  const AppSnackbar._();

  static void show(
    BuildContext context, {
    required String title,
    required String message,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    showOn(
      ScaffoldMessenger.maybeOf(context),
      title: title,
      message: message,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      duration: duration,
    );
  }

  /// Shows a snackbar using an already-resolved [ScaffoldMessengerState].
  ///
  /// Use this when the originating [BuildContext] is about to be (or has just
  /// been) disposed, e.g. a modal bottom sheet that calls `Get.back()` before
  /// reporting the result.
  static void showOn(
    ScaffoldMessengerState? messenger, {
    required String title,
    required String message,
    Color backgroundColor = Colors.blue,
    Color textColor = Colors.white,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (messenger == null) return;

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: duration,
          behavior: SnackBarBehavior.floating,
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, color: textColor, size: 20),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      message,
                      style: TextStyle(color: textColor, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
