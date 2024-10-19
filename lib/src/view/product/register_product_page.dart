import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prime_tech/src/constants/app_colors.dart';
import 'package:prime_tech/src/constants/app_text_styles.dart';
import 'package:prime_tech/src/constants/routes_assets.dart';
import 'package:prime_tech/src/model/product_model.dart';
import 'package:prime_tech/src/repositories/products_repository.dart';
import 'package:validatorless/validatorless.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key});

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  final formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _descriptionEC = TextEditingController();
  final _priceEC = TextEditingController();
  final _categoryEC = TextEditingController();
  final _photoUrlEC = TextEditingController();

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
    final ImagePicker _picker = ImagePicker();
    XFile? _image;

    Future<void> _pickImage() async {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile;
          _photoUrlEC.text = pickedFile.path; // Set the path in the text field
        });
      }
    }

    return SafeArea(
      top: false,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: CustomScrollView(
            physics: const ScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
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
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Cadastre seu produto',
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        fontFamily: TextStyles.instance.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _nameEC,
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
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _descriptionEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('descrição obrigatório'),
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
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _categoryEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('categoria obrigatória'),
                        ]),
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
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: TextFormField(
                        controller: _priceEC,
                        validator: Validatorless.multiple([
                          Validatorless.required('preço obrigatório'),
                        ]),
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
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black.withOpacity(0.1),
                              width: 2.0,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: screenSize.width * .8,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: AbsorbPointer(
                          absorbing: true, 
                          child: TextFormField(
                            controller: _photoUrlEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('Imagem obrigatória'),
                            ]),
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
                              enabledBorder:const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.1),
                                  width: 2.0,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_image != null)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.file(File(_image!.path)),
                      ),
                    const Expanded(
                        child: SizedBox(
                      height: 30,
                    )),
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
                              Navigator.of(context)
                                  .popAndPushNamed(RoutesAssets.admTabView);
                            },
                            child: Text(
                              'Voltar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: TextStyles.instance.secondary,
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
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                final product = ProductModel(
                                  name: _nameEC.text,
                                  description: _descriptionEC.text,
                                  price: double.parse(_priceEC.text).toInt(),
                                  photoUrl: _photoUrlEC.text, 
                                  category: _categoryEC.text,
                                );

                                await ProductsRepository().addProduct(product);

                                // ignore: use_build_context_synchronously
                                Navigator.of(context)
                                    .popAndPushNamed(RoutesAssets.admTabView);
                              }
                            },
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: TextStyles.instance.secondary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
