import 'package:flutter/material.dart';
import 'package:veloadminpanel/Constents/flush_custom.dart';
import 'package:veloadminpanel/users/Model/MyOrdermodel.dart';
import 'package:veloadminpanel/users/Model/UserModel.dart';
import 'package:veloadminpanel/users/Model/updatestatus.dart';
import 'package:veloadminpanel/users/Repositery/repo.dart';

class UserViewModel extends ChangeNotifier {
  UserRepo userRepo = UserRepo();
  String status = "";
  List<UserModel> usersList = [];
  List<Orders> myOrderList = [];
  UpdateStatus? uPdateStatus;
  List<String> statuses = [
    'Placed',
    'Shipped',
    'Out for delivery',
    'Delivered'
  ];
  getUsers() async {
    await userRepo.getUsers().then(
      (value) {
        usersList.addAll(value ?? []);
      },
    );
    notifyListeners();
  }

  getMyOrder({required int id}) async {
    await userRepo.fetchOrderbyId(id: id).then(
      (value) {
        print(value?.toJson());
        myOrderList = value?.orders ?? [];
      },
    );
    notifyListeners();
  }

  updateStatus(
      {required int id,
      required String status,
      required BuildContext context}) async {
    await userRepo.updateStatus(id: id, status: status).then(
      (value) {
        print('updated $value');
        if (value == null) {
          showFlushBarCustom(
              context: context,
              color: Colors.red,
              message: 'Failed to update shipping status');
          notifyListeners();
        } else {
          Navigator.of(context).pop();
          showFlushBarCustom(
              context: context,
              color: Colors.cyan,
              message: 'succefully  update shipping status');
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }
}
