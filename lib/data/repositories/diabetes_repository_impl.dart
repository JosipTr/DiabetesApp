import 'dart:convert';

import 'package:diabetes_app/repositories/diabetes_repository.dart';
import 'package:http/http.dart' as http;

import '../model/diabetes.dart';
import '../model/result.dart';

class DiabetesRepositoryImpl implements DiabetesRepository {
  final http.Client _client;

  const DiabetesRepositoryImpl(this._client);

  @override
  Future<Result> getResult(Diabetes diabetes) async {
    print(diabetes.toString());
    final scoreRequest = diabetes.toJson();
    print(scoreRequest.toString());

    const apiKey =
        'EzSEEACit1SVmmw4O46mHjC4Dr0tOfyt337SGFc1cNOietW5NqMXCUrVRU/3Uc6AM6L7HMP0WlkU+AMCO2ttEA=='; // Zamijenite ovo s API ključem za web uslugu
    final headers = {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final url = Uri.parse(
        'https://ussouthcentral.services.azureml.net/workspaces/1b07fc8594b740f69077d563f6dcf85c/services/5ea5777d17dd4d638c6e01cb13c578fb/execute?api-version=2.0&details=true');

    try {
      final response = await _client.post(url,
          headers: headers, body: json.encode(scoreRequest));

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print('Result: $result');
        final diabetesResult = Result.fromJson(result);
        return diabetesResult;
      } else {
        print('The request failed with status code: ${response.statusCode}');
        print(response.headers);
        final responseContent = json.decode(response.body);
        print(responseContent);
        throw Exception("Server error");
      }
    } catch (error) {
      print('Error: $error');
      throw Exception("Server error");
    }
  }
}
