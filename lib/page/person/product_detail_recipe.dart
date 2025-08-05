import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:get/get.dart';

class ProductDetailRecipe extends StatefulWidget {
  const ProductDetailRecipe({super.key});

  @override
  State<ProductDetailRecipe> createState() => _ProductDetailRecipeState();
}

/// 商品詳細 - レシピ
class _ProductDetailRecipeState extends State<ProductDetailRecipe> {
  /// 材料データを選択する
  List selectTheMaterial = ["白生地", "黑生地"];

  /// 現在選択された材料
  RxList currentlyselectTheMaterial = [].obs;

  /// 入力ボックスコントローラー一覧
  RxList<TextEditingController> controllerList = <TextEditingController>[].obs;
  RxList<FocusNode> focusNodeList = <FocusNode>[].obs;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            for (var data in focusNodeList) {
              data.unfocus();
            }
          },
          child: Column(
            children: [
              Obx(() => Column(
                    children: List.generate(controllerList.length, (index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              infoWidget.titleWidget(
                                  currentlyselectTheMaterial[index], false),
                              GestureDetector(
                                onTap: () {
                                  currentlyselectTheMaterial.removeAt(index);
                                  controllerList.removeAt(index);
                                  focusNodeList.removeAt(index);
                                },
                                child: customWidget.setAssetsImg("icon_clear.png",
                                    width: 16,
                                    height: 16,
                                    margin: EdgeInsets.only(right: 15)),
                              )
                            ],
                          ),
                          customWidget.setTextField(
                            controllerList[index],
                            focusNodeList[index],
                            borderSide: const BorderSide(
                              color: CustomColor.blackD,
                              width: 0.5,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter
                                  .digitsOnly, 
                            ],
                            isShow: true,
                            suffixIcon: Container(
                              margin: EdgeInsets.fromLTRB(15, 15, 0, 15),
                              child: customWidget.setText("g",
                                  color: CustomColor.black_3,
                                  fontSize: 12,
                                  textAlign: TextAlign.center),
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 15),
                          )
                        ],
                      );
                    }),
                  )),
          
              /// 按钮
              customWidget.setOutLinedButton("材料の追加",
                  margin: const EdgeInsets.fromLTRB(15, 0, 15, 70),
                  onPressed: () => customWidget.showCustomizationPicker(context,
                          columnsData: [
                            selectTheMaterial.map((e) => e.toString()).toList()
                          ],
                          initialIndex: [0],
                          title: '材料を選択してください', confirm: (list) {
                        currentlyselectTheMaterial.add(list[0]);
                        controllerList.add(TextEditingController());
                        focusNodeList.add(FocusNode());
                      }),
                  circular: 5,
                  linewidth: 0.5,
                  minimumSize: Size(Get.width - 15, 34),
                  isHaveLeftIcon: true,
                  imgPath: "组 239@3x.png",
                  lineColor: CustomColor.blackD,
                  fontColor: Colors.black)
            ],
          ),
        ),
      ),
    );
  }
}
