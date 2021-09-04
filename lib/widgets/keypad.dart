import 'package:flutter/material.dart';
import 'dart:math';

class Keypad extends StatelessWidget {
  /* Returns a widget of a grid of buttons, ready to be displayed

  btnArr 
    a 2D array containing the parameters of the button
  genParam 
    the general parameters for the button grid
  genParam["size"]
    list of size 2. first in list is number of columns and second is rows 
  size
    list of size 2. first in list is final pixel size width, second is height.
  onPressed
    function to return the value of the button
  */
  final Map<String, Object> genParam;
  final List<List<Map<String, Object>>> btnArr;
  final List<double> size;
  final Function onPressed;

  Keypad(
      {@required this.btnArr,
      @required this.genParam,
      @required this.size,
      @required this.onPressed});

  List<SizedBox> get getButtonls {
    return this.btnArr.map((ls) {
      return SizedBox(
        width: (this.size[0]) / (genParam['size'] as List)[0],
        height: this.size[1],
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //mainAxisSize: MainAxisSize.max,
            children: ls.map((mp) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.all(
                      (this.genParam['padding'] as int).toDouble()),
                  child: ElevatedButton(
                    child: Text(
                      mp['txt'],
                      style: TextStyle(
                          color: genParam['txtc'],
                          fontSize: ((((this.size[0]) /
                                          (genParam['size'] as List)[0]) +
                                      ((this.size[1]) /
                                          (genParam['size'] as List)[1])) /
                                  2) *
                              0.2),
                    ),
                    onPressed: () => onPressed(mp['txt']),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(this.genParam['back']),
                      // fixedSize: MaterialStateProperty.all(
                      //   //changed from minimumSize
                      //   Size((this.size[0]) / (genParam['size'] as List)[0],
                      //       (this.size[1]) / (genParam['size'] as List)[1]),
                      // ),
                    ),
                  ),
                ),
              );
            }).toList()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: getButtonls,
    );

    // SizedBox(
    //   width: this.size[0] - 50,
    //   height: this.size[1] - 50,
    //   child: Row(
    //     //mainAxisSize: MainAxisSize.max,
    //     children: getButtonls,
    //   ),
    // );
  }
}
