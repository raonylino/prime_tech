import 'package:prime_pronta_resposta/src/feature/operation/domain/entities/operation_entity.dart';
import 'package:prime_pronta_resposta/src/feature/operation/domain/repositories/operation_repository.dart';

class FetchOperationByIdUseCase {
  final OperationRepository repository;

  FetchOperationByIdUseCase(this.repository);

  Future<OperationEntity> call(int id) {
    return repository.fetchOperationById(id);
  }
}
