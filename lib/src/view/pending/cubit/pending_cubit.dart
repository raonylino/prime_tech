import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:meta/meta.dart';
import 'package:prime_pronta_resposta/src/modal/pending_model.dart';

part 'pending_state.dart';

class PendingCubit extends Cubit<PendingState> {
  PendingCubit() : super(PendingInitial());

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String baseUrl = dotenv.env['BASE_URL']!;

  Future<void> fetchPendings() async {
    emit(PendingLoading());
    try {
      final token = await _storage.read(key: 'auth_token');
      if (token == null) {
        emit(PendingError('Token não encontrado'));
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
        final jsonData = json.decode(response.body);
        final List data = jsonData['data'];
        final pendings = data.map((e) => PendingModel.fromJson(e)).toList();
        emit(PendingLoaded(pendings));
      } else {
        emit(PendingError('Erro ao buscar pendentes'));
      }
    } catch (e) {
      emit(PendingError('Erro: $e'));
    }
  }

  PendingModel? _selectedPending;

  void setSelectedPending(PendingModel pending) {
    _selectedPending = pending;
    emit(PendingSelected(pending)); // novo estado opcional, se quiser
  }

  PendingModel? get selectedPending => _selectedPending;
}
