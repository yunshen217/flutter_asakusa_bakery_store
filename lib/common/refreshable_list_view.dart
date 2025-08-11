import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshableListView<T> extends StatelessWidget {
  final RefreshController refreshController;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoading;
  final Widget Function(BuildContext context) itemWidget;

  RefreshableListView({
    Key? key,
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.itemWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: onRefresh,
      onLoading: onLoading,
      header: CustomHeader(
        builder: (context, mode) {
          if (mode != RefreshStatus.refreshing) {
            return const SizedBox.shrink();
          }
          return Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(value),
                    child: child,
                  ),
                );
              },
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CustomColor.redE8, // 统一主题色
                ),
              ),
            ),
          );
        },
      ),
      footer: CustomFooter(
        builder: (context, mode) {
          if (mode != LoadStatus.loading) {
            return const SizedBox.shrink();
          }
          return Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: FadeTransition(
                    opacity: AlwaysStoppedAnimation(value),
                    child: child,
                  ),
                );
              },
              child: const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: CustomColor.redE8,
                ),
              ),
            ),
          );
        },
      ),
      child: itemWidget(context),
    );
  }
}
