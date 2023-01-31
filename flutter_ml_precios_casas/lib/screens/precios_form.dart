import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../widgets/custom_text_form_view.dart';
import 'package:http/http.dart' as http;

class PreciosForm extends StatelessWidget {
  const PreciosForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    Map<String, double> sendValues = {
      "BsmtFinSF1": 0,
      "GarageYrBlt": 0,
      "FirstFlrSF": 0,
      "GarageArea": 0,
      "TotalBsmtSF": 0,
      "YearBuilt": 0,
      "GarageCars": 0,
      "GrLivArea": 0,
      "OverallQual": 0
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Precio Casas ML')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextfieldForm(
                    labelText: 'BsmtFinSF1',
                    hintText: '0.0',
                    formProperty: 'BsmtFinSF1',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'GarageYrBlt',
                    hintText: '0.0',
                    formProperty: 'GarageYrBlt',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'FirstFlrSF',
                    hintText: '0.0',
                    formProperty: 'FirstFlrSF',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'GarageArea',
                    hintText: '0.0',
                    formProperty: 'GarageArea',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'TotalBsmtSF',
                    hintText: '0.0',
                    formProperty: 'TotalBsmtSF',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'YearBuilt',
                    hintText: '0.0',
                    formProperty: 'YearBuilt',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'GarageCars',
                    hintText: '0.0',
                    formProperty: 'GarageCars',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'GrLivArea',
                    hintText: '0.0',
                    formProperty: 'GrLivArea',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                CustomTextfieldForm(
                    labelText: 'OverallQual',
                    hintText: '0.0',
                    formProperty: 'OverallQual',
                    formValues: sendValues,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 30),
                ElevatedButton(
                  child: const Text('Comprobar'),
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    print(sendValues);
                    final url =
                        Uri.http('10.0.2.2:8000', '/forests-predictions');

                    final response = await http.post(url,
                        body: json.encode(sendValues),
                        headers: {
                          'Content-Type': "application/json;charset=utf-8"
                        });

                    print('Code Status: ${response.statusCode}');
                    print('Response Body: ${response.body}');

                    var precio_casa = 0.00;

                    if (response.statusCode == 201) {
                      final jsonResponse = jsonDecode(response.body);
                      precio_casa = (jsonResponse['precio_forest']);


                          Alert(
                context: context,
                title: "Precio",
                desc: "Los datos ingresados dan como precio: ${precio_casa}!",
                buttons: [
                  DialogButton(child: Text("OK"), onPressed: () => Navigator.pop(context),)
                ]).show();  
                    }
                    


                    
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
