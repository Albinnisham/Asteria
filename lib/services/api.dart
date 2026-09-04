import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/apod_model.dart';

class NASAApiService {
  NASAApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _host = 'api.nasa.gov';
  static const String _path = '/planetary/apod';
  static const String _apiKey = 'DEMO_KEY';

  final http.Client _client;

  Uri buildRequestUri(DateTime date) {
    return Uri.https(_host, _path, {
      'api_key': _apiKey,
      'date': DateFormat('yyyy-MM-dd').format(date),
    });
  }

  Future<ApodModel> fetchApod(DateTime date) async {
    final uri = buildRequestUri(date);

    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 20));

      if (response.statusCode != 200) {
        throw NASAApiException(_messageForStatusCode(response.statusCode));
      }

      final decodedJson = jsonDecode(response.body);

      if (decodedJson is! Map<String, dynamic>) {
        throw const NASAApiException('NASA returned an unexpected response.');
      }

      return ApodModel.fromJson(decodedJson);
    } on TimeoutException {
      throw const NASAApiException(
        'The request took too long. Check your connection and try again.',
      );
    } on NASAApiException {
      rethrow;
    } on FormatException {
      throw const NASAApiException(
        'NASA returned information that could not be read.',
      );
    } catch (_) {
      throw const NASAApiException(
        'We could not reach NASA. Check your internet connection.',
      );
    }
  }

  String _messageForStatusCode(int statusCode) {
    if (statusCode == 429) {
      return 'NASA is receiving too many requests. Wait a moment and retry.';
    }

    if (statusCode >= 500) {
      return 'NASA is having a temporary problem. Please try again shortly.';
    }

    return 'The cosmic discovery could not be loaded. Error $statusCode.';
  }

  void close() {
    _client.close();
  }
}

class NASAApiException implements Exception {
  const NASAApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
