import 'package:flutter/material.dart';

class FiltersListTileModel {
  const FiltersListTileModel({
    required this.leadingText,
    required this.trailingText,
    this.middleText,
    this.isHeader = false,
  });
  final String leadingText;
  final String trailingText;
  final String? middleText;
  final bool isHeader;
}

class FiltersListTile extends StatelessWidget {
  const FiltersListTile({super.key, required this.model});
  final FiltersListTileModel model;

  @override
  Widget build(BuildContext context) {
    const fontSize = 16.0;
    return Container(
      color: model.isHeader ? Colors.blueGrey[100] : null,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Text(model.leadingText, style: const TextStyle(fontSize: fontSize)),
          Expanded(child: Container()),
          if (model.middleText != null)
            Text(
              model.middleText!,
              style: TextStyle(color: Colors.green[700], fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
          SizedBox(
            width: 60.0,
            child: Text(
              model.trailingText,
              style: const TextStyle(fontSize: fontSize),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
