import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:veloadminpanel/admin/adminviewModel.dart';
import 'package:veloadminpanel/bottomBar/bottombar.dart';
import 'package:veloadminpanel/users/ViewModel/userViewModel.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AdminViewModel(),
    ),
    ChangeNotifierProvider(
      create: (context) => UserViewModel(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      builder: EasyLoading.init(),
      home: const AdminBottomBar(),
    );
  }
}
