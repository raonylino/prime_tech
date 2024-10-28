import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/view/home/cubit/list_product_cubit.dart';
import 'package:prime_tech/src/widgets/loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: screenSize.width,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  blurStyle: BlurStyle.normal,
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(6, 6),
                ),
              ],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/pc_top.jpg'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            child: Image.asset(
              'assets/images/primeTech.png',
              fit: BoxFit.contain,
            ),
          ),
          Loader<ListProductCubit, ListProductState>(
            selector: (state) {
              return state.maybeWhen(loading: () => true, orElse: () => false);
            },
          ),
          Expanded(
            child: BlocSelector<ListProductCubit, ListProductState,
                List<ProductModel>>(
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
                              Image.network(
                                product.photoUrl,
                                width: screenSize.width * 0.7,
                                height: screenSize.height * 0.3,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'R\$ ${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontFamily: TextStyles.instance.primary,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
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
                                  onPressed: () {},
                                  child: Text(
                                    'Comprar',
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
    );
  }
}
