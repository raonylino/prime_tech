import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/data/model/data_operation_model.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/domain/usecases/data_opereation_usecase.dart';

part 'data_operation_state.dart';

class DataOperationCubit extends Cubit<DataOperationState> {
  final DataOpereationUsecase usecase;

  DataOperationCubit(this.usecase) : super(DataOperationInitial());

  Future<void> sendDataOperations(
    String token,
    DataOperationModel operations,
  ) async {
    emit(DataOperationLoading());
    try {
      final result = await usecase(token, operations);
      emit(DataOperationSuccess(result));
    } catch (e) {
      emit(DataOperationError('Erro: $e'));
    }
  }

  Future<String> getToken() async {
    emit(DataOperationLoading());
    try {
      final token = await usecase.getToken();
      emit(DataOperationTokenSuccess(token));
      return token;
    } catch (e) {
      emit(DataOperationError('Erro: $e'));
      return '';
    }
  }
}
