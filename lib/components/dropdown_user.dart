import 'package:flutter/material.dart';
import '../model/user.dart';
import '../service/api_service.dart';

class DropdownUser extends StatefulWidget {
  const DropdownUser({Key? key}) : super(key: key);

  @override
  State<DropdownUser> createState() => _DropdownUserState();
}

class _DropdownUserState extends State<DropdownUser> {
  List<User> listUser = [];
  getUser() async {
    try {
      List<User> temp = await ApiService.apiGetUser();
      if (temp.length == 0) {
        return;
      }
      setState(() {
        listUser = List.generate(temp.length, ((index) {
          return User(
            id: temp[index].id,
            username: temp[index].username,
            firstName: temp[index].firstName,
            lastName: temp[index].lastName,
            fullName: temp[index].fullName,
            email: temp[index].email,
            position: temp[index].position,
            phoneNumber: temp[index].phoneNumber,
            roleCode: temp[index].roleCode,
            createDate: temp[index].createDate,
          );
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
      child: Autocomplete<User>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return listUser
              .where((User user) => user.fullName!
                  .toLowerCase()
                  .startsWith(textEditingValue.text.toLowerCase()))
              .toList();
        },
        displayStringForOption: (User option) => option.fullName!,
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
        onSelected: (User selection) {
          print('Selected: ${selection.fullName}');
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<User> onSelected, Iterable<User> options) {
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
                  final User option = options.elementAt(index);
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
                                      Icons.person,
                                      color: Color.fromARGB(255, 184, 182, 181),
                                    ),
                                    Text(
                                      '   ${option.fullName}',
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
