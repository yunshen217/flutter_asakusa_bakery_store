import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/product_ingredient_stock_record_list_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 在庫記録
class InLibraryDetail extends StatefulWidget {
  const InLibraryDetail({super.key});

  @override
  State<InLibraryDetail> createState() => _InLibraryDetailState();
}

class _InLibraryDetailState extends State<InLibraryDetail> {
  /// id
  final arguments = Get.arguments;
  RxString id = "".obs;
  RxList<ProductIngredientStockRecordListModel> inLibraryDetailList = <ProductIngredientStockRecordListModel>[].obs;
  @override
  void initState() {
    super.initState();
    id.value = arguments["id"]??"";
    getProductIngredientStockRecordList();
  }
  getProductIngredientStockRecordList() async{
    await backEndRepository.doGet("${Constant.base_url}merchant/ingredients/${id.value}/stocks/records",successRequest: (result) {
      inLibraryDetailList.clear();
      if(result["data"]!=null){
        for (var data in result["data"]) {
          inLibraryDetailList.add(ProductIngredientStockRecordListModel.fromJson(data));
        }
      }
    },);
  }
  Widget _row(String inboundAndOutboundClassification, String quantity, String unit, String time,
      bool isBg) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 11, 0, 11),
      decoration: BoxDecoration(
        color: isBg ? CustomColor.bg : Colors.transparent,
        border: const Border(bottom: BorderSide(color: CustomColor.bg)),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  child: customWidget.setText(inboundAndOutboundClassification,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      maxLines: 10,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.center,
                  child: customWidget.setText(quantity,
                  maxLines: 10,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 0, right: 0),
                  alignment: Alignment.center,
                  child: customWidget.setText(unit,
                  maxLines: 10,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 10),
                  alignment: Alignment.center,
                  child: customWidget.setText(time,
                  maxLines: 10,
                      color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                      fontSize: 12))),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "在庫記録",
        backgroundColor: CustomColor.white,
        isLeftShow: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: customWidget.setAssetsImg("nav_back@3x.png",
              width: 10, padding: const EdgeInsets.all(15)),
        ),
      ),
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                _row("入出庫区分", "数量", "単位", "時間", false),
                SingleChildScrollView(
                  child: Obx(()=>Column(
                    children: List.generate(inLibraryDetailList.length, (index){
                      final item = inLibraryDetailList[index];
                      return _row(item.ioTypeName!, item.count.toString(), item.unitName!, item.createTime!, false);
                    }),
                  )),
                )
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 30),
                  decoration: const BoxDecoration(
                    color: CustomColor.white,
                  ),
                  child: customWidget.setOutLinedButton("追加",
                  onPressed: ()=>Get.toNamed("InboundAndOutboundStorage",arguments: {"id":id.value})!.then((_){
                    getProductIngredientStockRecordList();
                  }),
                      circular: 5,
                      linewidth: 0.5,
                      minimumSize: Size(Get.width - 15, 34),
                      isHaveLeftIcon: true,
                      imgPath: "组 239@3x.png",
                      lineColor: CustomColor.blackD,
                      fontColor: Colors.black)))
        ],
      ),
    );
  }
}