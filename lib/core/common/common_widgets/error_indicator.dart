// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maids_task/core/common/common_package_assets.dart';
import 'package:maids_task/core/api/failure.dart';
import 'package:maids_task/core/constants/color_constants.dart';
import 'package:maids_task/core/extentions/widget_extensions.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key, this.failure, this.customErrorMessage});

  final Failure? failure;
  final String? customErrorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: warningDefault,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              color: textInverse,
            ).padding(right: 10),
            Flexible(
              child: Text(
                _getFailureMessage(),
                style: const TextStyle(fontSize: 12, color: textInverse),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFailureMessage() {
    if (customErrorMessage != null) {
      return customErrorMessage!;
    }

    final message = switch (failure) {
      (ExceptionFailure f)
          when f.additionalData != null && f.additionalData != '' =>
        f.additionalData.toString(),
      (ExceptionFailure f) when f.additionalData == null =>
        f.exception.toString(),
      (GeneralFailure f) when f.failureType == FailureType.customMessage =>
        f.additionalData,
      (GeneralFailure f) when f.failureType == FailureType.networkUnavailable =>
        "Network Unavailable",
      (GeneralFailure f) when f.failureType == FailureType.missingData =>
        'Missing ${f.additionalData} data',
      (GeneralFailure f)
          when f.failureType == FailureType.invalidLoginCredentials =>
        'Incorrect email or password',
      (GeneralFailure f) when f.failureType == FailureType.httpStatus =>
        _getHttpStatusError(f.additionalData),
      (GeneralFailure f) when f.failureType == FailureType.invalidQRCode =>
        "Invalid QR Code Key",
      (GeneralFailure f) when f.failureType == FailureType.timeout =>
        "Operation Time Out",
      _ => "Network Error",
    };
    return message;
  }

  String _getHttpStatusError(dynamic additionalData) {
    final map = additionalData as Map<String, dynamic>;
    final code = map['code'];
    final api = map['api'];
    if (code != null && api != null) {
      return 'Invalid HTTP Status code ($code) received from $api';
    }
    return '';
  }
}
