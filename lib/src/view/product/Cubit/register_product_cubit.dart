import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';

part 'register_product_state.dart';
part 'register_product_cubit.freezed.dart';

class RegisterProductCubit extends Cubit<RegisterProductState> {

    final ProductsRepository _repository;

  RegisterProductCubit({required ProductsRepository repository}) :
        _repository = repository,
         super( const RegisterProductState.initial());
}