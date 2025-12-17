// import '../../../utils/basic_screen_imports.dart';
//
// class TransactionHistoryScreen extends StatelessWidget {
//   const TransactionHistoryScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TitleHeading2Widget(text: Strings.subscriptionLogs),
//         backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
//         automaticallyImplyLeading: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: CustomColor.whiteColor,
//           ),
//         ),
//       ),
//       body: Obx(
//             () => controller.isLoading
//             ? const CustomLoadingAPI()
//             : _bodyWidget(context),
//       ),
//     );
//   }
//
//   _bodyWidget(BuildContext context) {
//     return const Column();
//   }
// }
