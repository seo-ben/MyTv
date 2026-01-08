import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import 'package:MyTelevision/controller/auth/sign_up/kyc_information/kyc_controller.dart';

import '../../utils/basic_screen_imports.dart';
import '../commo/image_picker_sheet_widget.dart';

File? imageFile;

class UpdateKycImageWidget extends StatefulWidget {
  const UpdateKycImageWidget({
    super.key,
    required this.labelName,
    required this.fieldName,
  });

  final String labelName;
  final String fieldName;

  @override
  State<UpdateKycImageWidget> createState() => _DropFileState();
}

class _DropFileState extends State<UpdateKycImageWidget> {
  final controller = Get.put(KycController());
  // final controller = Get.find<BasicDataController>();

  Future pickImage(imageSource) async {
    try {
      final image = await ImagePicker().pickImage(
        source: imageSource,
        imageQuality: 50,
      );
      if (image == null) return;

      imageFile = File(image.path);

      // if (controller.listFieldName.isNotEmpty) {
      //   if (controller.listFieldName.contains(widget.fieldName)) {
      //     int itemIndex = controller.listFieldName.indexOf(widget.fieldName);
      //     controller.listFieldName[itemIndex] = widget.fieldName;
      //     controller.listImagePath[itemIndex] = imageFile!.path;
      //   } else {
      //     controller.listImagePath.add(imageFile!.path);
      //     controller.listFieldName.add(widget.fieldName);
      //   }
      // } else {
      //   controller.listImagePath.add(imageFile!.path);
      //   controller.listFieldName.add(widget.fieldName);
      // }
      // setState(() {
      //   controller.updateImageData(widget.fieldName, imageFile!.path);
      // });
      // Get.back();
      // CustomSnackBar.success('$labelName Added');
    } on PlatformException catch (_) {
      // CustomSnackBar.error('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showImagePickerBottomSheet(context);
      },
      child: Container(
        decoration: BoxDecoration(
          border: RDottedLineBorder.all(
            color: CustomColor.whiteColor.withValues(alpha: .5),
          ),
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        child: Container(
          height: Dimensions.heightSize * 6,
          alignment: Alignment.center,
          margin: EdgeInsets.all(Dimensions.marginSizeHorizontal * 0.15),
          decoration: controller.getImagePath(widget.fieldName) == null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  color: CustomColor.buttonDeepColor,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(controller.getImagePath(widget.fieldName) ?? ''),
                    ),
                  ),
                ),
          child: Column(
            mainAxisAlignment: mainCenter,
            mainAxisSize: mainMin,
            children: [
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: TitleHeading5Widget(text: widget.labelName),
              // ).paddingSymmetric(
              //   horizontal: Dimensions.widthSize,
              // ),
              // verticalSpace(Dimensions.heightSize),
              Visibility(
                visible: controller.listImagePath.isEmpty,
                child: Icon(
                  Icons.backup,
                  color: CustomColor.whiteColor.withValues(alpha: 0.3),
                ),
              ),
              horizontalSpace(Dimensions.widthSize),
              Visibility(
                visible: controller.listImagePath.isEmpty,
                child: TitleHeading4Widget(
                  text: Strings.upload,
                  textOverflow: TextOverflow.fade,
                  color: CustomColor.whiteColor.withValues(alpha: 0.2),
                  fontSize: Dimensions.headingTextSize5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: ImagePickerSheet(
            fromCamera: () {
              pickImage(ImageSource.camera);
            },
            fromGallery: () {
              pickImage(ImageSource.gallery);
            },
          ),
        );
      },
    );
  }
}
