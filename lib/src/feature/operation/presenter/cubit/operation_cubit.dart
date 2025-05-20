import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/feature/operation/domain/entities/operation_entity.dart';
import 'package:prime_pronta_resposta/src/feature/operation/domain/usecases/fetch_operation_by_id_usecase.dart';

part 'operation_state.dart';

class OperationCubit extends Cubit<OperationState> {
  final FetchOperationByIdUseCase useCase;

  OperationCubit(this.useCase) : super(OperationInitial());

  Future<void> fetchOperationById(int id) async {
    emit(OperationLoading());
    try {
      final operation = await useCase(id);
      emit(OperationLoaded(operation));
    } catch (e) {
      emit(OperationError('Erro: $e'));
    }
  }
}
