import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/entities/pending_entity.dart';
import 'package:prime_pronta_resposta/src/feature/pending/domain/repositories/pending_repository.dart';

class PendingUsecase {
  final PendingRepository _repository;

  PendingUsecase(this._repository);

  Future<List<PendingEntity>> call() async {
    return await _repository.fetchPendings();
  }

  Future<void> acceptPending(int id, BuildContext context) async {
    return await _repository.acceptPending(id, context);
  }
}
