import 'package:flutter/material.dart';
/*

Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
 */

class ClicableCard extends StatelessWidget {
  ClicableCard({@required this.title, @required this.description, this.onTap});

  final title;
  final description;
  final Function onTap;
  // final Function onPress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Card(
        elevation: 2,
        color: Colors.green[50],
        child: Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding:
                          EdgeInsets.only(left: 8, top: 8, bottom: 8, right: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.title,
                            style: TextStyle(
                                fontSize: 9.5, color: Colors.green[900]),
                          ),
                          Text(
                            this.description,
                            style: TextStyle(
                                fontSize: 16, color: Colors.green[900]),
                          ),
                        ],
                      ))),
              Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.green[900],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
