import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app/core/utils/styles.dart';

import '../../../../../../core/utils/navigator_methods.dart';

// class NotificationView extends StatelessWidget {
//   final String title;
//   const NotificationView({super.key, required this.title});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               title,
//               style: Styles.textStyle700.copyWith(fontSize: 20.sp),
//               overflow: TextOverflow.ellipsis,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 16,),
//           ],
//         ),
//       ),
//     );
//   }
// }


class NotificationView extends StatelessWidget {
    final String title;

  final List<Map<String, String>> notifications = [
    {"title": "New Update", "message": "Version 2.0 is now available!"},
    {"title": "Discount Offer", "message": "Get 50% off on your next purchase."},
    {"title": "Reminder", "message": "Your subscription is about to expire."},
    {"title": "Welcome!", "message": "Thank you for joining us."},
  ];

   NotificationView({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => NavigatorMethods.pop(context: context),
          icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.white),
        ),
        title: Text("Notifications", style: Styles.textStyle900.copyWith(fontSize: 18.sp,color:Colors.white,letterSpacing: 2)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          var notification = notifications[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: EdgeInsets.all(15),
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent.withOpacity(0.2),
                child: Icon(Icons.notifications, color: Colors.blueAccent),
              ),
              title: Text(notification["title"]!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Text(notification["message"]!, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ),
          );
        },
      ),
    );
  }
}
