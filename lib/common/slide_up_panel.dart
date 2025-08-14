
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlideUpPanel extends StatefulWidget {
  final Widget child; // ドロップダウン表示の内容
  bool showPanel; // ドロップダウンパネルの表示を制御する
  final Duration animationDuration; // アニメの長さ

  SlideUpPanel({
    required this.child,
    this.showPanel = false,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  _SlideUpPanelState createState() => _SlideUpPanelState();
}

class _SlideUpPanelState extends State<SlideUpPanel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // マスク層は、パネルが表示されているときだけ表示されます。
        if (widget.showPanel)
          GestureDetector(
            onTap: _togglePanel,
            child: AnimatedOpacity(
              opacity: 0.5,
              duration: widget.animationDuration,
              child: Container(
                color: Colors.black.withOpacity(0.5), // マスキング効果
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

        // 表示されたドロップダウンパネル
        AnimatedPositioned(
          duration: widget.animationDuration,
          top: widget.showPanel ? 0 : -1000, // 展開/折りたたみアニメーション
          left: 0,
          right: 0,
          child: Container(
            color: Colors.white,
            child: widget.child,
          ),
        ),


        Positioned(
          left: 0, 
          top: 0, 
          child: Container(), 
        ),
      ],
    );
  }

  void _togglePanel() {
    setState(() {
      widget.showPanel = !widget.showPanel;
    });
  }
}
