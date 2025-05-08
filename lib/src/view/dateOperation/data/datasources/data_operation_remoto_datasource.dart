import 'package:dio/dio.dart';
import 'package:prime_pronta_resposta/src/core/endpoints/app_endpoints.dart';
import 'package:prime_pronta_resposta/src/view/dateOperation/data/model/data_operation_model.dart';

abstract class DataOperationRemoteDataSource {
  Future<DataOperationModel> sendDataOperations(
    String token,
    DataOperationModel operations,
  );
}

class DataOperationRemoteDataSourceImpl
    implements DataOperationRemoteDataSource {
  final Dio dio;

  DataOperationRemoteDataSourceImpl(this.dio);

  @override
  Future<DataOperationModel> sendDataOperations(
    String token,
    DataOperationModel operations,
  ) async {
    try {
      final response = await dio.post(
        AppEndpoints.dataOperation,
        data: operations.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List data = response.data['data'];
        return DataOperationModel.fromJson(data.first);
      } else {
        throw Exception('Erro ao enviar operações: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao enviar operações: $e');
    }
  }
}
