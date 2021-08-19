import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import './widgets/keypad.dart';
import './widgets/past_eval.dart';
import './assets/button_grids.dart';

void main() {
  runApp(MyApp());
}

//TODO maybe try to implement a way to click and change the text

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  
  List<String> _currTxtStr = [""];
    contains current buffer of calculations
  List<Map<String, Object>> _pastEvals _pastEvals = [];
    contains the past resuts,
    map has following format: {'txt': str expression, 'id': unique int id}
  int _id = 0;
    a counter for the unique id of every past eval
  double _currFont = 20;
    the font size to accomodate window resizing

  */
  List<String> _currTxtStr = [""];
  List<Map<String, Object>> _pastEvals = [];
  int _id = 0;
  double _currFont = 20;

  void _currTxt(String input) {
    /*
    This method processes keyboard input.
    */

    // If numbers or operation then add to buffer
    if (!(input == 'Enter' || input == 'Clear' || input == '+/-')) {
      setState(() {
        _currTxtStr.add(input);
      });
    }

    //clear buffer
    if (input == 'Clear') {
      setState(() {
        _currTxtStr = [""];
      });
    }

    // Parse buffer to create value, clear buffer,
    // add to past result and increment id
    if (input == 'Enter' && _currTxtStr.length > 1) {
      setState(() {
        Parser p = Parser();
        Expression exp = p.parse(_currTxtStr.join());
        _pastEvals.add({
          'txt': exp.evaluate(EvaluationType.REAL, ContextModel()).toString(),
          'id': _id
        });
        _id++;
        _currTxtStr = [""];
      });
    }

    //deal with - and + numbers
    if (input == '+/-') {
      setState(() {
        if (_currTxtStr[0] == '-') {
          _currTxtStr.removeAt(0);
        } else {
          _currTxtStr = ['-'] + _currTxtStr;
        }
      });
    }
  }

  void _removePastEntry(int id) {
    // Removes a past entry based on its id
    setState(() {
      _pastEvals.removeWhere((element) => element['id'] == id);
      if (_pastEvals.isEmpty) {
        _id = 0;
      }
    });
  }

  void _copyPastEntry(String entry) {
    // Replaces the current buffer with entry
    setState(() {
      {
        _currTxtStr = entry.split('');
      }
    });
  }

  void _appendPastEntry(String entry) {
    // Appends entry to the current buffer
    setState(() {
      {
        _currTxtStr = _currTxtStr + entry.split('');
      }
    });
  }

  void _currFontSize() {
    /* Tries to estimate a good size of font based of the available window size
    */
    //TODO these calculations are not perfect
    double temp =
        ((MediaQuery.of(context).size.width) - 60) / (_currTxtStr.length) * 1.7;
    setState(() {
      if (temp <= 25) {
        _currFont = temp;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      // Here we take the value from the MyHomePage object that was created by
      // the App.build method, and use it to set our appbar title.
      title: Text(widget.title),
    );

    final double pad = 8.0;
    final double padKey1 = pad - BtnGrid().keypadParam['padding'];
    final EdgeInsets cardMargins =
        EdgeInsets.symmetric(vertical: pad, horizontal: pad + 3);

    final double widthOfWidgets =
        MediaQuery.of(context).size.width - (2 * padKey1);

    _currFontSize();

    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Past Eval box
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.50,
              width: widthOfWidgets,
              child: PastEval(
                pastEvals: _pastEvals,
                margin: cardMargins,
                garbage: _removePastEntry,
                copy: _copyPastEntry,
                append: _appendPastEntry,
              ),
            ),
            // Buffer Bar
            Card(
              borderOnForeground: true,
              elevation: 5,
              margin: cardMargins,
              child: ListTile(
                trailing: IconButton(
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  icon: Icon(Icons.backspace_rounded),
                  color: Theme.of(context).errorColor,
                  onPressed: () {
                    setState(() {
                      _currTxtStr.removeLast();
                    });
                  },
                  splashRadius: 18.0,
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "${_currTxtStr.join()}",
                      style: TextStyle(fontSize: _currFont),
                    ),
                  ],
                ),
              ),
            ),
            // Keyboard
            Container(
              padding: EdgeInsets.all(padKey1),
              height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.40 -
                  (2 * padKey1),
              width: widthOfWidgets,
              child: LayoutBuilder(
                builder: (BuildContext cxt, BoxConstraints constraints) {
                  return Keypad(
                    btnArr: BtnGrid().keypad,
                    genParam: BtnGrid().keypadParam,
                    size: [constraints.maxWidth, constraints.maxHeight],
                    onPressed: _currTxt,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
