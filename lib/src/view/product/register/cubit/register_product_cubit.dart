import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';

part 'register_product_state.dart';
part 'register_product_cubit.freezed.dart';

class RegisterProductCubit extends Cubit<RegisterProductState> {
  final ProductsRepository _repository;

  RegisterProductCubit({required ProductsRepository repository})
      : _repository = repository,
        super(const RegisterProductState.initial());

  Future<void> addProduct(ProductModel product) async {
    emit(const RegisterProductState.loading());
    try {
      await _repository.addProduct(product);
      emit(const RegisterProductState.success());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(RegisterProductState.error(e.toString(),
          error: 'Erro ao registrar o produto'));
    }
  }
}
