import 'package:flutter/material.dart';
import 'widgets/gradient_back.dart';
import 'Place/ui/widgets/card_image_list.dart';

class HeaderAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBack(height: 300.0, title: "Popular"),
        CardImageList()
      ],
    );
  }

}