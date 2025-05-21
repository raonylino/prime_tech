part of 'accepted_cubit.dart';

@immutable
sealed class AcceptedState {}

final class AcceptedInitial extends AcceptedState {}

final class AcceptedLoading extends AcceptedState {}

final class AcceptedLoaded extends AcceptedState {
  final List<AcceptedEntity> accepted;

  AcceptedLoaded(this.accepted);
}

final class AcceptedError extends AcceptedState {
  final String message;

  AcceptedError(this.message);
}
