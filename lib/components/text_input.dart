import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class TextInput extends StatefulWidget {
  late bool validate;

  final double height;
  final String? hint;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final double borderRaduis;
  final TextInputType textInputType;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final bool? enabled;
  final EdgeInsets? scrollPadding;

  TextInput({
    Key? key,
    this.scrollPadding,
    this.validate = false,
    this.height = 38,
    this.hint,
    this.enabled = true,
    this.focusNode,
    this.controller,
    this.borderRaduis = 5,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);
//
  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: TextField(
              style: TextStyle(
                  fontSize: SizeConfig.defaultSize! * 1.4,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff695D55)),
              onChanged: (value) {
                checkValidate();
              },
              enabled: widget.enabled,
              controller: widget.controller,
              focusNode: widget.focusNode,
              keyboardType: widget.textInputType,
              textInputAction: TextInputAction.next,
              scrollPadding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 100),
              decoration: InputDecoration(
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding: const EdgeInsets.only(
                    top: 9, left: 20, bottom: 12, right: 20),
                label: Text(
                  widget.hint ?? 'กรุณากรอก',
                  style: TextStyle(
                      fontSize: SizeConfig.defaultSize! * 1.3,
                      color: widget.validate == false
                          ? Color(0xCC695D55)
                          : Colors.red),
                ),
                counterText: '',
                labelStyle: TextStyle(
                    color: Color(0XFFE0E0E0),
                    fontSize: SizeConfig.defaultSize! * 1.3),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.validate == false
                          ? Color(0xffE2E8F0)
                          : Colors.red),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRaduis)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 159, 158, 158)),
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRaduis)),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.borderRaduis)),
                ),
              )),
        ),
        Visibility(
          visible: widget.validate,
          child: Container(
              color: Color(0xffEFF3F8),
              padding: EdgeInsets.only(left: 10, top: 1),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'กรุณากรอกข้อมูล',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w400,
                        fontSize: 11),
                  ))),
        )
      ],
    );
  }

  checkValidate() {
    setState(() {
      widget.validate = false;
    });
  }
}
