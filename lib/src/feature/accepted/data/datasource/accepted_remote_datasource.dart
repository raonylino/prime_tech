import 'package:dio/dio.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/data/model/accepted_model.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/domain/entities/accepted_entity.dart';

abstract class AcceptedRemoteDatasource {
  Future<List<AcceptedEntity>> fetchAccepted();
}

class AcceptedRemoteDatasourceImpl implements AcceptedRemoteDatasource {
  final Dio dio;
  AcceptedRemoteDatasourceImpl(this.dio);
  @override
  Future<List<AcceptedEntity>> fetchAccepted() async {
    final response = await dio.get(
      '/service',
      options: Options(headers: {'Accept': 'application/json'}),
    );

    final List data = response.data['data'];

    final filtered =
        data.where((item) => item['id_service_status'] == 3).toList();

    if (filtered.isEmpty) {
      throw Exception('Nenhum chamado aceito encontrado');
    }

    return filtered
        .map((e) => AcceptedModel.fromJson(e))
        .toList()
        .cast<AcceptedEntity>();
  }
}
