import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/models/pending_model.dart';

part 'operation_state.dart';

class OperationCubit extends Cubit<OperationState> {
  OperationCubit() : super(OperationInitial());

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<void> fetchOperationById(int id) async {
    emit(OperationLoading());
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        emit(OperationError('Token não encontrado'));
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/service'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(response.body);
        final List<dynamic> dataList = decoded['data'];

        final matchingItem = dataList.firstWhere(
          (item) => item['id'] == id,
          orElse: () => null,
        );

        if (matchingItem != null) {
          final operation = PendingModel.fromJson(matchingItem);
          emit(OperationLoaded(operation));
        } else {
          emit(OperationError('Atendimento com ID $id não encontrado'));
        }
      } else {
        print(response.body);
        emit(OperationError('Erro ao buscar operação'));
      }
    } catch (e) {
      print(e);
      emit(OperationError('Erro: $e'));
    }
  }
}
