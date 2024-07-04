import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:veloadminpanel/Constents/colors.dart';
import 'package:veloadminpanel/Constents/font.dart';
import 'package:veloadminpanel/admin/adminConstants.dart';
import 'package:veloadminpanel/admin/adminviewModel.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  final _formKey = GlobalKey<FormState>();

  File? _image;

  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _categories = [
    {'id': 2, 'name': 'Tyre'},
    {'id': 3, 'name': 'Engine'},
    {'id': 4, 'name': 'Helmet'},
    {'id': 5, 'name': 'Alloy'},
    {'id': 6, 'name': 'Seat'},
    {'id': 7, 'name': 'Lights'},
  ];

  final List<Map<String, dynamic>> _brands = [
    {'id': 1, 'name': 'Yamaha'},
    {'id': 2, 'name': 'Bajaj'},
    {'id': 3, 'name': 'TVS'},
    {'id': 4, 'name': 'Honda'},
    {'id': 5, 'name': 'Hero'},
    {'id': 6, 'name': 'Royal Enfield'},
    {'id': 8, 'name': 'Tata'},
    {'id': 9, 'name': 'Ford'},
    {'id': 10, 'name': 'Toyota'},
    {'id': 11, 'name': 'KIA'},
    {'id': 12, 'name': 'MG'},
    {'id': 13, 'name': 'Audi'},
  ];

  final List<Map<String, dynamic>> _vehicleCategories = [
    {'id': 2, 'name': 'Car'},
    {'id': 3, 'name': 'Bike'},
  ];

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final adminViewModel = Provider.of<AdminViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admin Panel - Add Product Parts',
            style: authText(19, blackColor, FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: InkWell(
                    onTap: _pickImage,
                    child: _image == null
                        ? Container(
                            height: MediaQuery.of(context).size.height / 4.8,
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: Center(
                              child: Text(
                                'Pick an Image',
                                style:
                                    authText(16, blackColor, FontWeight.w600),
                              ),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height / 4.8,
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ]),
                            child: Image.file(
                              _image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 20),
                buildDropdownField(
                  labelText: 'Category',
                  value: adminViewModel.partsCat,
                  items: _categories,
                  onChanged: (value) {
                    setState(() {
                      adminViewModel.partsCat = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                buildDropdownField(
                  labelText: 'Brand',
                  value: adminViewModel.vBrand,
                  items: _brands,
                  onChanged: (value) {
                    setState(() {
                      adminViewModel.vBrand = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                buildDropdownField(
                  labelText: 'Vehicle Category',
                  value: adminViewModel.vCategory,
                  items: _vehicleCategories,
                  onChanged: (value) {
                    setState(() {
                      adminViewModel.vCategory = value!;
                    });
                  },
                ),
                // buildDropdownField(
                //   labelText: 'Product Rating',
                //   value: _productRating,
                //   items: _productRatingList,
                //   onChanged: (value) {
                //     setState(() {
                //       _productRating = value!;
                //     });
                //   },
                // ),
                SizedBox(height: 16),

                // buildTextField(
                //   labelText: 'Price',
                //   onSaved: (value) {
                //     _price = value!;
                //   },
                // ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'price',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter price';
                  //   }
                  //   if ('price' == 'Price' || 'Product Rating' == 'Product Rating') {
                  //     if (double.tryParse(value) == null) {
                  //       return 'Please enter a valid number';
                  //     }
                  //   }
                  //   return null;
                  // },
                  onSaved: (value) {
                    adminViewModel.price = value!;
                  },
                ),
                SizedBox(height: 16),
                buildTextField(
                  labelText: 'Part Name',
                  onSaved: (value) {
                    adminViewModel.partsName = value!;
                  },
                ),
                SizedBox(height: 16),
                buildTextField(
                  labelText: 'Description',
                  onSaved: (value) {
                    adminViewModel.description = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[1-5]')),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'product rating',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onSaved: (value) {
                    adminViewModel.productRating = value!;
                  },
                ),
                // buildTextField(
                //   labelText: 'Product Rating',
                //   onSaved: (value) {
                //     _productRating = value!;
                //   },
                // ),

                SizedBox(height: 15),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        Provider.of<AdminViewModel>(context, listen: false)
                            .adminpanel(
                                partsCat: adminViewModel.partsCat!,
                                v_brand: adminViewModel.vBrand!,
                                v_category: adminViewModel.vCategory!,
                                price: adminViewModel.price,
                                parts_name: adminViewModel.partsName,
                                description: adminViewModel.description,
                                productRating: adminViewModel.productRating,
                                image: _image,
                                context: context);
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: cyanColor,
                          borderRadius: BorderRadius.circular(16)),
                      height: size.height / 17,
                      width: size.width / 1.3,
                      child: Center(
                          child: Text(
                        'Submit',
                        style: authText(16, blackColor, FontWeight.w400),
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
