class Result {
  String type;
  List<String> columnNames;
  List<String> columnTypes;
  List<List<dynamic>> values;

  Result({
    required this.type,
    required this.columnNames,
    required this.columnTypes,
    required this.values,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    final output1 = json['Results']['output1'];
    final value = output1['value'];

    return Result(
      type: output1['type'],
      columnNames: List<String>.from(value['ColumnNames']),
      columnTypes: List<String>.from(value['ColumnTypes']),
      values: List<List<dynamic>>.from(
          value['Values'].map((row) => List<dynamic>.from(row))),
    );
  }
}
