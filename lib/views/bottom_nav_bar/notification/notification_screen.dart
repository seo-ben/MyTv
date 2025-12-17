import 'package:intl/intl.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/drawer/subscription_log/subscription_log_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/logs/subscription_card_widget.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});
  final controller = Get.put(SubscriptionLogController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.transactionModel.data.transactions;
    return data.isEmpty
        ? Center(
            child: TitleHeading2Widget(
              text: Strings.noDataFound,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.only(
              left: Dimensions.paddingSize * 0.7,
              right: Dimensions.paddingSize * 0.7,
              top: Dimensions.paddingSize * 1.136,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return SubscriptionCardWidget(
                title:
                    data[index].status == 1 ? "Subscribed" : "Not Subscribed",
                title2: data[index].trxId,
                day: DateTime.parse(data[index].createdAt.toString())
                    .day
                    .toString(),
                month: DateFormat("MMM")
                    .format(DateTime.parse(data[index].createdAt.toString())),
                amount:
                    "${double.parse(data[index].receiveAmount.toString()).toStringAsFixed(2)} ${data[index].requestCurrency}",
                status: data[index].status == 1
                    ? "Success"
                    : data[index].status == 2
                        ? "Pending"
                        : data[index].status == 3
                            ? "Hold"
                            : data[index].status == 4
                                ? "Rejected"
                                : "Waiting",
              );
            },
          );
  }
}
