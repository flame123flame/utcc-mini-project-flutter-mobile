import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../model/bus_model.dart';
import '../model/user.dart';
import '../service/api_service.dart';

class DropdownBus extends StatefulWidget {
  final Function(int, String, String) onSelect;
  const DropdownBus({Key? key, required this.onSelect}) : super(key: key);

  @override
  State<DropdownBus> createState() => _DropdownBusState();
}

class _DropdownBusState extends State<DropdownBus> {
  List<BusModel> listBus = [];

  getUser() async {
    try {
      List<BusModel> temp = await ApiService.apiGetListBus();
      if (temp.length == 0) {
        return;
      }
      setState(() {
        listBus = List.generate(temp.length, ((index) {
          return BusModel(
              id: temp[index].id,
              busNo: temp[index].busNo,
              busType: temp[index].busType,
              fare: temp[index].fare,
              discountFare: temp[index].discountFare,
              createDate: temp[index].createDate);
        }));
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 38,
      padding: EdgeInsets.only(left: 15, right: 1, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Color.fromARGB(255, 221, 219, 218))),
      child: Autocomplete<BusModel>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return listBus
              .where((BusModel user) => user.busNo!
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase()))
              .toList();
        },
        displayStringForOption: (BusModel option) => option.busNo!,
        fieldViewBuilder: (BuildContext context,
            TextEditingController fieldTextEditingController,
            FocusNode fieldFocusNode,
            VoidCallback onFieldSubmitted) {
          return TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(255, 184, 182, 181),
                ),
                onPressed: () {},
              ),
            ),
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'prompt'),
          );
        },
        onSelected: (BusModel selection) {
          widget.onSelect
              .call(selection.id!, selection.busNo!, selection.busType!);
          print('Selected: ${selection.busNo}');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<BusModel> onSelected,
            Iterable<BusModel> options) {
          return Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              margin: EdgeInsets.only(right: 78, top: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 221, 219, 218)),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 229, 229, 229).withOpacity(0.14),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final BusModel option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 1, right: 1),
                                child: Row(
                                  children: [
                                    Icon(
                                      CupertinoIcons.bus,
                                      color: Color.fromARGB(255, 184, 182, 181),
                                    ),
                                    Text(
                                      '   ${option.busNo}',
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
