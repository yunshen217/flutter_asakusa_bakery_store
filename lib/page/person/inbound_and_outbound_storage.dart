
import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/common/constant.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_color.dart';
import 'package:flutter_asakusa_bakery_store/common/custom_widget.dart';
import 'package:flutter_asakusa_bakery_store/common/global.dart';
import 'package:flutter_asakusa_bakery_store/common/info_widget.dart';
import 'package:flutter_asakusa_bakery_store/model/get_io_types_model.dart';
import 'package:flutter_asakusa_bakery_store/model/units_min_model.dart';
import 'package:flutter_asakusa_bakery_store/repository/repository.dart';
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
  /// id
  final arguments = Get.arguments;
  TextEditingController numController = TextEditingController();

  RxList inboundAndOutboundClassification = [].obs;
  RxString inboundAndOutboundClassificationSelected = "入出庫区分".obs;
  RxList<GetIoTypesModel> getIoTypesModel = <GetIoTypesModel>[].obs;

  RxList<UnitsMinModel> unitsMin = <UnitsMinModel>[].obs;
  RxList unit = [].obs;
  RxString unitSelected = "単位".obs; 
  RxString id = "".obs;
  @override
  void initState() {
    super.initState();
    id.value = arguments["id"]??"";
    getIOTypes();
    getUnitsDisplayRecord();
  }
  getIOTypes() async{
    await backEndRepository.doGet("${Constant.base_url}merchant/getIOTypes",successRequest: (result) {
      if(result["data"] != null){
        for (var element in result["data"]) {
          getIoTypesModel.add(GetIoTypesModel.fromJson(element));
          inboundAndOutboundClassification.add(element["value"]??"");
        }
      }
    },);
  }

  addProductIngredientStockRecord() async{
    String ioTypeCd = "";
    if(inboundAndOutboundClassificationSelected.value == "仕入"){
      ioTypeCd = "1";
    }else if(inboundAndOutboundClassificationSelected.value == "製造"){
      ioTypeCd = "2";
    }else if(inboundAndOutboundClassificationSelected.value == "出庫"){
      ioTypeCd = "3";
    }else if(inboundAndOutboundClassificationSelected.value == "ロース"){
      ioTypeCd = "4";
    }
    String unit = "";
    for (var data in unitsMin) {
      if(unitSelected.value == data.unit){
        unit = data.id!;
      }
    }
    Map<String, dynamic> params = {
      "ingredientId": id.value,
      "ioTypeCd": ioTypeCd,
      "count": numController.text,
      "unit": unit,
      "merchantId":Global.merchantId
    };
    await backEndRepository.doPost("${Constant.base_url}merchant/ingredients/stocks/records",params: params, successRequest: (result) {
      Get.back();
    },);
  }

  getUnitsDisplayRecord() async{
    await backEndRepository.doGet("${Constant.base_url}merchant/units/display/record/${id.value}",successRequest: (result) {
      if(result["data"]!=null){
        for (var data in result["data"]) {
          unitsMin.add(UnitsMinModel.fromJson(data));
          unit.add(data["unit"]??"");
        }
        
      }
    },);
  }
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
            hintText: '数値を入力してください',
            readOnly: false,
            isNum: true,),
            infoWidget.titleWidget("入出庫区分", false),
            Obx(()=>infoWidget.pickerSelected(inboundAndOutboundClassificationSelected.value,inboundAndOutboundClassificationSelected.value == "入出庫区分" ,() {
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
                        width: (Get.width - 30) / 3,
                        height: 30,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        circular: 5,
                        textColor: CustomColor.black_3,
                        color: CustomColor.redE8,
                        margin: const EdgeInsets.only(top: 10,right: 15),
                        onPressed: ()=>addProductIngredientStockRecord()),
            )
          ],
        ),
      ),
    );
  }
}