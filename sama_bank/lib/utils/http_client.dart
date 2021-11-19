import 'dart:io';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'utils.dart';

class HttpClient {
  late final Dio client;
  late String baseUrl;
  bool showError;

  HttpClient({
    String? baseUrl,
    Dio? client,
    this.showError: true,
  }) {
    this.client = client ?? Dio();
    this.baseUrl = baseUrl ?? EnvironmentConfig.getEnv('BANK_API_URL')!;
  }

  Future<dynamic> get(String url, {Map<String, dynamic>? queries}) async {
    String resourceUrl = this.baseUrl + url;
    dynamic jsonResponse;
    Options options = Options(headers: {
      Headers.contentTypeHeader: 'application/json',
    });
    try {
      final response = await this.client.get(
            resourceUrl,
            queryParameters: queries,
            options: options,
          );
      jsonResponse = this._returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection !');
    }
    return jsonResponse;
  }

  Future<dynamic> post(String url, {Map<String, dynamic>? data}) async {
    String resourceUrl = this.baseUrl + url;
    dynamic jsonResponse;
    Options options = Options(headers: {
      Headers.contentTypeHeader: 'application/json',
    });
    try {
      final response = await this.client.post(
            resourceUrl,
            options: options,
            data: json.encode(data),
          );
      jsonResponse = this._returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection !');
    } catch (e) {
      return;
    }
    return jsonResponse;
  }

  Future<dynamic> delete(String url, {Map<String, dynamic>? data}) async {
    String resourceUrl = this.baseUrl + url;
    dynamic jsonResponse;
    Options options = Options(headers: {
      Headers.contentTypeHeader: 'application/json',
    });
    try {
      final response = await this.client.delete(
            resourceUrl,
            options: options,
            data: json.encode(data),
          );
      jsonResponse = this._returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection !');
    }
    return jsonResponse;
  }

  dynamic _returnResponse(Response<dynamic> response) {
    try {
      return this._getResponse(response);
    } on AppException catch (e) {
      if (this.showError) {
        UIHelpers.showSnackbar(
          key: rootScaffoldMessengerKey,
          message: e._message,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          label: 'OK',
          action: () => {},
        );
      }
    }
  }

  dynamic _getResponse(Response<dynamic> response) {
    int? code = response.statusCode;
    if (json.encode(response.data).startsWith('{"status":"error"}')) {
      if (response.statusCode != 401) {
        code = 400;
      }
    }

    switch (code) {
      case 400:
        throw BadRequestException(
          response.data['message'],
        );
      case 401:
        // May be logout here before throwing exception
        throw InvalidTokenException(response.data['message']);
      case 403:
        throw UnauthorisedException(response.data['message']);
      case 500:
      default:
        if (!this._isResponseOk(response.statusCode!)) {
          throw FetchDataException('\n StatusCode : ${response.statusCode}.'
              '\n Response: ${response.data.toString()}');
        }
        var responseJson = response.data;
        return responseJson;
    }
  }

  bool _isResponseOk(int statusCode) {
    return statusCode >= 200 && statusCode <= 299;
  }
}

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidTokenException extends AppException {
  InvalidTokenException([message]) : super(message, "Invalid Token: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
