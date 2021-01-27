import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:common/common.dart';
import 'package:repository/configs.dart';
import 'package:retry/retry.dart';

abstract class BaseCloudFunctions {
  FirebaseFunctions _functions;

  BaseCloudFunctions() {
    _functions = FirebaseFunctions.instance;
    if (Configs().cloudFunctionsEmulatorHost.isNotEmpty) {
      _functions.useFunctionsEmulator(
          origin: Configs().cloudFunctionsEmulatorHost);
    }
  }

  dynamic call(String functionName, {Map<String, Object> params}) async {
    dynamic response;
    try {
      var retryCount = 0;
      response = await retry(
        () async {
          final result =
              await _functions.httpsCallable(functionName).call(params);
          return result.data;
        },
        retryIf: (e) async {
          log.error('Cloud Functions Error: $e');
          if (retryCount == 2) {
            return false;
          }
          if (e is FirebaseFunctionsException) {
            if (e.code == 'resource-exhausted') {
              final waitTime = Random().nextInt(1000);
              await Future.delayed(Duration(milliseconds: waitTime));
              retryCount += 1;
              return true;
            }
          }

          return false;
        },
      );
    } catch (e) {
      log.error('Cloud Functions $functionName Error >> ${e.toString()}');
      rethrow;
    }
    return response;
  }
}
