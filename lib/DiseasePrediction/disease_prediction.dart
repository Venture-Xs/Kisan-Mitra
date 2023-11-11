import 'dart:io';
import 'dart:typed_data';
import 'package:kisan_mitra_app/FarmerConsultant/chat_bot.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart';

class DiseasePrediction extends StatefulWidget {
  const DiseasePrediction({super.key});

  @override
  DiseasePredictionState createState() => DiseasePredictionState();
}

class DiseasePredictionState extends State<DiseasePrediction> {
  ImageProvider? imageProvider;
  final picker = ImagePicker();
  XFile? _image;
  String _outputString = '';

  void _openGallery() async {
    //Open gallery select picture to imageProvider
    _image = await picker.pickImage(source: ImageSource.gallery);
    //Xfile to imageprovider
    if (_image != null) {
      _executeModel(_image!);
      setState(() {
        imageProvider = FileImage(File(_image!.path));
      });
    }
  }

  void _openCamera() async {
    //Open gallery select picture to imageProvider
    _image = await picker.pickImage(source: ImageSource.camera);
    //Xfile to imageprovider
    if (_image != null) {
      _executeModel(_image!);
      setState(() {
        imageProvider = FileImage(File(_image!.path));
      });
    }
  }

  void _executeModel(XFile inputImg) async {
    // Load model
    final interpreter =
        await Interpreter.fromAsset('assets/model/model.tflite');

    String labelsData = await rootBundle.loadString('assets/model/labels.txt');
    List<String> labels = labelsData.split('\n');

    // Load image
    img.Image? image = img.decodeImage(File(inputImg.path).readAsBytesSync());
    if (image == null) {
      print('Failed to decode image.');
      return;
    }

    img.Image resizedImage = img.copyResize(image, width: 224, height: 224);

    // Convert image to uint8 and then cast to float32
    var imgBytes = resizedImage.getBytes();
    var imgUint8 = imgBytes.buffer.asUint8List();
    var imgFloat32 = imgUint8.map((value) => value / 255.0).toList();
    List imgAsFloat32List = Float32List.fromList(imgFloat32);
    imgAsFloat32List = imgAsFloat32List.reshape([1, 224, 224, 3]);

    // Run model
    var output = List.filled(labels.length, 0).reshape([1, labels.length]);
    interpreter.run(imgAsFloat32List, output);

    // Interpret output
    var maxProb =
        output[0].reduce((double a, double b) => a > b ? a : b); //largest
    var predictedLabel = labels[output[0].indexOf(maxProb)];
    setState(() {
      _outputString =
          'The plant is likely having: $predictedLabel with confidence: ${(maxProb * 100).toStringAsFixed(2)}%';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            //Border color
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 1,
              ),
            ),
            child: imageProvider != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      //Rounded border
                      fit: BoxFit.cover,
                      image: imageProvider!,
                    ),
                  )
                : const Center(
                    child: Text('No image selected',
                        style: TextStyle(fontSize: 17)),
                  ),
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                //Height of elevated button
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                ),
                onPressed: _openCamera,
                child: const Text('Capture Photo'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 50),
                ),
                onPressed: _openGallery,
                child: const Text('Select from gallery'),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Text(_outputString,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
          const SizedBox(height: 20),
          _outputString.isNotEmpty
              ? ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: Text('Kisan Mitra Chatbot'),
                              ),
                              body: ChatBot(
                                inputString:
                                    '$_outputString How can we solve this issue , step by step ?',
                              ))),
                    );
                  },
                  child: Text('Get Solutions ->'))
              : Container(),
        ],
      ),
    );
  }
}
