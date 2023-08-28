import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kopi_flutter/materials/style.dart';
import 'package:get/get.dart';

class InputForm extends StatefulWidget {
  const InputForm({Key? key}) : super(key: key);

  @override
  _InputForm createState() => _InputForm();
}

class _InputForm extends State<InputForm> {
  double _dialogHeight = 0.0;
  double _dialogWidth = Get.width;
  String selectedDropdownValue = '';
  String textareaValue = '';
  String imageUrl = '';
  String _imagePath = '';
  String? _selectedValue;
  List<String> listOfValue = [];
  bool _isSaving = false;
  final TextEditingController _deskripsiController = TextEditingController();
  final CollectionReference _records =
      FirebaseFirestore.instance.collection('records');

  @override
  void initState() {
    super.initState();
    fetchListOfValues();
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _dialogHeight = Get.height / 2;
      });
    });
  }

  Widget build(BuildContext context) {
    Style style = Style();

    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      height: _dialogHeight,
      width: _dialogWidth,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Get.width,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 110, 56, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Text(
              'Record Pemantauan Kopi',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          jenis(),
          foto(),
          SizedBox(
            height: 10,
          ),
          if (_imagePath.isNotEmpty)
            
            Center(
              child: Container(
                height: 250,
                width: 170,
                child: _imagePath != ''
                    ? Image.file(
                        File(_imagePath),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          deskripsi(),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: style.btnStyle(
                    btnWidth: Get.width / 3,
                    btnColor: Color.fromARGB(255, 241, 241, 241)),
                onPressed: () async {
                  await Future.delayed(Duration(milliseconds: 50), () {
                    setState(() {
                      _dialogHeight = 0;
                    });
                  });
                  await Future.delayed(Duration(milliseconds: 450));
                  Get.back();
                },
                child: Text(
                  'Cancel',
                  style:
                      style.txtStyle(txtColor: Color.fromARGB(255, 110, 56, 1)),
                ),
              ),
              ElevatedButton(
                onPressed: _isSaving ? null : () async {
                  setState(() {
                    _isSaving = true;
                  });

                  final String jenis = _selectedValue.toString();
                  final String deskripsi = _deskripsiController.text;
                  String latitude = '';
                  String longitude = '';

                  _currentLocation = await _getCurrentLocation();
                  latitude = _currentLocation!.latitude.toString();
                  longitude = _currentLocation!.longitude.toString();

                  if (_imagePath.isEmpty) {
                    setState(() {
                      _isSaving = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Upload Bukti Foto'),
                      backgroundColor: Color.fromARGB(255, 110, 56, 1),
                    ));
                    return;
                  }

                  if (_selectedValue != null) {
                  Uint8List imageBytes = await File(_imagePath).readAsBytes();
                  String uniqueFileName =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  String formattedDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

                  String fileName = 'images/' +
                      uniqueFileName +
                      '_' +
                      formattedDateTime +
                      '.jpg';
                  Reference referenceImageToUpload =
                      FirebaseStorage.instance.ref().child(fileName);
                  await referenceImageToUpload.putData(imageBytes);

                  String imageUrl = await referenceImageToUpload.getDownloadURL();

                  // Generate custom id : decrement
                  int docCustom = 3000000000000 - DateTime.now().millisecondsSinceEpoch;
                  String docId = docCustom.toString();
                  // Create a reference to the document using the custom ID
                  DocumentReference documentReference = _records.doc(docId);

                  await documentReference.set({
                    "jenis": jenis,
                    "timestamps": FieldValue.serverTimestamp(),
                    "foto": imageUrl,
                    "latitude": latitude,
                    "longitude": longitude,
                    "deskripsi": deskripsi,
                    "feedback": "",
                  });

                  setState(() {
                    _isSaving = false;
                  });

                  _deskripsiController.text = '';
                  _imagePath = '';

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Data anda berhasil tersimpan'),
                    backgroundColor: Color.fromARGB(255, 110, 56, 1),
                  ));

                  await Future.delayed(Duration(milliseconds: 50), () {
                    setState(() {
                      _dialogHeight = 0;
                    });
                  });
                  await Future.delayed(Duration(milliseconds: 450));
                  Get.back();
                } else {
                  setState(() {
                    _isSaving = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Masukkan jenis kopi'),
                    backgroundColor: Color.fromARGB(255, 110, 56, 1),
                  ));
                }
                },
                child: _isSaving
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 110, 56, 1)),
              )
            : Text(
                  'Create',
                  style: style.txtStyle(txtColor: Colors.white),
                ),
                style: style.btnStyle(
                    btnWidth: Get.width / 3,
                    btnColor: Color.fromARGB(255, 110, 56, 1)),
              )
            ],
          )
        ],
      )),
    );
  }

  Container jenis() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jenis'),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 0),
              color: Color.fromARGB(255, 241, 241, 241),
            ),
            child: DropdownButton<String>(
              value: _selectedValue,
              onChanged: ((value) {
                setState(() {
                  _selectedValue = value as String?;
                });
              }),
              items: listOfValue
                  .map((e) => DropdownMenuItem(
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Text(
                                e,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        value: e,
                      ))
                  .toList(),
              selectedItemBuilder: (BuildContext context) => listOfValue
                  .map((e) => Row(
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                              fontSize: 18
                            ),
                          ),
                        ],
                      ))
                  .toList(),
              hint: Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Text(
                  'Pilih Jenis',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              dropdownColor: Colors.white,
              isExpanded: true,
              underline: Container(),
            ),
          ),
        ],
      ),
    );
  }

  Container foto(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Upload Foto'),
            SizedBox(
              height: 5,
            ),
            Container(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 110, 56, 1),
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromARGB(255, 110, 56, 1),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () => _pickAndSetImage(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Ambil Foto',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ))
          ]),
    );
  }

  Container deskripsi(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deskripsi'),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 0),
              color: Color.fromARGB(255, 241, 241, 241),
            ),
            child: TextFormField(
              controller: _deskripsiController,
              maxLines: 5,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Deskripsi',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchListOfValues() async {
    final snapshot = await FirebaseFirestore.instance.collection('kopis').get();
    List<String> values = [];
    snapshot.docs.forEach((doc) {
      if (doc.exists) {
        String jenis = doc['jenis'];
        values.add(jenis);
      }
    });
    setState(() {
      listOfValue = values;
    });
  }

  Future<void> _pickAndSetImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) return;
    setState(() {
      _imagePath = file.path;
    });
  }

  void _setImageUrl(String imageUrl) {
    setState(() {
      this.imageUrl = imageUrl;
    });
  }

  Position? _currentLocation;
  late bool servicePermission = false;
  late LocationPermission permission;
  Future<Position> _getCurrentLocation() async {
    // check if we have permission to access location service
    servicePermission = await Geolocator.isLocationServiceEnabled();
    if (!servicePermission) {
      print("Service Disabled");
    }
    // service enabled
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition();
  }
}
