// ignore: depend_on_referenced_packages
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../../routes/routes.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../utils/basic_screen_imports.dart';
import '../../views/congratulation/congratulation_screen.dart';

// ignore: must_be_immutable
class WebPaymentScreen extends StatelessWidget {
  WebPaymentScreen({
    super.key,
    required this.appBarName,
    required this.webUri,
    required this.subtitle,
  });

  final String appBarName, webUri, subtitle;

  late InAppWebViewController webViewController;
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, value) {
        if (didPop) {
          return;
        }
        Get.offAllNamed(Routes.bottomNavBar);
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Get.isDarkMode
                ? CustomColor.whiteColor
                : CustomColor.whiteColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: CustomColor.blackColor,
              ),
              onPressed: () {
                Get.close(1);
              },
            ),
            elevation: 0,
            centerTitle: false,
            title: TitleHeading2Widget(
              text: appBarName,
              color: CustomColor.blackColor,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.offAllNamed(Routes.bottomNavBar);
                },
                icon: Icon(
                  Icons.home,
                  size: 30.sp,
                  color: Get.isDarkMode
                      ? CustomColor.primaryLightColor
                      : CustomColor.primaryLightColor,
                ),
              ),
            ],
          ),
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Stack(
      children: [
        InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(webUri)),
          onWebViewCreated: (InAppWebViewController controller) {
            webViewController = controller;
            controller.addJavaScriptHandler(
              handlerName: 'jsHandler',
              callback: (args) {
                // Handle JavaScript messages from WebView
              },
            );
          },
          onLoadStart: (controller, url) {
            isLoading.value = true;
          },
          onProgressChanged:
              (InAppWebViewController controller, int progress) {},
          onLoadStop: (InAppWebViewController controller, Uri? url) {
            isLoading.value = false;
            if (url.toString().contains('success/response') ||
                url.toString().contains('complete') ||
                url.toString().contains('status=successful') ||
                url.toString().contains('/callback') ||
                url.toString().contains(
                  'add-money/razor/callback?razorpay_order_id',
                ) ||
                url.toString().contains('sslcommerz/payment/success?') ||
                url.toString().contains('stripe/payment/success/')) {
              Get.to(
                () => CongratulationScreen(
                  route: Routes.bottomNavBar,
                  subTitle: subtitle,
                  title: Strings.congratulations,
                ),
              );
            } else if (url.toString().contains(
              'add-money/cancel/response/paypal',
            )) {
              Get.offAllNamed(Routes.bottomNavBar);
            }
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading,
          builder: (context, isLoading, _) {
            return isLoading
                ? const Center(child: CustomLoadingAPI())
                : const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
