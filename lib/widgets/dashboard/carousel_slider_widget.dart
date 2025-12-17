import 'package:carousel_slider/carousel_slider.dart';
import 'package:MyTelevision/backend/services/api_endpoint.dart';
import 'package:MyTelevision/utils/tablet_check.dart';

import '/controller/navbar/dashboard/dashboard_controller.dart';
import '../../utils/basic_screen_imports.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({super.key});
  final controller = Get.put(DashboardController());

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
    return CarouselSlider(
      items: itemList,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
        viewportFraction: 1,
        height: MediaQuery.sizeOf(context).height * .35,
        clipBehavior: Clip.none,
        aspectRatio: isTablet(context) ? 1.35 : 1.35,
        onPageChanged: (index, reason) {
          controller.currentIndex.value = index;
        },
      ),
    ).paddingOnly(top: Dimensions.heightSize * 3.5);
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
