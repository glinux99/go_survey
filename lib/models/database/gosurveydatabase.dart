import 'package:go_survey/models/questionnaire.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GoSruveyDataBase {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'gosurvey.db');
    var database =
        await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }

  Future<void> _createDatabase(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolTYpe = "BOOLEAN NOT NULL";
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $questionnaires(
  ${QuestionnaireFields.id} $idType,
  ${QuestionnaireFields.description} $textType,
  ${QuestionnaireFields.type_reponse} $integerType,
  ${QuestionnaireFields.id_rubrique} $integerType
)
''');
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,email Text,phone TEXT, password TEXT);";
    await db.execute(sql);
  }
  // Future<void> insertQuestionnaire(Questionnaire questionnaire) async {
  //   final db = await database;

  //   await db.insert(questionnaires, questionnaire.toJson(),
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future close() async {
  //   final db = await instance.database;
  //   db.close();
  // }
}
