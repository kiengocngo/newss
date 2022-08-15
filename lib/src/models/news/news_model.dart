import 'results_model.dart';

class News {
  final String? status;
  final int? totalResults;
  final List<Results> results;

  News(
      {required this.status,
      required this.totalResults,
      required this.results});

  factory News.fromJson(Map<String, dynamic> json) {
    List<dynamic> listResults = json['results'];
    return News(
      status: json["status"],
      totalResults: json["total_results"],
      results: listResults.map<Results>((e) => Results.fromJson(e)).toList(),
    );
  }
}
