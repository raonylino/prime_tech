import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prime_pronta_resposta/src/feature/pending/data/datasources/pending_datasource.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_entity.dart';

abstract class PendingRepository {
  Future<List<PendingEntity>> fetchPendings();
}

class PendingRepositoryImpl implements PendingRepository {
  final PendingRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage;

  PendingRepositoryImpl(this.remoteDataSource, this.storage);

  @override
  Future<List<PendingEntity>> fetchPendings() async {
    final token = await storage.read(key: 'auth_token');
    if (token == null) throw Exception('Token não encontrado');
    return await remoteDataSource.fetchPendings(token);
  }
}
