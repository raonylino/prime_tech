import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/core/services/geolocator.dart';
import 'package:prime_pronta_resposta/src/feature/pending/data/model/pending_acept_model.dart';
import 'package:prime_pronta_resposta/src/feature/pending/data/model/pending_model.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_acept_entity.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_entity.dart';

abstract class PendingRemoteDataSource {
  Future<List<PendingEntity>> fetchPendings();
  Future<PendingAceptEntity> acceptPending(int id, BuildContext context);
}

class PendingRemoteDataSourceImpl implements PendingRemoteDataSource {
  final Dio dio;

  PendingRemoteDataSourceImpl(this.dio);

  @override
  Future<List<PendingEntity>> fetchPendings() async {
    final response = await dio.get(
      '/service',
      options: Options(headers: {'Accept': 'application/json'}),
    );

    final List data = response.data['data'];

    final filtered =
        data.where((item) => item['id_service_status'] == 2).toList();

    if (filtered.isEmpty) {
      throw Exception('Nenhum chamado aceito encontrado');
    }

    return filtered
        .map((e) => PendingModel.fromJson(e))
        .toList()
        .cast<PendingEntity>();
  }

  @override
  Future<PendingAceptModel> acceptPending(int id, BuildContext context) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    PendingAceptModel pendingAceptModel;
    final position = await getCurrentLocation(scaffoldMessenger);
    if (position == null) {
      return Future.error('Erro ao obter localização');
    }
    pendingAceptModel = PendingAceptModel(
      id: id.toString(),
      latitude: position.latitude.toString(),
      longitude: position.longitude.toString(),
      dataTime: DateTime.now().toString(),
    );

    final response = await dio.post(
      '/service/accept',
      data: pendingAceptModel.toJson(),
      options: Options(headers: {'Accept': 'application/json'}),
    );

    if (response.data['code'] == 1) {
      return PendingAceptModel.fromJson(response.data);
    } else {
      throw Exception(response.data['message']);
    }
  }
}
