import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeViewBodyCarouselSliderItem extends StatelessWidget {
  final String image;
  const HomeViewBodyCarouselSliderItem({
    super.key, required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
        width: MediaQuery.sizeOf(context).width*0.95,
        margin: EdgeInsetsDirectional.only(top: 8),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24)),

        child:CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.fill,
      placeholder: (context, url) => Container(color: Colors.grey[400],),
      errorWidget: (context, url, error) => Icon(Icons.error),
    ),
    );
  }
}
