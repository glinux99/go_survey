import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/models/questionnaires/questionnaire.dart';
import 'package:go_survey/models/questionnaires/questionnaire_service.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:material/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
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
        _reponses.add(_rep.toList());
        _rep = [];
      }

      t++;
    }

    // print(questionsList.length);
    print(questionsList.length);
    print(reponsesL.length);
    // print("object");
    print(_questions);
    print(_reponses);
    print(t);
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
    print(_reponses[0].length);
    print('ok');
    print(_questions.length);
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    final String path = (await getApplicationDocumentsDirectory()).path;
    final String fileName = '$path/GoSurvey.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  Widget TableBuild() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: _questions.map((e) => DataColumn(label: Text(e))).toList(),
        rows: _reponses
            .map((reponses) =>
                DataRow(cells: reponses.map((e) => DataCell(Text(e))).toList()))
            .toList(),
      ),
    );
  }
}
