part of 'register_sales_cubit.dart';

@freezed
class RegisterSalesState with _$RegisterSalesState {
  const factory RegisterSalesState.initial() = _Initial;
  const factory RegisterSalesState.loading() = _Loading;
  const factory RegisterSalesState.data({required List<SalesModel> sales}) = _Data;
  const factory RegisterSalesState.error() = _Error; 
}