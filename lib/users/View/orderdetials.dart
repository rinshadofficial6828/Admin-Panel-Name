import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veloadminpanel/Constents/colors.dart';
import 'package:veloadminpanel/Constents/font.dart';
import 'package:veloadminpanel/users/ViewModel/userViewModel.dart';

class Userdetials extends StatefulWidget {
  final int id;
  const Userdetials({super.key, required this.id});

  @override
  State<Userdetials> createState() => _UserdetialsState();
}

class _UserdetialsState extends State<Userdetials> {
  @override
  void initState() {
    super.initState();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    userViewModel.getMyOrder(id: widget.id);
  }

  final Map<String, Color> StatusColor = {
    'Placed': Colors.blue,
    'Shipped': Colors.orange,
    'Out for Delivery': Colors.yellow,
    'Delivered': Colors.green
  };

  Color getStatusColor({String? status}) {
    return StatusColor[status] ?? Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'User Order Details',
          style: authText(18, blackColor, FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            userViewModel.myOrderList.isEmpty
                ? Center(
                    child: Text(
                    'No Order Found',
                    style: authText(20, Colors.red, FontWeight.w700),
                  ))
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: userViewModel.myOrderList.length,
                    itemBuilder: (context, index) {
                      final data = userViewModel.myOrderList[index];
                      userViewModel.status = data.currentStatus ?? '';
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    color: Colors.grey,
                                    spreadRadius: 1)
                              ]),
                          child: Row(
                            children: [
                              Image.network(
                                data.part?.partImage ?? '',
                                fit: BoxFit.contain,
                                height: size.height / 14,
                                width: size.width / 6,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.part?.partsName ?? 'Parts Name',
                                      style: authText(
                                          16, blackColor, FontWeight.w500),
                                    ),
                                    Text(
                                      data.part?.price ?? 'price',
                                      style: authText(
                                          15, blackColor, FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                  onTap: () {
                                    showMyDialog(
                                        context: context,
                                        orderId: userViewModel
                                                .myOrderList[index].id ??
                                            0);

                                    setState(() {
                                      userViewModel.getMyOrder(id: widget.id);
                                    });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: getStatusColor(
                                              status: userViewModel.status),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Text(
                                        userViewModel.status ?? '',
                                        style: authText(
                                            16, whiteColor, FontWeight.w500),
                                      )))
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Future showMyDialog(
      {required BuildContext context, required int orderId}) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cyanColor,
          title: Center(
            child: Text(
              'Update Shipping Status',
              style: authText(25, Colors.red, FontWeight.bold),
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: userViewModel.statuses.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          userViewModel.status = userViewModel.statuses[index];
                          await userViewModel.updateStatus(
                              context: context,
                              id: orderId,
                              status: userViewModel.status);
                          Navigator.pop(context);
                          setState(() {
                            userViewModel.getMyOrder(id: widget.id);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            userViewModel.statuses[index],
                            style: authText(16, whiteColor, FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
