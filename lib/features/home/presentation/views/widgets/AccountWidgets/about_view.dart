import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/navigator_methods.dart';

class AboutView extends StatelessWidget {
  final String title;

  const AboutView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => NavigatorMethods.pop(context: context),
          icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 150.h, // Fixed height for background image
            child: Image.asset(
              'assets/images/AboutUs_BG.webp',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 200.h,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.h,right:16.h ,top:16.w ,bottom: 30.w,),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 5,
                shadowColor: Colors.grey.withOpacity(0.3),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Us", // Dynamically set title
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 16.h),
                        Divider(color: Colors.blueAccent),
                        SizedBox(height: 12.h),
                        Text(
                          data["about"]!, // Dynamically set content
                          style: TextStyle(fontSize: 16.sp, color: Colors.black87, height: 1.6),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Data from API:
final Map data = {
  "about": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s...",
  "terms": "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s..."
};

// Usage Example:
