import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/banner_model.dart';
import 'home_view_body_carousel_slider_item.dart';

class HomeViewBodyCarouselSlider extends StatelessWidget {
  final List<BannerModel> banners;
  const HomeViewBodyCarouselSlider({
    super.key, required this.banners,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: banners
          .map(
            (e) => HomeViewBodyCarouselSliderItem(
            image:e.image
        ),
      )
          .toList(),
      options: CarouselOptions(
        height: 150.h,
        autoPlay: true,
        initialPage: 0,
        reverse: false,
        viewportFraction: 0.98,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

