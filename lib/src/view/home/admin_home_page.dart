import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/view/home/cubit/list_product_cubit.dart';
import 'package:prime_tech/src/widgets/loader.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

enum PopupMenuPages { product, maintenance }

class _AdminHomePageState extends State<AdminHomePage> {
  bool iconAction = true;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Administrador',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: TextStyles.instance.secondary,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        actions: [
          PopupMenuButton<PopupMenuPages>(
              icon: Icon(
                iconAction ? Icons.menu : Icons.menu_open_outlined,
                color: Colors.white,
              ),
              color: Colors.white,
              popUpAnimationStyle: AnimationStyle(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              ),
              offset: const Offset(2, 50),
              onOpened: () => setState(() => iconAction = !iconAction),
              onCanceled: () => setState(() => iconAction = !iconAction),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: PopupMenuPages.product,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text(
                          'Cadastrar Produtos',
                          style: TextStyle(
                            fontFamily: TextStyles.instance.primary,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                          context, RoutesAssets.producstRegister);
                    },
                  ),
                  PopupMenuItem(
                    value: PopupMenuPages.maintenance,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Text('Cadastrar Manutenção',
                            style: TextStyle(
                              fontFamily: TextStyles.instance.primary,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                ];
              })
        ],
      ),
      body: Column(
        children: [
          Loader<ListProductCubit,ListProductState>(selector: (state) {
            return state.maybeWhen(loading: () => true, orElse: () => false);
          }),
          BlocSelector<ListProductCubit,ListProductState,List<ProductModel>>(
            selector: (state) {
              return state.maybeWhen(
                  data: (products) => products, 
                  orElse: () => <ProductModel>[]);
            },
            builder: (context, products) {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(51, 80, 241, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(198, 202, 208, 1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                      onLongPress: () {},
                      onTap: () async {},
                      title: Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Poppins',
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text(
                        product.description,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
