import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/feature/pending/data/datasources/pending_datasource.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_entity.dart';

abstract class PendingRepository {
  Future<List<PendingEntity>> fetchPendings();
  Future<void> acceptPending(int id, BuildContext context);
}

class PendingRepositoryImpl implements PendingRepository {
  final PendingRemoteDataSource remoteDataSource;


  PendingRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<PendingEntity>> fetchPendings() async {
    return await remoteDataSource.fetchPendings();
  }

  @override
  Future<void> acceptPending(int id, BuildContext context) async {
     await remoteDataSource.acceptPending(id, context);
  }
}
