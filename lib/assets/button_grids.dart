import 'package:flutter/material.dart';
/*
BtnGrid is an ressource class that is needed by the Keypad class
*/

class BtnGrid {
  final Map<String, Object> keypadParam = {
    "back": Colors.blue[600],
    'padding': 4,
    'txtc': Colors.black,
    'size': [5, 4], // square grid size, rows by columns
  };
  final List<List<Map<String, Object>>> keypad = [
    [
      {'txt': '1', 'size': 1},
      {'txt': '4', 'size': 1},
      {'txt': '7', 'size': 1},
      {'txt': '+/-', 'size': 1},
    ],
    [
      {'txt': '2', 'size': 1},
      {'txt': '5', 'size': 1},
      {'txt': '8', 'size': 1},
      {'txt': '0', 'size': 1},
    ],
    [
      {'txt': '3', 'size': 1},
      {'txt': '6', 'size': 1},
      {'txt': '9', 'size': 1},
      {'txt': '.', 'size': 1},
    ],
    [
      {'txt': '(', 'size': 1},
      {'txt': '+', 'size': 1},
      {'txt': '-', 'size': 1},
      {'txt': 'Clear', 'size': 1},
    ],
    [
      {'txt': ')', 'size': 1},
      {'txt': '*', 'size': 1},
      {'txt': '/', 'size': 1},
      {'txt': 'Enter', 'size': 1},
    ],
  ];
}
