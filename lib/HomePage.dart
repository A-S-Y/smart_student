import 'package:flutter/material.dart';
import 'package:smart_student/SettingPage.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:smart_student/main.dart';
import 'package:smart_student/page/image_page.dart';

const _kPages = <String, IconData>{
  'home': Icons.home,
  'map': Icons.map,
  'add': Icons.add,
  'message': Icons.message,
  'people': Icons.people,
};
final customPages = [
  SettingPage(), // صفحة مخصصة للمفتاح الأول في _kPages
  //CustomPage2(), // صفحة مخصصة للمفتاح الثاني في _kPages
  //CustomPage3(), // صفحة مخصصة للمفتاح الثالث في _kPages
  // وهكذا...
];
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabStyle _tabStyle = TabStyle.flip;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Navigation Drawer')),
        body: Column(
          children: [

            const Divider(),

            Expanded(
              child: TabBarView(
                children: [
                  for (final icon in _kPages.values)
                    Container(
                      alignment: Alignment.center,
                      child: icon == Icons.map
                          ? MainPage() // استبدل firebaseFile بالمتغير الخاص بك
                          : icon == Icons.add
                          ? SettingPage() // أضف هنا صفحة الإعدادات SettingPage()
                          : Text(
                        _kPages.keys.elementAt(_kPages.values.toList().indexOf(icon)),
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                ],
              ),



            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                child: Text('Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                leading: const Icon(
                  Icons.alarm,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.message,
                ),
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                leading: const Icon(
                  Icons.email,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 3'),
                leading: const Icon(
                  Icons.phone,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 4'),
                leading: const Icon(
                  Icons.camera,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 5'),
                leading: const Icon(
                  Icons.watch,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Settings'),
                leading: const Icon(
                  Icons.settings,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingPage()),
                  );
                },
              ),
              ListTile(
                title: const Text('Item 6'),
                leading: const Icon(
                  Icons.exit_to_app,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: ConvexAppBar.badge(
           const <int, dynamic>{3: '99+'},
          style: _tabStyle,
          items: <TabItem>[
            for (final entry in _kPages.entries)
              TabItem(icon: entry.value, title: entry.key),
          ],
          onTap: (int i) => print('click index=$i'),
        ),
      ),
    );
  }
}

