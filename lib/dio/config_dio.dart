import 'package:dio/dio.dart';
import 'package:news_app/dio/dio_exception.dart';
import 'package:news_app/src/models/chats/base_model.dart';
import 'package:news_app/src/models/news/news_model.dart';
import 'package:news_app/src/models/news/results_model.dart';
import 'end_point.dart';

class DioClient {
  DioClient()
      : _dio = Dio(BaseOptions(
            baseUrl: Endpoints.baseURL,
            connectTimeout: Endpoints.connectionTimeout,
            receiveTimeout: Endpoints.receiveTimeout,
            queryParameters: {
              "apiKey": Endpoints.apiKey,
              "language": 'en',
            }));

  final Dio _dio;

  Future<BaseModel> fetchNews() async {
    try {
      final response = await _dio.get('/news');
      var news = News.fromJson(response.data);
      List<Results>? listResults = news.results;
      return BaseModel(data: listResults);
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      return BaseModel(data: null, error: errorMesage);
    }
  }

  Future<BaseModel> fetchNewsForYou() async {
    try {
      final response = await _dio
          .get('/news', queryParameters: {"category": "business,sports"});
      var news = News.fromJson(response.data);
      List<Results>? listResults = news.results;
      return BaseModel(data: listResults);
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      return BaseModel(data: null, error: errorMesage);
    }
  }

  Future<BaseModel> fetchNewsEntertainment() async {
    try {
      final response = await _dio
          .get('/news', queryParameters: {"category": "entertainment"});
      var news = News.fromJson(response.data);
      List<Results>? listResults = news.results;
      return BaseModel(data: listResults);
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      return BaseModel(data: null, error: errorMesage);
    }
  }

  Future<BaseModel> fetchNewsWithTopics(String topic) async {
    try {
      final response =
          await _dio.get('/news', queryParameters: {"category": topic});
      var news = News.fromJson(response.data);
      List<Results>? listResults = news.results;
      return BaseModel(data: listResults);
    } on DioError catch (err) {
      final errorMesage = DioException.fromDioError(err).toString();
      return BaseModel(data: null, error: errorMesage);
    }
  }
}
