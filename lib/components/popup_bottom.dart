import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model_components/popup_bottom_model.dart';

// ignore: must_be_immutable
class PopupFilterBottom extends StatefulWidget {
  final Function(int?, String?, String?) onSelected;
  late bool? validate;
  final String title;
  final List<PopupBottomModel> list;
  final bool? disabled;
  PopupFilterBottom({
    Key? key,
    required this.onSelected,
    required this.list,
    this.validate = false,
    this.title = 'กรุณาเลือก',
    this.disabled = false,
  }) : super(key: key);

  @override
  State<PopupFilterBottom> createState() => _PopupFilterBottomState();
}

class _PopupFilterBottomState extends State<PopupFilterBottom> {
  int? indexSelect;
  int? tempIndexSelect;
  String data = 'ทั้งหมด';
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
              height: MediaQuery.of(context).size.height * 0.50,
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
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CupertinoButton(
          child: Icon(Icons.filter_alt_outlined, size: 23, color: Colors.white),
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
                                '',
                                style: TextStyle(
                                    fontFamily: 'prompt',
                                    color: Color.fromARGB(255, 12, 54, 151),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text('กรุณาเลือกรายการค้นหา'),
                            CupertinoButton(
                              onPressed: () {
                                widget.validate = false;
                                // if (widget.list.isNotEmpty) {
                                //   indexSelect = tempIndexSelect ?? 0;
                                //   widget.onSelected.call(
                                //       indexSelect,
                                //       widget.list[indexSelect!].split('::')[0],
                                //       widget.list[indexSelect!].split('::')[1],
                                //       widget.list[indexSelect!].split('::')[2]);
                                //   setState(() {});
                                // }
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 12, 54, 151),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                              children: List<Widget>.generate(
                                  widget.list.length, (int index) {
                        return CardField(
                            size,
                            Color.fromARGB(255, 12, 54, 151),
                            widget.list[index].icon,
                            widget.list[index].title,
                            widget.list[index].subTitle,
                            index,
                            context);
                      }))),
                    ],
                  ),
                  context),
        ),
      ],
    );
  }

  CardField(Size size, Color color, Icon icon, String title, String subTitle,
      int index, BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 6, 1, 2),
      child: GestureDetector(
        onTap: () {
          widget.onSelected
              .call(index, widget.list[index].code, widget.list[index].title);
          setState(() {
            data = title;
          });
          Navigator.pop(context);
        },
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9.0),
                border: Border.all(
                    width: data == title ? 1.6 : 1,
                    color: data == title
                        ? Color.fromARGB(255, 12, 54, 151)
                        : Color.fromARGB(255, 211, 210, 210))),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: Container(
                child: SizedBox(
                    height: size.height * 0.08,
                    width: size.width * 0.90,
                    child: Center(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: color,
                          child: icon,
                        ),
                        title: Text(
                          title,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 80, 78, 78),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        subtitle: Text(
                          subTitle,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 162, 162, 162),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                      ),
                    )),
              ),
            )),
      ),
    );
  }
}
