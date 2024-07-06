import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:veloadminpanel/users/Model/MyOrdermodel.dart';
import 'package:veloadminpanel/users/Model/UserModel.dart';
import 'package:veloadminpanel/users/Model/updatestatus.dart';

class UserRepo {
  Future<List<UserModel>?> getUsers() async {
    try {
      EasyLoading.show();
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/users/',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        List<dynamic> data = response.data;
        List<UserModel> users =
            data.map((json) => UserModel.fromJson(json)).toList();
        return users;
      } else {
        EasyLoading.dismiss();

        print(response.statusMessage);
      }
    } catch (e) {
      EasyLoading.dismiss();

      print('this is your error$e');
    }
  }

  Future<MyOrderModel?> fetchOrderbyId({required int id}) async {
    try {
      EasyLoading.show();
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/my-orders/$id/',
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return MyOrderModel.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      print('This is your error$e');
    }
  }

  Future<UpdateStatus?> updateStatus(
      {required int id, required String status}) async {
    try {
      EasyLoading.show();
      var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      var data = {'status': status};
      var dio = Dio();
      var response = await dio.request(
        'https://prethewram.pythonanywhere.com/api/update-order-status/$id/',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        print(json.encode(response.data));
        return UpdateStatus.fromJson(response.data);
      } else {
        EasyLoading.dismiss();
        print(response.statusMessage);
      }
    } catch (e) {
      print('This is Your Error$e');
    }
  }
}
