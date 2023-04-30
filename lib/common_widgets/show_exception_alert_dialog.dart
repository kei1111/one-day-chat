import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:himatubu_chat/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(dynamic exception) {
  if (exception is FirebaseException) {
    return exception.message ?? exception.toString();
  }
  if (exception is PlatformException) {
    return exception.message ?? exception.toString();
  }
  return exception.toString();
}
