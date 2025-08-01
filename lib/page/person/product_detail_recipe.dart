import 'package:flutter/material.dart';
import 'package:flutter_asakusa_bakery_store/view/BaseScaffold.dart';

class ProductDetailRecipe extends StatefulWidget {
  const ProductDetailRecipe({super.key});

  @override
  State<ProductDetailRecipe> createState() => _ProductDetailRecipeState();
}
/// 商品详情 - 食谱
class _ProductDetailRecipeState extends State<ProductDetailRecipe> {
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Text("食谱"),
    );
  }
}