import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:prime_tech/src/model/sales_model.dart';
import 'package:prime_tech/src/repositories/contacts_repository.dart';

part 'register_sales_state.dart';
part 'register_sales_cubit.freezed.dart';

class RegisterSalesCubit extends Cubit<RegisterSalesState> {

    final ContactsRepository _repository;

  RegisterSalesCubit({required ContactsRepository repository}) :
        _repository = repository,
         super( const RegisterSalesState.initial());
}