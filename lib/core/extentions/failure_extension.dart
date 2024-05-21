// Project imports:
import 'package:maids_task/core/api/failure.dart';

extension FailureExtension on Failure {
  bool get isSuccess => failureType == FailureType.none;
}
