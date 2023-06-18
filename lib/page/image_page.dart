import 'package:flutter/material.dart';
import 'package:smart_student/api/firebase_api.dart';
import 'package:smart_student/model/firebase_file.dart';

class ImagePage extends StatefulWidget {
  final FirebaseFile file;

  const ImagePage({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isImage = false;

  @override
  void initState() {
    super.initState();
    isImage = ['.jpeg', '.jpg', '.png', '.mp4'].any(widget.file.name.contains);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.file.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: () async {
              await FirebaseApi.downloadFile(widget.file.ref);

              final snackBar = SnackBar(
                content: Text('Downloaded ${widget.file.name}'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: isImage
          ? Image.network(
        widget.file.url,
        height: double.infinity,
        fit: BoxFit.cover,
      )
          : Center(
        child: Text(
          'Cannot be displayed',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
