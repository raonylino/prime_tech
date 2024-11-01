// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prime_tech/src/widgets/loader.dart';
import 'package:validatorless/validatorless.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/view/product/update/cubit/update_product_cubit.dart';

class UpdateProductPage extends StatefulWidget {
  final ProductModel product;
  const UpdateProductPage({
    super.key,
    required this.product,
  });

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController _nameEC;
  late final TextEditingController _descriptionEC;
  late final TextEditingController _priceEC;
  late final TextEditingController _categoryEC;
  late final TextEditingController _photoUrlEC;
  late final TextEditingController _uidEC;


  @override
  void initState() {
    super.initState();
    _nameEC = TextEditingController(text: widget.product.name);
    _descriptionEC = TextEditingController(text: widget.product.description);
    _priceEC = TextEditingController(text: widget.product.price.toString());
    _categoryEC = TextEditingController(text: widget.product.category);
    _photoUrlEC = TextEditingController(text: widget.product.photoUrl);
    _uidEC = TextEditingController(text: widget.product.uid);

  }

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _descriptionEC.dispose();
    _priceEC.dispose();
    _categoryEC.dispose();
    _photoUrlEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final ImagePicker picker = ImagePicker();
    XFile? image;

    Future<void> pickImage() async {
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          image = pickedFile;
          _photoUrlEC.text = pickedFile.path; // Set the path in the text field
        });
      }
    }

  return SafeArea(
  top: false,
  child: Scaffold(
    body: CustomScrollView(
      physics: const ScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              Loader<UpdateProductCubit, UpdateProductState>(
                selector: (state) => state.maybeWhen(
                  loading: () => true,
                  orElse: () => false,
                ),
              ),
              BlocListener<UpdateProductCubit, UpdateProductState>(
                listener: (context, state) {
                  state.whenOrNull(
                    success: () {
                      Navigator.of(context).pop();
                    },
                    error: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            message,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                },
                child: Form(
                  key: formKey,
                  child: Column(
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
                      const SizedBox(height: 50),
                      Text(
                        'Altere seu produto',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          fontFamily: TextStyles.instance.primary,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Preencha os campos abaixo para cadastrar um produto para venda',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontFamily: TextStyles.instance.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: screenSize.width * .8,
                        child: TextFormField(
                          controller: _uidEC,
                          validator: Validatorless.required('Nome obrigatório'),
                          decoration: InputDecoration(
                            hintText: 'Nome do produto',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.1),
                            prefixIcon: const Icon(Icons.sell),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: screenSize.width * .8,
                        child: TextFormField(
                          controller: _descriptionEC,
                          validator: Validatorless.multiple([
                            Validatorless.required('descrição obrigatória'),
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Descrição',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.1),
                            prefixIcon: const Icon(Icons.text_snippet_rounded),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: screenSize.width * .8,
                        child: TextFormField(
                          controller: _categoryEC,
                          validator: Validatorless.required('categoria obrigatória'),
                          decoration: InputDecoration(
                            hintText: 'Categoria',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.1),
                            prefixIcon: const Icon(Icons.category_rounded),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: screenSize.width * .8,
                        child: TextFormField(
                          controller: _priceEC,
                          validator: Validatorless.required('preço obrigatório'),
                          decoration: InputDecoration(
                            hintText: 'Preço',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: TextStyles.instance.secondary,
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.1),
                            prefixIcon: const Icon(Icons.attach_money),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
                              borderRadius: const BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: screenSize.width * .8,
                        child: GestureDetector(
                          onTap: pickImage,
                          child: AbsorbPointer(
                            absorbing: true,
                            child: TextFormField(
                              controller: _photoUrlEC,
                              validator: Validatorless.required('Imagem obrigatória'),
                              decoration: InputDecoration(
                                hintText: 'Imagem',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: TextStyles.instance.secondary,
                                ),
                                filled: true,
                                fillColor: Colors.black.withOpacity(0.1),
                                prefixIcon: const Icon(Icons.camera_alt_rounded),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (image != null)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.file(File(image!.path)),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenSize.width * .4,
                    decoration: BoxDecoration(
                      gradient: AppColors.gradientGrey,
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
                        Navigator.of(context).popAndPushNamed(RoutesAssets.admTabView);
                      },
                      child: Text(
                        'Voltar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: TextStyles.instance.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenSize.width * .4,
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
                        if (formKey.currentState?.validate() ?? false) {
                          final updateProductDTO = ProductModel(
                            uid: widget.product.uid,
                            name: _nameEC.text,
                            description: _descriptionEC.text,
                            price: _priceEC.text != '' ? int.parse(_priceEC.text) : 0,
                            category: _categoryEC.text,
                            photoUrl: _photoUrlEC.text,
                          );
                          context.read<UpdateProductCubit>().update(updateProductDTO);
                        }
                      },
                      child: Text(
                        'Alterar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: TextStyles.instance.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ],
    ),
  ),
);

  }
}
