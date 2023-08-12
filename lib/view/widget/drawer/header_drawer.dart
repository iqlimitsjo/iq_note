import 'package:cached_network_image/cached_network_image.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../shared/app_bar.dart';

class AppDrawerHeader extends StatelessWidget {
  final String imageURL;
  final String userName;

  const AppDrawerHeader({
    super.key,
    required this.imageURL,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: DrawerHeader(
            child: Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: CachedNetworkImage(
                  imageUrl: imageURL,
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) =>
                      Image.asset(Assets.imagesAvatar),
                ),
              ),
              Text(
                " أهلا $userName",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          top: 0,
          child: DayNightSwitcherIcon(
            isDarkModeEnabled: Get.isDarkMode,
            onStateChanged: (bool isDarkModeEnabled) {
              localController.switchTheme();
            },
          ),
        )
      ],
    )));
  }
}
