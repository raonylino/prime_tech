import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prime_pronta_resposta/src/feature/dateOperation/data/datasources/data_operation_remoto_datasource.dart';
import 'package:prime_pronta_resposta/src/feature/dateOperation/data/model/data_operation_model.dart';

abstract class DataOperationRepository {
  Future<DataOperationModel> sendDataOperations(
    String token,
    DataOperationModel operations,
  );

  Future<String> getToken();
}

class DataOperationRepositoryImpl implements DataOperationRepository {
  final DataOperationRemoteDataSource remoteDataSource;
  final FlutterSecureStorage storage;

  DataOperationRepositoryImpl(this.remoteDataSource, this.storage);
  @override
  Future<DataOperationModel> sendDataOperations(
    String token,
    DataOperationModel operations,
  ) async {
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception('Token não encontrado');
      final response = await remoteDataSource.sendDataOperations(
        token,
        operations,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to send data operations: $e');
    }
  }

  @override
  Future<String> getToken() async {
    try {
      final token = await storage.read(key: 'auth_token');
      if (token == null) throw Exception('Token não encontrado');
      return token;
    } catch (e) {
      throw Exception('Failed to get token: $e');
    }
  }
}
