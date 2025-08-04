import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';
import 'package:flutter_asakusa_bakery_store/view/persion/clear_able_text_field.dart';
import 'package:get/get.dart';

/// 入出庫
class InboundAndOutboundStorage extends StatefulWidget {
  const InboundAndOutboundStorage({super.key});

  @override
  State<InboundAndOutboundStorage> createState() => _InboundAndOutboundStorageState();
}

class _InboundAndOutboundStorageState extends State<InboundAndOutboundStorage> {
  TextEditingController numController = TextEditingController();

  RxList inboundAndOutboundClassification = ["仕入"].obs;
  RxString inboundAndOutboundClassificationSelected = "仕入".obs;

  RxList unit = ["1","2"].obs;
  RxString unitSelected = "単位".obs; 
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: CustomColor.white,
      appBar: customWidget.setAppBar(
        title: "入出庫",
        backgroundColor: CustomColor.white,
        isLeftShow: false,
        leading: InkWell(
          onTap: () => Get.back(),
          child: customWidget.setAssetsImg("nav_back@3x.png",
              width: 10, padding: const EdgeInsets.all(15)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            infoWidget.titleWidget("数量", false),
            ClearableTextField(
            controller: numController,
            hintText: '数值を入カしてください',
            readOnly: false,
            isNum: true,),
            infoWidget.titleWidget("入出庫区分", false),
            Obx(()=>infoWidget.pickerSelected(inboundAndOutboundClassificationSelected.value,inboundAndOutboundClassificationSelected.value == "" ,() {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [inboundAndOutboundClassification.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '入出庫区分',
              confirm: (list) => inboundAndOutboundClassificationSelected.value = list[0],
            );
          })),
          infoWidget.titleWidget("単位", false),
            Obx(()=>infoWidget.pickerSelected(unitSelected.value,unitSelected.value == "単位" ,() {
            customWidget.showCustomizationPicker(
              context,
              columnsData: [unit.map((e) => e.toString()).toList()],
              initialIndex: [0],
              title: '単位',
              confirm: (list) => unitSelected.value = list[0],
            );
          })),
          Align(
              alignment: Alignment.centerRight,
              child: customWidget.setCupertinoButton("保存",
                        minimumSize: (Get.width - 30) / 3,
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.redE8,
                        margin: EdgeInsets.only(top: 10,right: 15),
                        onPressed: (){}),
            )
          ],
        ),
      ),
    );
  }
}