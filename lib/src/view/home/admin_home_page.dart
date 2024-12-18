import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
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
        automaticallyImplyLeading: false,
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
                    Navigator.pushNamed(context, RoutesAssets.productsRegister);
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
                      Text(
                        'Cadastrar Manutenção',
                        style: TextStyle(
                          fontFamily: TextStyles.instance.primary,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<ListProductCubit>().findAllProducts(),
        child: Column(
          children: [
            Loader<ListProductCubit, ListProductState>(
              selector: (state) {
                return state.maybeWhen(loading: () => true, orElse: () => false);
              },
            ),
            Expanded(
              child: BlocSelector<ListProductCubit, ListProductState, List<ProductModel>>(
                selector: (state) {
                  return state.maybeWhen(
                    data: (products) => products,
                    orElse: () => <ProductModel>[],
                  );
                },
                builder: (context, products) {
                  if (products.isEmpty) {
                    return const Center(child: Text('Nenhum produto encontrado'));
                  }
        
                  return CarouselSlider(
                  options: CarouselOptions(
                    height: screenSize.height * 0.6,
                    autoPlay: true,
                    enlargeCenterPage: true,
                  ),
                  items: products.map((product) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(198, 202, 208, 1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 1,
                                child: Text(product.uid!),
                              ),
                              Image.network(
                                product.photoUrl,
                                width: screenSize.width * 0.7,
                                height: screenSize.height * 0.3,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16),
                              Flexible(
                                child: Text(
                                  'R\$ ${product.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    fontFamily: TextStyles.instance.primary,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: TextStyles.instance.secondary,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                product.description,
                                style: TextStyle(
                                  fontFamily: TextStyles.instance.secondary,
                                  fontSize: 14,
                                  color: Colors.black45,
                                ),
                              ),
                              const Expanded(
                                child: SizedBox(
                                  height: 10,
                                ),
                              ),
                              Container(
                                width: screenSize.width * .8,
                                decoration: BoxDecoration(
                                  gradient: AppColors.gradient,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                  ),
                                  onPressed: () {
                                    log('Editando o produto ${product.uid}');
                                    Navigator.pushReplacementNamed(context, RoutesAssets.productsEdit, arguments: product);
                                  },
                                  child: Text(
                                    'Editar',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontFamily: TextStyles.instance.secondary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}