// data/datasources/operation_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/feature/operation/data/model/operation_model.dart';

abstract class OperationRemoteDataSource {
  Future<OperationModel> fetchOperationById(int id);
}

class OperationRemoteDataSourceImpl implements OperationRemoteDataSource {
  final Dio dio;
  final FlutterSecureStorage storage;

  OperationRemoteDataSourceImpl(this.dio, this.storage);

  @override
  Future<OperationModel> fetchOperationById(int id) async {
    final token = await storage.read(key: 'auth_token');
    final response = await dio.get(
      '${AppEndpoints.apiBase}/service',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    final data = response.data['data'] as List;
    final operationJson = data.firstWhere(
      (item) => item['id'] == id,
      orElse: () => null,
    );

    if (operationJson != null) {
      return OperationModel.fromJson(operationJson);
    } else {
      throw Exception('Operação com ID $id não encontrada');
    }
  }
}
