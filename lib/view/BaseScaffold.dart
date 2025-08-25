import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

typedef ScaffoldParamVoidCallback = void Function();

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({
    Key? key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.backgroundColor = const Color(0xFFF5F5F5),
    this.resizeToAvoidBottomInset,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.drawerScrimColor,
    this.drawerEdgeDragWidth,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.isTwiceBack = false,
    this.isCanBack = true,
    this.onBack,
  })  : assert(primary != null),
        assert(extendBody != null),
        assert(extendBodyBehindAppBar != null),
        assert(drawerDragStartBehavior != null),
        super(key: key);


  final bool? extendBody;
  final bool? extendBodyBehindAppBar;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<Widget>? persistentFooterButtons;
  final Widget? drawer;
  final Widget? endDrawer;
  final Color? drawerScrimColor;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final bool? resizeToAvoidBottomInset;
  final bool? primary;
  final DragStartBehavior? drawerDragStartBehavior;
  final double? drawerEdgeDragWidth;
  final bool? drawerEnableOpenDragGesture;
  final bool? endDrawerEnableOpenDragGesture;

//   Increased attributes
// Click the back button to indicate whether to exit the page, and quickly click twice to exit the page
  final bool? isTwiceBack;

  ///Whether it can be returned
  final bool? isCanBack;

  ///Listen for return events
  final ScaffoldParamVoidCallback? onBack;

  @override
  _BaseScaffoldState createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  DateTime? _lastPressedAt; //Last clicked time

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: PopScope(
          onPopInvoked: (e) => dealWillPop(),
          child: Scaffold(
            appBar: widget.appBar,
            body: widget.body,
            floatingActionButton: widget.floatingActionButton,
            floatingActionButtonLocation: widget.floatingActionButtonLocation,
            floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
            persistentFooterButtons: widget.persistentFooterButtons,
            drawer: widget.drawer,
            endDrawer: widget.endDrawer,
            bottomNavigationBar: widget.bottomNavigationBar,
            bottomSheet: widget.bottomSheet,
            backgroundColor: widget.backgroundColor,
            resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
            primary: widget.primary!,
            drawerDragStartBehavior: widget.drawerDragStartBehavior!,
            extendBody: widget.extendBody!,
            extendBodyBehindAppBar: widget.extendBodyBehindAppBar!,
            drawerScrimColor: widget.drawerScrimColor,
            drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
            drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture!,
            endDrawerEnableOpenDragGesture:
                widget.endDrawerEnableOpenDragGesture!,
          ),
        ),
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        });
  }

  ///Control back button
  Future<bool> dealWillPop() async {
    if (widget.onBack != null) {
      widget.onBack!();
    }

    //Deal with pop-up issues
    if (SmartDialog.checkExist()) {
      SmartDialog.dismiss();
      return false;
    }

    //If you can't go back, the logic behind it won't go
    if (widget.isCanBack!) {
      return false;
    }

    if (widget.isTwiceBack!) {
      if (_lastPressedAt == null ||
          DateTime.now().difference(_lastPressedAt!) > Duration(seconds: 1)) {
        //If the interval between two clicks is more than 1 second, the time will be recounted
        _lastPressedAt = DateTime.now();

        //Pop-up prompt
        SmartDialog.showToast("もう一度退出をクリックしてください");
        return false;
      }
      return true;
    } else {
      return true;
    }
  }
}
