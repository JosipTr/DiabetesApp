import 'package:diabetes_app/data/model/diabetes.dart';

import '../data/model/result.dart';

abstract class DiabetesRepository {
  Future<Result> getResult(Diabetes diabetes);
}
