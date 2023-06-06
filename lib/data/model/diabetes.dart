class Diabetes {
  String gender;
  String age;
  String hypertension;
  String heartDisease;
  String smokingHistory;
  String bmi;
  String hbA1cLevel;
  String bloodGlucoseLevel;
  String diabetes;

  Diabetes({
    required this.gender,
    required this.age,
    required this.hypertension,
    required this.heartDisease,
    required this.smokingHistory,
    required this.bmi,
    required this.hbA1cLevel,
    required this.bloodGlucoseLevel,
    required this.diabetes,
  });

  factory Diabetes.fromJson(Map<String, dynamic> json) {
    final values = json['Results']['output1']['value']['Values'][0];
    return Diabetes(
      gender: values[0],
      age: values[1],
      hypertension: values[2],
      heartDisease: values[3],
      smokingHistory: values[4],
      bmi: values[5],
      hbA1cLevel: values[6],
      bloodGlucoseLevel: values[7],
      diabetes: values[8],
    );
  }

  Map<String, dynamic> toJson() {
    final scoreRequest = {
      'Inputs': {
        'input1': {
          'ColumnNames': [
            'gender',
            'age',
            'hypertension',
            'heart_disease',
            'smoking_history',
            'bmi',
            'HbA1c_level',
            'blood_glucose_level',
            'diabetes'
          ],
          'Values': [
            [
              gender,
              age,
              hypertension,
              heartDisease,
              smokingHistory,
              bmi,
              hbA1cLevel,
              bloodGlucoseLevel,
              diabetes,
            ],
          ],
        },
      },
      'GlobalParameters': {},
    };
    return scoreRequest;
  }
}
