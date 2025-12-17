import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final searchController = TextEditingController();
  List<String> searchList = [
    "Marvel",
    "Captain America",
    "Captain Marvel",
    "Thor",
  ];
}
