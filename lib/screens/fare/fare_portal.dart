import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FarePortal extends StatefulWidget {
  final int? worksheetId;
  final String? status;
  const FarePortal({Key? key, this.worksheetId, required this.status})
      : super(key: key);

  @override
  State<FarePortal> createState() => _FarePortalState();
}

class _FarePortalState extends State<FarePortal> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
