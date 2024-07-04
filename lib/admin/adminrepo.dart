import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:veloadminpanel/admin/adminModel.dart';

class AdminRepo {
  Future<AdminModel?> adminPanel({
    required int partsCat,
    required int v_brand,
    required int v_category,
    required String price,
    required String parts_name,
    required String description,
    required String productRating,
    required File? image,
  }) async {
    try {
      EasyLoading.show();

      var data = FormData.fromMap({
        if (image != null)
          'part_image': await MultipartFile.fromFile(image.path,
              filename: image.path.split('/').last),
        'parts_Cat': partsCat,
        'v_brand': v_brand,
        'v_category': v_category,
        'price': price,
        'parts_name': parts_name,
        'description': description,
        'product_rating': productRating
      });

      print('Request payload: ${data.fields}');

      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/parts_categories/',
        options: Options(
          method: 'POST',
          validateStatus: (status) {
            return status! < 500; // Allow responses with status codes < 500
          },
        ),
        data: data,
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        EasyLoading.dismiss();

        return AdminModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        // Print the response data to see what the server returned
        print('Unexpected response: ${response.data}');
      }
    } catch (e) {
      EasyLoading.dismiss();
      print('This is your error: $e');
    }
    return null;
  }
}
