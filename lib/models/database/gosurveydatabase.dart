import 'package:go_survey/models/questionnaire.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GoSruveyDataBase {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'gosurvey.db');
    var database = await openDatabase(path,
        version: 1, onCreate: _createDatabase, onConfigure: _onConfigure);
    return database;
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys =ON');
  }

  Future<void> _createDatabase(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final stringType = 'STRING';
    final boolTYpe = "BOOLEAN NOT NULL";
    final integerType = 'INTEGER';
    // on updqte
    // ON UPDATE SET NULL, ON DELETE SET NULL or set default, restrict, no action, cascade
    // Create table users for users of applications in  the mobile phone
    String sql =
        "CREATE TABLE users (id INTEGER PRIMARY KEY,name TEXT,email Text,phone TEXT, password TEXT);";
    await db.execute(sql);

    // create table of rubrik of the survey
    await db.execute('''
CREATE TABLE rubriques(id $idType, 
description $stringType, userId $integerType, FOREIGN KEY (userId) REFERENCES users (id) );
''');
// Create table of recensement description

//     await db.execute('''
// CREATE TABLE recensements (id $idType,
//  description $stringType,
//   userId $integerType,
//   FOREIGN KEY (userId) REFERENCES users (id))
// ''');

// Questionnaire table

    await db.execute('''
CREATE TABLE questionnaires(id $idType,
question $textType,
typeReponse $stringType,
rubriqueId $integerType,
userId $integerType,
FOREIGN KEY (rubriqueId) REFERENCES rubriques (id),
FOREIGN KEY (userId) REFERENCES users (id)
 );
''');

// Modalite table

    await db.execute('''
CREATE TABLE modalites(id $idType, 
description $stringType, 
questionId $integerType, 
FOREIGN KEY (questionId) REFERENCES questions (id))
''');

// abord to create questionnary with this methode because I m writting another syntax
//     await db.execute('''
// CREATE TABLE $questionnaires(
//   ${QuestionnaireFields.id} $idType,
//   ${QuestionnaireFields.description} $textType,
//   ${QuestionnaireFields.type_reponse} $integerType,
//   ${QuestionnaireFields.id_rubrique} $integerType,
// )
// ''');

    await db.execute('''
CREATE TABLE reponses (id $idType, reponse $stringType, questionId $integerType, userId $integerType,
FOREIGN KEY(questionId) REFERENCES questionnaires (id), FOREIGN KEY (userId) REFERENCES users (id)
)
''');
    await db.execute('''
CREATE TABLE configs(id $idType, 
theme $stringType, serveur $stringType, tailleTexte INTEGER, langue INTEGER, misAjourForm INTEGER, sendAuto INTEGER, userId $integerType, FOREIGN KEY (userId) REFERENCES users (id) );
''');
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
