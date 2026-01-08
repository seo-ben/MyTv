import '/utils/device_info.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:MyTelevision/backend/services/api_endpoint.dart';
import 'package:MyTelevision/utils/tablet_check.dart';
import 'package:flutter/services.dart';

import '/controller/navbar/dashboard/dashboard_controller.dart';
import '../../utils/basic_screen_imports.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  final controller = Get.put(DashboardController());
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        _carouselController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        _carouselController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = controller.homeInfoModel.data.carousalData;
    var imagePath = controller.homeInfoModel.data.siteSection;

    List<Widget> itemList = [];
    for (int i = 0; i < data.length; i++) {
      itemList.add(
        _upperBodyWidget(
          context,
          "${ApiEndpoint.mainDomain}/$imagePath/${data[i].image}",
          data[i].buttonName,
          data[i].link,
          data[i].id.toString(),
        ),
      );
    }

    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: DeviceInfo.isTv,
      onKeyEvent: _handleKeyEvent,
      child: CarouselSlider(
        carouselController: _carouselController,
        items: itemList,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          height:
              MediaQuery.sizeOf(context).height *
              (DeviceInfo.isTv ? 0.65 : 0.25),
          clipBehavior: Clip.none,
          aspectRatio: isTablet(context) ? 1.35 : 1.35,
          onPageChanged: (index, reason) {
            controller.currentIndex.value = index;
          },
        ),
      ).paddingOnly(top: Dimensions.heightSize * (DeviceInfo.isTv ? 2.0 : 3.5)),
    );
  }

  _upperBodyWidget(BuildContext context, String image, buttonName, link, id) {
    bool isTab = MediaQuery.sizeOf(context).width > 600;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width,
          height: isTab
              ? MediaQuery.sizeOf(context).height
              : MediaQuery.sizeOf(context).height * 0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }
}
