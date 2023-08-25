import 'package:flutter/material.dart';

class TextareaField extends StatelessWidget {
  final String title;
  final ValueChanged<String> onChanged;

  TextareaField({required this.title, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.transparent, width: 0),
              color: Color.fromARGB(255, 241, 241, 241),
            ),
            child: TextFormField(
              onChanged: onChanged,
              maxLines: 5, // This will create a multiline input
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: title,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
