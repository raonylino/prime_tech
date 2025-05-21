import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/domain/entities/accepted_entity.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/domain/usecases/accepted_usecase.dart';

part 'accepted_state.dart';

class AcceptedCubit extends Cubit<AcceptedState> {
  final AcceptedUsecase fetchAcceptedUseCase;
  AcceptedCubit(this.fetchAcceptedUseCase) : super(AcceptedInitial());
  Future<void> fetchAccepted() async {
    emit(AcceptedLoading());
    try {
      final accepted = await fetchAcceptedUseCase();
      emit(AcceptedLoaded(accepted));
    } catch (e) {
      emit(AcceptedError('Erro: $e'));
    }
  }
}
