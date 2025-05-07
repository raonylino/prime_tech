import 'package:dio/dio.dart';
import 'package:prime_pronta_resposta/src/view/pending/data/model/pending_model.dart';
import 'package:prime_pronta_resposta/src/view/pending/domain/entities/pending_entity.dart';

abstract class PendingRemoteDataSource {
  Future<List<PendingEntity>> fetchPendings(String token);
}

class PendingRemoteDataSourceImpl implements PendingRemoteDataSource {
  final Dio dio;

  PendingRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PendingEntity>> fetchPendings(String token) async {
    final response = await dio.get(
      '/service',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    final List data = response.data['data'];
    return data
        .map((e) => PendingModel.fromJson(e))
        .toList()
        .cast<PendingEntity>();
  }
}
