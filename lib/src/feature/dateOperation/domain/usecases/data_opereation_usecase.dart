import 'package:prime_pronta_resposta/src/feature/dateOperation/data/model/data_operation_model.dart';
import 'package:prime_pronta_resposta/src/feature/dateOperation/domain/repositories/data_operation_repository.dart';

class DataOpereationUsecase {
  final DataOperationRepository _repository;
  DataOpereationUsecase(this._repository);

  Future<DataOperationModel> call(
    String token,
    DataOperationModel operations,
  ) async {
    return await _repository.sendDataOperations(token, operations);
  }

  Future<String> getToken() async {
    return await _repository.getToken();
  }
}
