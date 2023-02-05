import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/constant_color.dart';
import '../model_components/popup_model.dart';
import '../utils/size_config.dart';

class PopupPicker extends StatefulWidget {
  final Function(int?, int?, String?, String?) onSelected;
  late bool? validate;
  final String title;
  final List<PopupModel> list;
  final bool? disabled;
  PopupPicker({
    Key? key,
    required this.onSelected,
    required this.list,
    this.validate = false,
    this.title = 'กรุณาเลือก',
    this.disabled = false,
  }) : super(key: key);

  @override
  State<PopupPicker> createState() => _PopupPickerState();
}

class _PopupPickerState extends State<PopupPicker> {
  int? indexSelect;
  int? tempIndexSelect;
  void _showDialog(Widget child, context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext context) => Container(
              height: MediaQuery.of(context).size.height * 0.45,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoButton(
          color: widget.disabled != false
              ? Color.fromARGB(255, 221, 219, 218)
              : Colors.white,
          padding: EdgeInsets.zero,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 10, 19, 8),
            decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color: widget.validate != true
                      ? Color.fromARGB(255, 221, 219, 218)
                      : Colors.red),
              borderRadius: const BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: new Container(
                    padding: new EdgeInsets.only(right: 13.0),
                    child: new Text(
                      null != indexSelect
                          ? widget.list[indexSelect!].lable
                          : widget.title,
                      overflow: TextOverflow.ellipsis,
                      style: new TextStyle(
                        fontSize: 13.0,
                        color:
                            widget.validate != true ? Colors.black : Colors.red,
                        fontFamily: 'prompt',
                      ),
                    ),
                  ),
                ),
                RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: widget.validate != true
                        ? Color(0xFFD0D5DB)
                        : Colors.red,
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () => widget.disabled != false
              ? null
              : _showDialog(
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 1, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'ปิด',
                                style: TextStyle(
                                    fontFamily: 'prompt',
                                    color: Color.fromARGB(255, 12, 54, 151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                widget.validate = false;
                                if (widget.list.isNotEmpty) {
                                  indexSelect = tempIndexSelect ?? 0;
                                  widget.onSelected.call(
                                      indexSelect,
                                      widget.list[indexSelect!].id,
                                      widget.list[indexSelect!].code,
                                      widget.list[indexSelect!].lable);
                                  setState(() {});
                                }

                                Navigator.pop(context);
                              },
                              child: Text(
                                'ตกลง',
                                style: TextStyle(
                                    fontFamily: 'prompt',
                                    color: colorBar,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                                initialItem: indexSelect ?? 0),
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 60,
                            onSelectedItemChanged: (int selectedItem) {
                              tempIndexSelect = selectedItem;
                            },
                            children: List<Widget>.generate(widget.list.length,
                                (int index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    right: SizeConfig.defaultSize! * 8.3,
                                    left: SizeConfig.defaultSize! * 8.3),
                                child: Center(
                                  child: Text(
                                    widget.list[index].lable,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: SizeConfig.defaultSize! * 1.5,
                                      fontFamily: 'prompt',
                                      color: Color.fromARGB(255, 23, 23, 24),
                                    ),
                                  ),
                                ),
                              );
                            })),
                      ),
                    ],
                  ),
                  context),
        ),
      ],
    );
  }
}
