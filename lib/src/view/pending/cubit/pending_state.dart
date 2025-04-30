part of 'pending_cubit.dart';

@immutable
sealed class PendingState {}

final class PendingInitial extends PendingState {}

final class PendingLoading extends PendingState {}

final class PendingLoaded extends PendingState {
  final List<PendingModel> pendings;
  PendingLoaded(this.pendings);
}

final class PendingError extends PendingState {
  final String message;
  PendingError(this.message);
}

class PendingSelected extends PendingState {
  final PendingModel selected;

  PendingSelected(this.selected);
}
