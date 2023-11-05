import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../../constants/constant_color.dart';
import '../../provider/theme_provider.dart';
import '../../utils/size_config.dart';

class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  late ThemeProvider themeProvider;

  @override
  void initState() {
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider =
        Provider.of<ThemeProvider>(context); // Access the ThemeProvider
    Color screenPickerColor = themeProvider.seedColor;
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('รายละเอียดบัญชี'),
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
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.defaultSize! * 2.4,
                  horizontal: SizeConfig.defaultSize! * 1.9),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: ColorIndicator(
                          height: 70,
                          width: double.infinity,
                          borderRadius: 12,
                          color: screenPickerColor,
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ColorPicker(
                          color: screenPickerColor,
                          onColorChanged: (Color color) {
                            themeProvider.onChangedThemeColor(color);
                          },
                          width: 44,
                          height: 44,
                          borderRadius: 22,
                          heading: Text(
                            '${ColorTools.materialNameAndCode(screenPickerColor)}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subheading: Text(
                            'Select color shade',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
