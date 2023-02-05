import 'package:flutter/material.dart';

import '../constants/constant_color.dart';
import '../utils/size_config.dart';

class CustomRadio extends StatefulWidget {
  final int value;
  final String? type;
  final String name;
  final int groupValue;
  final Function(int, String) onChanged;
  late final bool validate;
  CustomRadio(
      {Key? key,
      this.type = 'radio',
      required this.value,
      required this.groupValue,
      required this.name,
      required this.onChanged,
      this.validate = false})
      : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    bool selected = (widget.value == widget.groupValue);
    double c_width = MediaQuery.of(context).size.width * 0.6;
    return InkWell(
      onTap: () {
        // widget.validate = true;
        widget.onChanged(widget.value, widget.name);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: widget.groupValue == 1
                  ? Color.fromARGB(255, 84, 123, 174)
                  : Color.fromARGB(255, 221, 219, 218)),
          borderRadius: const BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
              SizeConfig.defaultSize! * 1.6,
              SizeConfig.defaultSize! * 0.6,
              SizeConfig.defaultSize! * 0.8,
              SizeConfig.defaultSize! * 0.6),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.all(SizeConfig.defaultSize! * 0.45),
                  padding: EdgeInsets.all(SizeConfig.defaultSize! * 0.45),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                        color: widget.groupValue == 1
                            ? colorBar
                            : Color.fromARGB(255, 221, 219, 218)),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Icon(
                    selected
                        ? (widget.type == 'radio'
                            ? Icons.circle
                            : Icons.check_box)
                        : null,
                    size: widget.type == 'radio'
                        ? SizeConfig.defaultSize! * 1.6
                        : SizeConfig.defaultSize! * 1.8,
                    color: selected ? colorBar : Colors.grey[200],
                  )),
              Padding(
                padding: EdgeInsets.only(left: SizeConfig.defaultSize! * 1.6),
                child: Wrap(
                  children: [
                    Container(
                      width: c_width,
                      child: Text(
                        widget.name.toString(),
                        style: TextStyle(
                            height: SizeConfig.defaultSize! * 0.14,
                            fontWeight: FontWeight.w400,
                            fontSize: SizeConfig.defaultSize! * 1.3,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
