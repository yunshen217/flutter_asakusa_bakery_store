import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/page/person/product_detail_info.dart';
import 'package:flutter_asakusa_bakery_store/page/person/product_detail_recipe.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 商品詳細
class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // isHavePurge : クリアボタンが含まれていますか？
  final arguments = Get.arguments;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        backgroundColor: CustomColor.white,
        appBar: customWidget.setAppBar(
          title: "商品詳細",
          backgroundColor: CustomColor.white,
          isLeftShow: false,
          leading: InkWell(
            onTap: () => Get.back(),
            child: customWidget.setAssetsImg("nav_back@3x.png",
                width: 10, padding: const EdgeInsets.all(15)),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Column(
              children: [
                const Divider(height: 1, color: CustomColor.bg),
                TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: '商品情報'),
                    Tab(text: 'レシビ'),
                  ],
                  dividerHeight: 1,
                  dividerColor: CustomColor.bg,
                  splashFactory: NoSplash.splashFactory,
                  indicatorColor: Colors.transparent, 
                  indicator: UnderlineTabIndicator(
                    borderSide: const BorderSide(
                        color: CustomColor.redE8, width: 2), 
                    insets: EdgeInsets.symmetric(
                      horizontal: (Get.width - (Get.width - 30) / 2) / 2,
                    ),
                  ),
                  labelColor: CustomColor.black_3,
                  unselectedLabelColor: CustomColor.black_9,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  // 詳細
                  ProductDetailInfo(),
                  // レシピ
                  ProductDetailRecipe(),
                ],
              ),
            ),
            infoWidget.bottomBtn("削除", "保存",arguments["isHavePurge"], () {}, () {})
          ],
        ));
  }
}
