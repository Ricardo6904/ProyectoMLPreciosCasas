import 'package:flutter/material.dart';

class CustomTextfieldForm extends StatelessWidget{
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final TextInputType? keyboardType;

  final Map<String, double> formValues;
  final String formProperty;
  const CustomTextfieldForm({
    Key? key, this.hintText, this.labelText, this.icon, this.keyboardType, required this.formValues, required this.formProperty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: labelText, 
        hintText: hintText,
        prefixIcon: const Icon(Icons.numbers)),
      onChanged: (value) => formValues[formProperty] = (value!='') ? double.parse(value):0.0,
      validator: (value){
        if (value==null) return 'Campo requerido';
        return value.length < 1 ? 'Campo requerido':null;
      },
    );
  }
  
}