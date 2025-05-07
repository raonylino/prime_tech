part of 'operation_cubit.dart';

@immutable
sealed class OperationState {}

final class OperationInitial extends OperationState {}

final class OperationLoading extends OperationState {}

final class OperationLoaded extends OperationState {
  final PendingModel2 operation;

  OperationLoaded(this.operation);
}

final class OperationError extends OperationState {
  final String message;

  OperationError(this.message);
}

final class OperationSuccess extends OperationState {}
