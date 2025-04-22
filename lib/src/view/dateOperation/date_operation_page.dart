import 'package:flutter/material.dart';
import 'package:prime_pronta_resposta/src/constants/app_colors.dart';
import 'package:prime_pronta_resposta/src/constants/app_routers.dart';
import 'package:prime_pronta_resposta/src/constants/app_text_styles.dart';

class DateOperationPage extends StatefulWidget {
  const DateOperationPage({super.key});

  @override
  State<DateOperationPage> createState() => _DateOperationPageState();
}

class _DateOperationPageState extends State<DateOperationPage> {
  final List<String> tiposAtividades = [
    'Manutenção',
    'Inspeção',
    'Reparo',
    'Transporte',
    'Outro',
  ];

  String? atividadeSelecionada;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data da Operação',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontFamily: TextStyles.instance.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRouters.homePage);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Titulo da Ocorrência',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: TextStyles.instance.secondary,
              ),
            ),

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Digite o título da ocorrência',
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.05),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            Text(
              'Descrição da Ocorrência',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: TextStyles.instance.secondary,
              ),
            ),

            TextFormField(
              maxLines: 5,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Digite aqui os detalhes da ocorrência...',
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            Text(
              'Descrição da atividade',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: TextStyles.instance.secondary,
              ),
            ),

            TextFormField(
              maxLines: 5,
              minLines: 3,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: 'Digite aqui os detalhes da atividade...',
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text(
              'Tipo de Atividade',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: TextStyles.instance.secondary,
              ),
            ),
            DropdownButtonFormField<String>(
              value: atividadeSelecionada,
              onChanged: (String? newValue) {
                setState(() {
                  atividadeSelecionada = newValue;
                });
              },
              items:
                  tiposAtividades.map((String atividade) {
                    return DropdownMenuItem<String>(
                      value: atividade,
                      child: Text(
                        atividade,
                        style: TextStyle(
                          fontFamily: TextStyles.instance.secondary,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }).toList(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            Text(
              'Adicionar Fotos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontFamily: TextStyles.instance.secondary,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(AppRouters.galleryPhotoPage);
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 90,
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(5),
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: AppColors.secondaryColor,
                      size: 30,
                    ),
                    Text(
                      'Galeria de Fotos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondaryColor,
                        fontFamily: TextStyles.instance.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).popAndPushNamed(AppRouters.operationPage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 50,
                    ),
                    side: BorderSide(color: Colors.black26, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Voltar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.secondaryColor,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 50,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    'Iniciar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontFamily: TextStyles.instance.secondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
