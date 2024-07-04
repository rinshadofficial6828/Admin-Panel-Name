import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veloadminpanel/Constents/colors.dart';
import 'package:veloadminpanel/Constents/font.dart';
import 'package:veloadminpanel/users/View/orderdetials.dart';
import 'package:veloadminpanel/users/ViewModel/userViewModel.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    userViewModel.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: true);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Users',
            style: authText(18, blackColor, FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: userViewModel.usersList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print(userViewModel.usersList[index].id ?? 0);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Userdetials(
                              id: userViewModel.usersList[index].id ?? 0),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: size.height / 12,
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 1,
                                color: Colors.grey,
                                spreadRadius: 1)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userViewModel.usersList[index].name ?? 'name',
                                  style:
                                      authText(16, blackColor, FontWeight.w500),
                                ),
                                Text(
                                  userViewModel.usersList[index].email ??
                                      'email',
                                  style:
                                      authText(16, blackColor, FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              'Orders',
                              style: authText(16, Colors.blue, FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
