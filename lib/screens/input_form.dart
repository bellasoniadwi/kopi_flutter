import 'package:flutter/material.dart';
import 'package:kopi_flutter/materials/style.dart';
import 'package:get/get.dart';

class InputForm extends StatefulWidget {
  @override
  _InputForm createState() => _InputForm();
}

class _InputForm extends State<InputForm> {
  double _dialogHeight = 0.0;
  double _dialogWidth = Get.width;
  String selectedDropdownValue = '';
  String textareaValue = '';
  String imagePath = '';
  String? _selectedValue;
  List<String> listOfValue = ['Arabika', 'Robusta'];

  @override
  void initState() {
    super.initState();
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
          keterangan(),
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
                onPressed: () {},
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

  Container keterangan(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Keterangan'),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 0),
              color: Color.fromARGB(255, 241, 241, 241),
            ),
            child: TextFormField(
              maxLines: 5, // This will create a multiline input
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Keterangan',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
