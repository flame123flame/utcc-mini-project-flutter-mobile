import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:utcc_mobile/constants/constant_color.dart';

import '../../constants/constant_font_size.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorBar,
        title: const Text('แก้ไขรหัสผ่าน'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 23,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 315,
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'รหัสผ่านเดิม',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 2),
                child: Row(
                  children: [
                    Text(
                      'รหัสผ่านใหม่',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      ' *',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: fontLableInput,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  height: 42,
                  padding: EdgeInsets.only(left: 5, right: 1, bottom: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                          color: Color.fromARGB(255, 221, 219, 218))),
                  child: Focus(
                    onFocusChange: (hasFocus) {},
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  )),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Material(
                  color: colorBar,
                  borderRadius: BorderRadius.circular(6.0),
                  child: InkWell(
                    onTap: () async => {
                      EasyLoading.show(
                        // status: 'loading...',
                        indicator: Image.asset(
                          'assets/images/Loading_2.gif',
                          height: 70,
                        ),
                      ),
                      await Future.delayed(Duration(seconds: 3)),
                      Navigator.of(context).pop(),
                      EasyLoading.dismiss(),
                    },
                    child: Container(
                      height: 40.0,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'แก้ไขรหัสผ่าน',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
