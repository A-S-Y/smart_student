import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:smart_student/page/image_page.dart';
import 'HomePage.dart';
import 'firebase_options.dart';
import 'package:smart_student/api/firebase_api.dart';
import 'package:smart_student/model/firebase_file.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  static final String title = 'Firebase Download';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('asaad/');
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(MyApp.title),
      centerTitle: true,
    ),
    body: FutureBuilder<List<FirebaseFile>>(
      future: futureFiles,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return Center(child: Text('Some error occurred!'));
            } else {
              final files = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildHeader(files.length),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: files.length,
                      itemBuilder: (context, index) {
                        final file = files[index];

                        return buildFile(context, file);
                      },
                    ),
                  ),
                ],
              );
            }
        }
      },
    ),
  );

  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
    leading: ClipOval(
      child: Image.network(
        file.url,
        width: 52,
        height: 52,
        fit: BoxFit.cover,
      ),
    ),
    title: Text(
      file.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        color: Colors.blue,
      ),
    ),
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ImagePage(file: file),
    )),
  );

  Widget buildHeader(int length) => ListTile(
    tileColor: Colors.blue,
    leading: Container(
      width: 52,
      height: 52,
      child: Icon(
        Icons.file_copy,
        color: Colors.white,
      ),
    ),
    title: Text(
      '$length Files',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.white,
      ),
    ),
  );
}
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  set isDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}

