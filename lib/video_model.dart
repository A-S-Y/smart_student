import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VideoModel {
  final String name;
  final String videoPath;
  final String textPath;

  VideoModel({
    required this.name,
    required this.videoPath,
    required this.textPath,
  });

  Future<void> saveToDatabase() async {
    final database = await createDatabase();
    await database.insert(
      'my_table',
      {
        'name': name,
        'video_path': videoPath,
        'text_path': textPath,
      },
    );
    print('تمت إضافة البيانات إلى قاعدة البيانات');
  }

  Future<Database> createDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'my_database.db');
    print(path);
    print("555555555555555555555");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE my_table (
            id INTEGER PRIMARY KEY,
            name TEXT,
            video_path TEXT,
            text_path TEXT
          )
          ''',
        );
      },
    );
  }
}
