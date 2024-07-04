import 'dart:io';

import 'package:flutter/material.dart';
import 'package:veloadminpanel/Constents/colors.dart';
import 'package:veloadminpanel/Constents/flush_custom.dart';
import 'package:veloadminpanel/admin/adminrepo.dart';

class AdminViewModel extends ChangeNotifier {
  AdminRepo adminRepo = AdminRepo();
  int? partsCat;
  int? vBrand;
  int? vCategory;
  String price = '';
  String partsName = '';
  String description = '';
  String productRating = '';

  adminpanel(
      {required int partsCat,
      required int v_brand,
      required int v_category,
      required String price,
      required String parts_name,
      required String description,
      required String productRating,
      required File? image,
      required BuildContext context}) async {
    var result = await adminRepo.adminPanel(
      image: image,
      partsCat: partsCat,
      v_brand: v_brand,
      v_category: v_category,
      price: price,
      parts_name: parts_name,
      description: description,
      productRating: productRating,
    );

    if (result != null) {
      // Handle successful result
      print("Success: $result");
      showFlushBarCustom(
          context: context,
          color: cyanColor,
          message: 'Item Added Succesfully');
      partsCat != '';
      parts_name == '';
    } else {
      showFlushBarCustom(
          context: context, color: Colors.red, message: 'Failed to add item');
      print("Failed to submit the data.");
    }

    notifyListeners();
  }
}
