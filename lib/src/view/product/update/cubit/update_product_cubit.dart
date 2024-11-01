import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';

part 'update_product_state.dart';
part 'update_product_cubit.freezed.dart';

class UpdateProductCubit extends Cubit<UpdateProductState> {

final ProductsRepository _repository;

  UpdateProductCubit({required ProductsRepository repository}): 
  _repository = repository, super(const UpdateProductState.initial());

    Future<void> update(ProductModel product) async {
    emit(const UpdateProductState.loading());
    try {
      final model = ProductModel(
          uid: product.uid,
          name: product.name,
          description: product.description,
          price: product.price,
          photoUrl: product.photoUrl,
          category: product.category
         );
         log(model.uid.toString());
      await _repository.updateProduct(model);
      emit(const UpdateProductState.success());
    } catch (e, s) {
      log('Erro ao atualizar o produto $ProductModel', error: e, stackTrace: s);
      emit(const UpdateProductState.error('Erro ao atualizar o Produto'));
    }
  }

}
