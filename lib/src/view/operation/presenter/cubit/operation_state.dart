part of 'operation_cubit.dart';

@immutable
abstract class OperationState {}

class OperationInitial extends OperationState {}

class OperationLoading extends OperationState {}

class OperationLoaded extends OperationState {
  final OperationEntity operation;

  OperationLoaded(this.operation);
}

class OperationError extends OperationState {
  final String message;

  OperationError(this.message);
}
