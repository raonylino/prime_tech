import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/view/pending/data/model/pending_model.dart';
import 'package:prime_pronta_resposta/src/view/pending/domain/entities/pending_entity.dart';
import 'package:prime_pronta_resposta/src/view/pending/domain/usecases/pending_usecase.dart';

part 'pending_state.dart';

class PendingCubit extends Cubit<PendingState> {
  final PendingUsecase fetchPendingUseCase;

  PendingCubit(this.fetchPendingUseCase) : super(PendingInitial());

  Future<void> fetchPendings() async {
    emit(PendingLoading());
    try {
      final pendings = await fetchPendingUseCase();
      emit(PendingLoaded(pendings.cast<PendingModel>()));
    } catch (e) {
      emit(PendingError('Erro: $e'));
    }
  }

  PendingEntity? _selectedPending;

  void setSelectedPending(PendingEntity pending) {
    _selectedPending = pending;
    emit(PendingSelected(pending as PendingModel));
  }

  PendingEntity? get selectedPending => _selectedPending;
}
