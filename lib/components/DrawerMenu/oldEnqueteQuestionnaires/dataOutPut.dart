import 'dart:io';

import 'package:dio/dio.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire_service.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:material/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class DataOutPut extends StatefulWidget {
  const DataOutPut({super.key, required this.rubriqueId});

  final int rubriqueId;

  @override
  State<DataOutPut> createState() => _DataOutPutState();
}

class _DataOutPutState extends State<DataOutPut> {
  bool lecture = false;
  final Dio dio = Dio();

  Future<void> createExcel() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    for (var i = 0; i < _questions.length; i++) {
      // sheet.getRangeByName('A1').setText(_questions[i].toString());
      sheet.getRangeByIndex(1, i + 1).setText(_questions[i].toString());
    }
    for (var i = 0; i < _reponses.length; i++) {
      for (var y = 0; y < _reponses[i].length; y++) {
        sheet.getRangeByIndex(i + 2, y + 1).setText(_reponses[i][y].toString());
      }
    }
    // print(_reponses[0].length);
    print('ok');
    print(_questions.length);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    Directory? directory;
    String monDossier = "";
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          // print(directory!.path);

          List<String> dossiers = directory!.path.split('/');
          for (var i = 0; i < dossiers.length; i++) {
            String dossier = dossiers[i];
            if (dossier != "Android") {
              monDossier += "/" + dossier;
            } else {
              break;
            }
          }
          monDossier = monDossier + "/GoSurvey";
          print(monDossier);
          directory = Directory(monDossier);
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        }
      }
      if (!await directory!.exists()) {
        directory.create(recursive: true);
      }
      if (await directory.exists()) {
        final String path = monDossier;
        final String fileName = '$path/GoSurvey.xlsx';
        File saveFile = File("${directory.path}/$fileName");
        final File file = File(fileName);
        await file.writeAsBytes(bytes, flush: true);
        OpenFile.open(fileName);

        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
      } else
        createExcel();
    } catch (e) {}
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  downloadFile() async {
    setState(() {
      lecture = true;
    });

    setState(() {
      lecture = false;
    });
  }

  List<List<String>> _reponses = [];
  List<String> _questions = [];
  late List<QuestionnaireModel> questionsList;
  late List<ReponsesModel> reponsesL;
  final _questionnaireService = QuestionnaireService();
  var _reponseService = ReponseService();
  getRubriques() async {
    var rubriques = await _questionnaireService
        .getQuestionByIdRubrique(widget.rubriqueId! + 1);
    rubriques.forEach((rub) {
      setState(() {
        var rubriqueModel = QuestionnaireModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.typeReponse = rub['typeReponse'];
        rubriqueModel.question = rub['question'];
        rubriqueModel.userId = rub['userId'];
        rubriqueModel.rubriqueId = rub['rubriqueId'];
        questionsList.add(rubriqueModel);
      });
    });
    questionsList.forEach((element) {
      _questions.add(element.question.toString());
    });
    // print(rubriques);
  }

  getReponses() async {
    var rubriques =
        await _reponseService.getReponsesByRubriqueId(widget.rubriqueId + 1);
    rubriques.forEach((rub) {
      var rubriqueModel = ReponsesModel();
      rubriqueModel.id = rub['id'];
      rubriqueModel.reponse = rub['reponse'];
      rubriqueModel.userId = rub['userId'];
      rubriqueModel.questionId = rub['questionId'];
      rubriqueModel.rubriqueId = rub['rubriqueId'];
      reponsesL.add(rubriqueModel);
      // print(reponsesL2.length);
    });
    // print(questionsList.length);
    List<String> _rep = [];
    var t = 0;
    for (var i = 0, y = 1; i < reponsesL.length; i++, y++) {
      _rep.add(reponsesL[i].reponse.toString());
      if (y % questionsList.length == 0) {
        setState(() {
          _reponses.add(_rep.toList());
          _rep = [];
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    questionsList = <QuestionnaireModel>[];
    reponsesL = <ReponsesModel>[];
    getRubriques();
    getReponses();
    super.initState();
  }

  Widget TableBuild() {
    if (_questions.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: Text(
          "Ce rubrique ne possede pas de questionnaire pour l'instant",
          textAlign: TextAlign.center,
        )),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: _questions.map((e) => DataColumn(label: Text(e))).toList(),
          rows: _reponses
              .map((reponses) => DataRow(
                  cells: reponses.map((e) => DataCell(Text(e))).toList()))
              .toList(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _question = ['first Name', 'Last Name'];
    final _reponse = [
      ['Daniel', 'kikimba'],
      ['Daniel', 'kikimba'],
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Rsultat de l'enquete"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: createExcel,
              icon: Icon(FontAwesomeIcons.solidFileExcel))
        ],
      ),
      body: TableBuild(),
    ));
  }
}
