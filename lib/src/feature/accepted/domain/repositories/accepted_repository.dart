import 'package:prime_pronta_resposta/src/feature/accepted/data/datasource/accepted_remote_datasource.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/domain/entities/accepted_entity.dart';

abstract class AcceptedRepository {
  Future<List<AcceptedEntity>> fetchAccepted();
}

class AcceptedRepositoryImpl implements AcceptedRepository {
  final AcceptedRemoteDatasource remoteDataSource;

  AcceptedRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<AcceptedEntity>> fetchAccepted() async {
    return await remoteDataSource.fetchAccepted();
  }
}
