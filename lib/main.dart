import 'package:diabetes_app/data/model/diabetes.dart';
import 'package:diabetes_app/data/repositories/diabetes_repository_impl.dart';
import 'package:diabetes_app/repositories/diabetes_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'data/model/result.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    DiabetesRepository diabetesRepository = DiabetesRepositoryImpl(client);
    TextEditingController ageController = TextEditingController();
    TextEditingController bmiController = TextEditingController();
    TextEditingController hemoglobinController = TextEditingController();
    TextEditingController glucoseController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController hypertensionController = TextEditingController();
    // TextEditingController diabetesController = TextEditingController();
    TextEditingController heartDiseaseController = TextEditingController();
    TextEditingController smokingHistoryController = TextEditingController();

    Future<void> showResultDialog(BuildContext context, Result result) async {
      final probability =
          (double.parse(result.values[0][10]) * 100).toStringAsFixed(2);
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Result'),
            content: Text(
                'The chance that you have diabetes is: ${double.parse(probability)}%'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("DiabetesApp")),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Gender: "),
                  DropdownMenu(
                    controller: genderController,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "Female", label: "Female"),
                      DropdownMenuEntry(value: "Male", label: "Male"),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Age: "),
                    Expanded(
                      child: TextField(
                        controller: ageController,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Hypertension: "),
                  DropdownMenu(
                    onSelected: (value) => hypertensionController.text = value!,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "0", label: "No"),
                      DropdownMenuEntry(value: "1", label: "Yes")
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Heart disease: "),
                  DropdownMenu(
                    onSelected: (value) => heartDiseaseController.text = value!,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "0", label: "No"),
                      DropdownMenuEntry(value: "1", label: "Yes")
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Smoking history: "),
                  DropdownMenu(
                    onSelected: (value) =>
                        smokingHistoryController.text = value!,
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: "never", label: "Never"),
                      DropdownMenuEntry(
                          value: "not current", label: "Not current"),
                      DropdownMenuEntry(value: "former", label: "Former"),
                      DropdownMenuEntry(value: "current", label: "Current"),
                      DropdownMenuEntry(value: "ever", label: "Ever"),
                      DropdownMenuEntry(value: "No Info", label: "No Info")
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("BMI: "),
                    Expanded(
                      child: TextField(
                        controller: bmiController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("HbA1c level (Hemoglobin A1c): "),
                    Expanded(
                      child: TextField(
                        controller: hemoglobinController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Blood glucose level: "),
                    Expanded(
                      child: TextField(
                        controller: glucoseController,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    diabetesRepository
                        .getResult(Diabetes(
                            gender: genderController.text.trim(),
                            age: ageController.text.trim(),
                            hypertension: hypertensionController.text.trim(),
                            heartDisease: heartDiseaseController.text.trim(),
                            smokingHistory:
                                smokingHistoryController.text.trim(),
                            bmi: bmiController.text.trim(),
                            hbA1cLevel: hemoglobinController.text.trim(),
                            bloodGlucoseLevel: glucoseController.text.trim(),
                            diabetes: "1"))
                        .then((result) {
                      showResultDialog(context, result);
                    });
                  },
                  child: const Text("Get result"))
              // ElevatedButton(
              //     onPressed: () {
              //       diabetesRepository
              //           .getResult(Diabetes(
              //               gender: "Male",
              //               age: "25",
              //               hypertension: "0",
              //               heartDisease: "0",
              //               smokingHistory: "never",
              //               bmi: "27",
              //               hbA1cLevel: "5",
              //               bloodGlucoseLevel: "150",
              //               diabetes: "0"))
              //           .then((result) {
              //         showResultDialog(context, result);
              //       });
              //     },
              //     child: const Text("Get result"))
            ],
          ),
        ),
      ),
    );
  }
}
