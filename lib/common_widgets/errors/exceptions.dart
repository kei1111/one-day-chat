import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class Exceptions {
  static String errorMessage(
    dynamic error, {
    String? server,
  }) {
    if (error is TimeoutException) {
      return 'Looks like the server is taking to long to respond.';
    }

    if (error is DioError) {
      if (error.error is SocketException) {
        return error.error.toString().replaceAll("SocketException: ", "");
      }

      final statusCode = error.response?.statusCode;

      switch (statusCode) {
        case 400:
          return 'Looks like you have an unstable network at the moment';
        case 403:
          return 'Forbidden';
        case 404:
          return 'Request page not found';
        default:
          return 'Cannot connect to server${server ?? error.toString().substring(0, error.toString().length < 30 ? error.toString().length : 30)}';
      }
    } else {
      return error.toString().substring(
          0, error.toString().length < 30 ? error.toString().length : 30);
    }
  }

  static int? statusCode(dynamic e) {
    return e is DioError ? e.response?.statusCode : null;
  }
}
