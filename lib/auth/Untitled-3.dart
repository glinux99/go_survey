import 'package:flutter/material.dart';
import 'package:go_survey/models/reponses/reponse_service.dart';
import 'package:go_survey/models/reponses/reponses.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataOutPut extends StatefulWidget {
  const DataOutPut({super.key});

  @override
  State<DataOutPut> createState() => _DataOutPutState();
}

class _DataOutPutState extends State<DataOutPut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ReponseExport(),
    ));
  }
}

class ReponseExport extends StatefulWidget {
  const ReponseExport({super.key});

  @override
  State<ReponseExport> createState() => _ReponseExportState();
}

class _ReponseExportState extends State<ReponseExport> {
  List<ReponsesModel> reponses = <ReponsesModel>[];
  late List<ReponsesModel> reponsesL;
  late ReponsesDataSource reponsesDataSource;
  var _reponseService = ReponseService();
  @override
  @override
  void initState() {
    super.initState();
    reponsesL = <ReponsesModel>[];
    getReponses();
    reponsesDataSource = ReponsesDataSource(reponsesData: reponsesL);
  }

  getReponses() async {
    var rubriques = await _reponseService.getAllReponse();
    rubriques.forEach((rub) {
      setState(() {
        var rubriqueModel = ReponsesModel();
        rubriqueModel.id = rub['id'];
        rubriqueModel.reponse = rub['reponse'];
        rubriqueModel.userId = rub['userId'];
        rubriqueModel.rubriqueId = rub['rubriqueId'];
        reponsesL.add(rubriqueModel);
      });

      // print(reponsesL[1].reponse);
    });
    // print(rubriques);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DataGrid"),
      ),
      body: SfDataGrid(
        source: reponsesDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
              columnName: 'id',
              label: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                child: Text('ID'),
              )),
        ],
      ),
    );
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the employee which will be rendered in datagrid.
class Employee {
  /// Creates the employee class with required details.
  Employee(this.id, this.name, this.designation, this.salary);

  /// Id of an employee.
  final int id;

  /// Name of an employee.
  final String name;

  /// Designation of an employee.
  final String designation;

  /// Salary of an employee.
  final int salary;
}

/// An object to set the employee collection data source to the datagrid. This
/// is used to map the employee data to the datagrid widget.
///
///
class ReponsesDataSource extends DataGridSource {
  ReponsesDataSource({required List<ReponsesModel> reponsesData}) {
    _reponsesData = reponsesData
        .map((e) => DataGridRow(
            cells: [DataGridCell<int>(columnName: 'id', value: e.id)]))
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

// class EmployeeDataSource extends DataGridSource {
//   /// Creates the employee data source class with required details.
//   EmployeeDataSource({required List<Employee> employeeData}) {
//     _employeeData = employeeData
//         .map<DataGridRow>((e) => DataGridRow(cells: [
//               DataGridCell<int>(columnName: 'id', value: e.id),
//               DataGridCell<String>(columnName: 'name', value: e.name),
//               DataGridCell<String>(
//                   columnName: 'designation', value: e.designation),
//               DataGridCell<int>(columnName: 'salary', value: e.salary),
//             ]))
//         .toList();
//   }

//   List<DataGridRow> _employeeData = [];

//   @override
//   List<DataGridRow> get rows => _employeeData;

//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//         cells: row.getCells().map<Widget>((e) {
//       return Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(8.0),
//         child: Text(e.value.toString()),
//       );
//     }).toList());
//   }
// }
