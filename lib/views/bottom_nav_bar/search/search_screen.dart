// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';

import '../../../controller/search/search_controller.dart';
import '../../../custom_assets/assets.gen.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/commo/grid_item_widget.dart';
import '../../../widgets/dashboard/live_match_list_widget.dart';
import '../../../widgets/inputs/search_input_widget.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final controller = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 2.4),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SearchInputWidget(
              controller: controller.searchController,
              hint: Strings.searchBy,
              prefixIcon: Padding(
                padding: EdgeInsets.all(Dimensions.paddingSize * .6),
                child: SvgPicture.asset(
                  Assets.icons.mystery,
                  height: 16.h,
                  width: 16.w,
                  color: Colors.white54,
                ),
              ),
            ),
            verticalSpace(Dimensions.heightSize),
            _recentSearchWidget(context),
            verticalSpace(Dimensions.heightSize * 2),
            Column(
              crossAxisAlignment: crossStart,
              children: [
                _textWidget(context, "Popular ", "Items"),
                verticalSpace(Dimensions.heightSize),
                LiveMatchListWidget(
                  title: '',
                  sport: const [],
                  imagePath: '',
                ),
                verticalSpace(Dimensions.heightSize),
                _textWidget(context, "Recommendations ", "For You"),
                verticalSpace(Dimensions.heightSize),
                LiveMatchListWidget(
                  title: '',
                  sport: const [],
                  imagePath: '',
                ),
              ],
            ),
            verticalSpace(Dimensions.heightSize * 2)
          ],
        ),
      ),
    );
  }

  _recentSearchWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: mainStart,
      crossAxisAlignment: crossStart,
      mainAxisSize: mainMax,
      children: [
        TitleHeading4Widget(text: Strings.recentSearches),
        verticalSpace(Dimensions.heightSize),
        Wrap(
          spacing: Dimensions.widthSize * 1.25, // Space between each item
          runSpacing: Dimensions.heightSize, // Space between rows
          children: controller.searchList.map((title) {
            return GridItemWidget(title: title);
          }).toList(),
        ),
      ],
    );
  }

  Widget _textWidget(BuildContext context, String text1, text2) {
    return Text.rich(
      TextSpan(
        text: text1,
        children: [
          TextSpan(
            text: text2,
            style: CustomStyle.lightHeading3TextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.headingTextSize3,
              color: CustomColor.primaryLightColor,
            ),
          )
        ],
        style: CustomStyle.lightHeading3TextStyle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.headingTextSize3,
        ),
      ),
    );
  }
}
