import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';

part 'list_product_state.dart';
part 'list_product_cubit.freezed.dart';

class ListProductCubit extends Cubit<ListProductState> {

  final ProductsRepository _repository;
  
  ListProductCubit({required repository}) : 
  _repository = repository,
  super(const ListProductState.initial());

  Future<void> findAllProducts() async {
    try {
      emit(const ListProductState.loading());
      log('Buscando produtos...');
      final products = await _repository.getAllProducts();
      emit(ListProductState.data(sales: products));

    } catch (e) {
      emit(ListProductState.error(error: e.toString(), string: 'Erro ao buscar produtos'));
      log('Erro ao buscar produtos: $e');

    }
  }

}
