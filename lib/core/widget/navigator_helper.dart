import 'package:flutter/material.dart';

class NavigatorHelper {
  NavigatorHelper._();

  /// Push to a new page
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    bool useRootNavigator = false,
  }) {
    return Navigator.of(context, rootNavigator: useRootNavigator).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push and remove current page
  static Future<T?> pushReplacement<T, TO>(
    BuildContext context,
    Widget page, {
    bool useRootNavigator = false,
  }) {
    return Navigator.of(context, rootNavigator: useRootNavigator)
        .pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  /// Push and clear entire stack
  static Future<T?> pushAndRemoveUntil<T>(
    BuildContext context,
    Widget page, {
    bool useRootNavigator = false,
  }) {
    return Navigator.of(context, rootNavigator: useRootNavigator).pushAndRemoveUntil<T>(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  /// Pop current page
  static void pop<T>(BuildContext context, [T? result]) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop<T>(result);
    }
  }

  /// Pop to first route
  static void popToRoot(BuildContext context, {bool useRootNavigator = false}) {
    Navigator.of(context, rootNavigator: useRootNavigator)
        .popUntil((route) => route.isFirst);
  }

  /// Show snackbar
  static void showSnackBar(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), duration: duration),
      );
  }

  /// Show a simple loader dialog (call `hideLoader` to close)
  static void showLoader(
    BuildContext context, {
    String? message,
    bool barrierDismissible = false,
    bool useRootNavigator = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      useRootNavigator: useRootNavigator,
      builder: (_) => WillPopScope(
        onWillPop: () async => barrierDismissible,
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
                if (message != null) ...[
                  const SizedBox(width: 14),
                  Flexible(
                    child: Text(
                      message,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void hideLoader(BuildContext context, {bool useRootNavigator = true}) {
    final nav = Navigator.of(context, rootNavigator: useRootNavigator);
    if (nav.canPop()) nav.pop();
  }

  /// Unfocus keyboard
  static void unfocus(BuildContext context) {
    FocusScope.of(context).unfocus();
  }
}
