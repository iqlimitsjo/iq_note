import 'package:flutter/material.dart';

import '../../widget/shared/app_bar.dart';

class SendNotifications extends StatelessWidget {
  const SendNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "إرسال إشعار", isHome: false),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
      ),
    );
  }
}
