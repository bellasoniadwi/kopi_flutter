import 'package:flutter/material.dart';
import 'package:kopi_flutter/materials/camera_button.dart';
import 'package:kopi_flutter/materials/dropdown_field.dart';
import 'package:kopi_flutter/materials/input_field.dart';
import 'package:kopi_flutter/materials/style.dart';
import 'package:get/get.dart';
import 'package:kopi_flutter/materials/textarea_field.dart';

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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        _dialogHeight = Get.height / 1;
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
          DropdownField(
              title: 'Status',
              options: ['Masuk', 'Izin', 'Sakit'],
              onChanged: (value) {
                setState(() {
                  selectedDropdownValue = value ?? '';
                });
              },
            ),
            CameraButton(
              title: 'Upload Foto',
              onPressed: () {},
            ),
          TextareaField(
              title: 'Keterangan',
              onChanged: (value) {
                setState(() {
                  textareaValue = value;
                });
              },
            ),
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
}
