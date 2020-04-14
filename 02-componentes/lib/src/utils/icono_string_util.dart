import 'package:flutter/material.dart';

final _icons = <String, IconData>{

  'add_alert': Icons.add_alert,
  'accessibility': Icons.accessibility,
  'folder_open': Icons.folder_open,
  'donut_large': Icons.donut_large,
  'input': Icons.input,
  'tune': Icons.tune,
  'list': Icons.list,
  'settings_overscan': Icons.settings_overscan,
  'expand_more': Icons.expand_more,
  'wrap_text': Icons.wrap_text,
  'opacity': Icons.opacity
};

Icon getIcon( String nombreIcono ) {
  return Icon(_icons[nombreIcono], color: Colors.blue);
}
