import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/ingredients_stocks_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

/// 在庫管理
class InLibraryManagement extends StatefulWidget {
  const InLibraryManagement({super.key});

  @override
  State<InLibraryManagement> createState() => _InLibraryManagementState();
}

class _InLibraryManagementState extends State<InLibraryManagement> {

  RxList<IngredientsStocksModel> ingredientsStocks =
      <IngredientsStocksModel>[].obs;

  @override
  void initState() {
    super.initState();
    getIngredientsStocks();
  }

  getIngredientsStocks() async {
    await backEndRepository.doGet(
      Constant.ingredientsStocks,
      successRequest: (result) {
        ingredientsStocks.clear();
        if (result["data"] != null) {
          ingredientsStocks.addAll(
            (result['data'] as List? ?? [])
                .map((e) => IngredientsStocksModel.fromJson(e ?? {})),
          );
        }
      },
    );
  }

  Widget _row(String name, String num, String stockArrivalAlert, Function rightOnTap,Function onTap,
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
              child: GestureDetector(
                onTap: () => rightOnTap(),
                child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    alignment: Alignment.center,
                    child: customWidget.setText(name,
                        color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                        maxLines: 10,
                        fontSize: 12)),
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => rightOnTap(),
                child: Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    alignment: Alignment.center,
                    child: customWidget.setText(num,
                        maxLines: 10,
                        color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                        fontSize: 12)),
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => rightOnTap(),
                child: Container(
                    margin: const EdgeInsets.only(left: 0, right: 0),
                    alignment: Alignment.center,
                    child: customWidget.setText(stockArrivalAlert,
                        maxLines: 10,
                        color: isBg ? CustomColor.gray_6 : CustomColor.black_3,
                        fontSize: 12)),
              )),
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () => onTap(),
                child: Container(
                    margin: const EdgeInsets.only(left: 15, right: 10),
                    alignment: Alignment.center,
                    child: customWidget.setText("詳細",
                        maxLines: 10,
                        color: isBg ? CustomColor.gray_6 : CustomColor.redE8,
                        fontSize: 12)),
              )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "在庫管理",
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
                _row("材料名", "在庫数", "入荷アラ一ト", (){},() {}, true),
                SingleChildScrollView(
                  child: Obx(()=>Column(
                    children:
                        List.generate(ingredientsStocks.length, (index) {
                      final item = ingredientsStocks[index];
                      return _row(
                          item.ingredientName!,
                          item.countUnitName!,
                          item.recordCountUnitName!,
                          () {
                            Get.toNamed("MaterialAddition",arguments: {"isHaveDeletedBtn":true,"id":item.minUnitId.toString(),"IngredientsStocksModel":item})!.then((_){
                              getIngredientsStocks();
                            });
                          },
                          () => Get.toNamed("/InLibraryDetail",arguments: {"id":item.id.toString()})!.then((_){
                            getIngredientsStocks();
                          }),
                          false);
                    }),
                  ),)
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
                  child: customWidget.setOutLinedButton("材料追加",
                      onPressed: () => Get.toNamed("MaterialAddition",arguments: {"isHaveDeletedBtn":false,"id":"","IngredientsStocksModel":null})!.then((_){
                        getIngredientsStocks();
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
