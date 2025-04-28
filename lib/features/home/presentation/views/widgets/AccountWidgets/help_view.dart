import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/styles.dart';

import '../../../../../../core/utils/navigator_methods.dart';

class HelpView extends StatelessWidget {
  final String title;
  const HelpView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows content to go behind the AppBar
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
            child: Image.asset(
              'assets/images/FQAsBG.webp',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox(
                height: 200, // Placeholder height
                child: Center(
                  child: Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: faqData.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.only(bottom: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ExpansionTile(
                    title: Text(
                      faqData[index]["question"]!,
                      style: Styles.textStyle700.copyWith(color: Theme.of(context).primaryColor,fontSize: 16.sp) ,
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          faqData[index]["answer"]!,
                          style: Styles.textStyle700.copyWith(color: Colors.grey[700],fontSize: 14.sp),
                          maxLines: 3,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, String>> faqData = [
  {
    "question": "هل يمكن الدفع عند الاستلام ؟",
    "answer": "تستطيع الدفع عند الاستلام",
  },
  {
    "question": "سوال 1",
    "answer": "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ...",
  },
  {
    "question": "سوال 2",
    "answer": "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ...",
  },
  {
    "question": "سوال 3",
    "answer": "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ...",
  },
  {
    "question": "سوال 4",
    "answer": "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ...",
  },
  {
    "question": "سوال 5",
    "answer": "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة ما سيلهي القارئ...",
  },
];
