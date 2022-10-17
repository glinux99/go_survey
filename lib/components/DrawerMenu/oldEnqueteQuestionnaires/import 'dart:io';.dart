import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:material/material.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'save_file_mobile_desktop.dart'
    if (dart.library.html) 'helper/save_file_web.dart' as helper;

class DataOutPut extends StatefulWidget {
  const DataOutPut({super.key, required this.rubriqueId});

  final int rubriqueId;

  @override
  State<DataOutPut> createState() => _DataOutPutState();
}

class _DataOutPutState extends State<DataOutPut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: BodyOutput(rubriqueId: widget.rubriqueId),
    ));
  }
}

/// The home page of the application which hosts the datagrid.
class BodyOutput extends StatefulWidget {
  /// Creates the home page.
  BodyOutput({Key? key, required this.rubriqueId}) : super(key: key);

  final int rubriqueId;

  @override
  _BodyOutputState createState() => _BodyOutputState();
}

class _BodyOutputState extends State<BodyOutput> {
  late ReponseModelDataSource reponseDataSource;
  List<ReponseModel> reponses = <ReponseModel>[];
  late List<ReponseModel> reponsesL;
  late List<ReponsesModel> reponsesL2;

  final GlobalKey<SfDataGridState> _key = GlobalKey<SfDataGridState>();
  var _reponseService = ReponseService();

  getReponses() async {
    var rubriques =
        await _reponseService.getReponsesByRubriqueId(widget.rubriqueId + 1);
    rubriques.forEach((rub) {
      var rubriqueModel = ReponsesModel();
      setState(() {
        rubriqueModel.id = rub['id'];
        rubriqueModel.reponse = rub['reponse'];
        rubriqueModel.userId = rub['userId'];
        rubriqueModel.rubriqueId = rub['rubriqueId'];
      });
      reponsesL2.add(rubriqueModel);
      // print(reponsesL2.length);
    });
    reponses = getReponseModelData(reponsesL2);
    reponseDataSource = ReponseModelDataSource(reponseData: reponses);
    // print(rubriques);
  }

  List<ReponseModel> getReponseModelData(List<ReponsesModel> i) {
    i.forEach((element) {
      reponsesL.add(ReponseModel(element.id!, element.reponse.toString()));
    });
    return reponsesL;
  }

  void initState() {
    reponsesL = <ReponseModel>[];
    reponsesL2 = [];
    super.initState();
    reponses = getReponseModelData(reponsesL2);
    reponseDataSource = ReponseModelDataSource(reponseData: reponses);
    getReponses();
  }

  Future<void> exportDataGridToExcel() async {
    final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    await helper.saveAndLaunchFile(bytes, 'DataGrid.xlsx');
  }

  Future<void> excelExport() async {
    // final excel = Excel.createExcel();
    // final sheet = excel.sheets[excel.getDefaultSheet() as String];
    // sheet!.setColWidth(2, 50);
    // sheet.setColAutoFit(3);
    // sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 3)).value =
    //     "COOL";
    // excel.save();
    // print('cccc');
    // final Workbook workbook = _key.currentState!.exportToExcelWorkbook();
    // ;
    // final List<int> bytes = workbook.saveAsStream();
    // workbook.dispose();
    // final String path = (await getApplicationSupportDirectory()).path;
    // final String fileName = '$path/goSurvey.xlsx';
    // final File file = File(fileName);
    // await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open(fileName);
    // final Workbook workbook = Workbook();
    // final Worksheet sheet = workbook.worksheets[0];
    // final List<int> bytes = workbook.saveAsStream();

    // final String path = (await getApplicationSupportDirectory()).path;
    // final String fileName = '$path/Output.xlsx';
    // final File file = File(fileName);
    // await file.writeAsBytes(bytes, flush: true);
    // OpenFile.open(fileName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resulat de l\enquete'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: excelExport, icon: Icon(FontAwesomeIcons.solidFilePdf))
        ],
      ),
      body: SfDataGrid(
        key: _key,
        source: reponseDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        selectionMode: SelectionMode.multiple,
        navigationMode: GridNavigationMode.cell,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'ID',
                  ))),
          GridColumn(
              columnName: 'reponse',
              label: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Reponse',
                  ))),
        ],
      ),
    );
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the reponse which will be rendered in datagrid.
class ReponseModel {
  /// Creates the reponse class with required details.
  ReponseModel(this.id, this.reponse);

  /// Id of an reponse.
  final int id;

  /// Name of an reponse.
  final String reponse;
}

/// An object to set the reponse collection data source to the datagrid. This
/// is used to map the reponse data to the datagrid widget.
///
///
class ReponsesDataSource extends DataGridSource {
  ReponsesDataSource({required List<ReponseModel> reponsesData}) {
    _reponsesData = reponsesData
        .map((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'reponse', value: e.reponse),
            ]))
        .toList();
  }

  List<DataGridRow> _reponsesData = [];

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }
}

class ReponseModelDataSource extends DataGridSource {
  /// Creates the reponse data source class with required details.
  ReponseModelDataSource({required List<ReponseModel> reponseData}) {
    _reponseData = reponseData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'reponse', value: e.reponse),
            ]))
        .toList();
    print(_reponseData);
  }

  List<DataGridRow> _reponseData = [];

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  List<DataGridRow> get rows => _reponseData;
}
