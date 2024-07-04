import 'package:flutter/material.dart';
import 'package:veloadminpanel/Constents/colors.dart';
import 'package:veloadminpanel/admin/admin.dart';
import 'package:veloadminpanel/users/View/users.dart';

class AdminBottomBar extends StatefulWidget {
  const AdminBottomBar({super.key});

  @override
  State<AdminBottomBar> createState() => _AdminBottomBarState();
}

int page = 0;

class _AdminBottomBarState extends State<AdminBottomBar> {
  List<Widget> pages = [AdminPanelPage(), Users()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: BottomNavigationBar(
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              label: 'Add Products',
              icon: Icon(
                Icons.add_box_outlined,
                color: blackColor,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: 'View Orders ',
              icon: Icon(
                Icons.person,
                color: blackColor,
                size: 30,
              ),
            )
          ],
          backgroundColor: cyanColor,
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
        ),
      ),
      body: pages[page],
    );
  }
}
