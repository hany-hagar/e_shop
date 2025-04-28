import 'package:flutter/material.dart';

import '../../data/models/product_model.dart';
import 'widgets/product_view_body.dart';

class ProductView extends StatelessWidget {
  final ProductModel product;

  const ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return ProductViewBody(product: product);
  }
}
