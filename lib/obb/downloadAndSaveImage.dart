import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadAndSaveImage(String imageUrl) async {
  final Directory obbDir = await getApplicationSupportDirectory();
  final String obbPath = obbDir.path;

  final String imageName = 'image.jpg'; // اسم الصورة التي ترغب في تسميتها في مجلد OBB

  final FirebaseStorage storage = FirebaseStorage.instance;
  final Reference storageRef = storage.ref().child(imageUrl);

  try {
    final File imageFile = File('$obbPath/$imageName');
    await storageRef.writeToFile(imageFile);

    print('تم تنزيل وحفظ الصورة بنجاح في مجلد OBB.');
  } catch (e) {
    print('حدث خطأ أثناء تنزيل وحفظ الصورة: $e');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize();

  // تحقق مما إذا كانت الصورة موجودة بالفعل في مجلد OBB قبل تنزيلها
  final Directory obbDir = await getApplicationSupportDirectory();
  final String obbPath = obbDir.path;
  final String imageName = 'image.jpg'; // اسم الصورة

  final File imageFile = File('$obbPath/$imageName');
  if (imageFile.existsSync()) {
    print('الصورة موجودة بالفعل في مجلد OBB.');
  } else {
    // تنزيل الصورة وحفظها في مجلد OBB
    await downloadAndSaveImage('1685832514234.jpg');
  }
}