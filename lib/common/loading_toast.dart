import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/navigation_service.dart';

class LoadingToast {
  static OverlayEntry? _overlayEntry;

  static final GlobalKey<NavigatorState> navigatorKey = NavigationService.navigatorKey;

  static void show(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final OverlayState? overlayState = navigatorKey.currentState?.overlay;

      if (overlayState == null) {
        print("[LoadingToast] show: OverlayState is null. Make sure to use MaterialApp with navigatorKey.");
        return;
      }

      if (_overlayEntry != null) {
        print("[LoadingToast] show: Another loading toast is already displayed.");
        return;
      }

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Material(
                color: Colors.black.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

      overlayState.insert(_overlayEntry!);
      print("[LoadingToast] show: Loading toast displayed.");
    });
  }

  static void remove() {
    if (_overlayEntry == null) {
      print("[LoadingToast] remove: No loading toast to remove.");
      return;
    }

    _overlayEntry!.remove();
    _overlayEntry = null;
    print("[LoadingToast] remove: Loading toast removed.");
  }
}