part of 'data_operation_cubit.dart';

@immutable
sealed class DataOperationState {}

final class DataOperationInitial extends DataOperationState {}

final class DataOperationLoading extends DataOperationState {}

final class DataOperationSuccess extends DataOperationState {
  final DataOperationModel operations;

  DataOperationSuccess(this.operations);
}

final class DataOperationTokenSuccess extends DataOperationState {
  final String token;

  DataOperationTokenSuccess(this.token);
}

final class DataOperationError extends DataOperationState {
  final String message;

  DataOperationError(this.message);
  @override
  String toString() => 'DataOperationError: $message';
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataOperationError &&
          runtimeType == other.runtimeType &&
          message == other.message;
  @override
  int get hashCode => message.hashCode;
}
