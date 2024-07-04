import 'package:flutter/material.dart';

Widget buildDropdownField({
  required String labelText,
  required int? value,
  required List<Map<String, dynamic>> items,
  required ValueChanged<int?> onChanged,
}) {
  return DropdownButtonFormField<int>(
    decoration: InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    value: value,
    items: items
        .map((item) => DropdownMenuItem<int>(
              value: item['id'],
              child: Text(item['name']),
            ))
        .toList(),
    onChanged: onChanged,
    validator: (value) {
      if (value == null) {
        return 'Please select a $labelText';
      }
      return null;
    },
    onSaved: (value) {
      value;
    },
  );
}

Widget buildTextField({
  required String labelText,
  required FormFieldSetter<String> onSaved,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $labelText';
      }
      if (labelText == 'Price' || labelText == 'Product Rating') {
        if (double.tryParse(value) == null) {
          return 'Please enter a valid number';
        }
      }
      return null;
    },
    onSaved: onSaved,
  );
}
