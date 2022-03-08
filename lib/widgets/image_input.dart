import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path; //to connect to that path
import 'package:path_provider/path_provider.dart'
    as syspaths; //to determine the path where system stores the file

import 'dart:io';

class ImageInput extends StatefulWidget {
  // const ImageInput({Key? key}) : super(key: key);
  final Function onSelectImage;
  const ImageInput(this.onSelectImage);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (imageFile == null) return;
    setState(() {
      _storedImage =
          File(imageFile.path); //converted XFile object to File object
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');

    widget.onSelectImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _storedImage != null
              ? Image.file(_storedImage!,
                  fit: BoxFit.cover, width: double.infinity)
              :
              // Image.asset('images/shutter.jpg'),
              const Text(
                  'No Image Taken',
                  textAlign: TextAlign.center,
                ),
          alignment: Alignment.center),
      const SizedBox(width: 10),
      Expanded(
        child: FlatButton.icon(
            icon: const Icon(Icons.camera),
            label: const Text('Take Picture'),
            textColor: Theme.of(context).primaryColor,
            onPressed: _takePicture),
      ),
    ]);
  }
}
