import 'package:prime_pronta_resposta/src/feature/operation/data/datasources/operation_remote_datasouces.dart';
import 'package:prime_pronta_resposta/src/feature/operation/domain/entities/operation_entity.dart';

abstract class OperationRepository {
  Future<OperationEntity> fetchOperationById(int id);
}

class OperationRepositoryImpl implements OperationRepository {
  final OperationRemoteDataSource remoteDataSource;

  OperationRepositoryImpl(this.remoteDataSource);

  @override
  Future<OperationEntity> fetchOperationById(int id) {
    return remoteDataSource.fetchOperationById(id);
  }
}
