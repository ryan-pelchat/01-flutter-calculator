import 'package:flutter/material.dart';

class PastEval extends StatelessWidget {
  final List<Map<String, Object>> pastEvals;
  final EdgeInsets margin;
  final Function garbage;
  final Function copy;
  final Function append;

  PastEval(
      {@required this.pastEvals,
      @required this.margin,
      @required this.garbage,
      @required this.copy,
      @required this.append});

  @override
  Widget build(BuildContext context) {
    return this.pastEvals.isEmpty
        ? Card(
            borderOnForeground: true,
            elevation: 5,
            margin: margin,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("No past history...7"),
                ],
              ),
            ),
          )
        : Scrollbar(
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      copy(this.pastEvals[index]['txt']);
                    },
                    trailing: LayoutBuilder(
                      builder: (cxt, constraint) {
                        return SizedBox(
                          width: constraint.maxWidth - 1,
                          height: constraint.maxHeight - 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${this.pastEvals[index]['txt']}',
                                  style: TextStyle(fontSize: 16)),
                              Container(
                                width: 10,
                              ),
                              SizedBox(
                                width: 28,
                                child: IconButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8),
                                  alignment: Alignment.center,
                                  icon: Icon(Icons.add),
                                  color: Colors.blue[400],
                                  onPressed: () {
                                    append(this.pastEvals[index]['txt']);
                                  },
                                  splashRadius: 18.0,
                                ),
                              ),
                              SizedBox(
                                width: 28,
                                child: IconButton(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8),
                                  icon: Icon(Icons.delete),
                                  color: Theme.of(context).errorColor,
                                  onPressed: () {
                                    garbage(this.pastEvals[index]['id']);
                                  },
                                  splashRadius: 18.0,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              itemCount: pastEvals.length,
            ),
            showTrackOnHover: true,
            isAlwaysShown: true,
          );
  }
}
