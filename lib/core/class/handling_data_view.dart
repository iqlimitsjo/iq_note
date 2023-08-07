import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../generated/assets.dart';
import 'status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(Assets.lottieLoading, height: 250, width: 250),
              const Text("جار التحميل "),
            ],
          ))
        : statusRequest == StatusRequest.offline
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.lottieOffline, height: 250, width: 250),
                    const Text("لا يوجد اتصال بالانترنت"),
                  ],
                ),
              )
            : statusRequest == StatusRequest.serverFail
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.lottieServerError,
                            height: 250, width: 250),
                        const Text("خطأ الاتصال بالبيانات"),
                      ],
                    ),
                  )
                : statusRequest == StatusRequest.failed
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(Assets.lottieNoData,
                                height: 250, width: 250, repeat: false),
                            const Text("لا يوجد بيانات"),
                          ],
                        ),
                      )
                    : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(Assets.lottieLoading, height: 250, width: 250),
              const Text("جار التحميل "),
            ],
          ))
        : statusRequest == StatusRequest.offline
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(Assets.lottieOffline, height: 250, width: 250),
                    const Text("لا يوجد اتصال بالانترنت"),
                  ],
                ),
              )
            : statusRequest == StatusRequest.serverFail
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset(Assets.lottieServerError,
                            height: 250, width: 250),
                        const Text("خطأ الاتصال بالبيانات"),
                      ],
                    ),
                  )
                : widget;
  }
}
