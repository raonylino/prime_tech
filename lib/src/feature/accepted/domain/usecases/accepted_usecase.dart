import 'package:prime_pronta_resposta/src/feature/accepted/domain/entities/accepted_entity.dart';
import 'package:prime_pronta_resposta/src/feature/accepted/domain/repositories/accepted_repository.dart';

class AcceptedUsecase {
  final AcceptedRepository _repository;
  AcceptedUsecase(this._repository);

  Future<List<AcceptedEntity>> call() async {
    return await _repository.fetchAccepted();
  }
}
