import 'package:flutter/material.dart';
import 'package:lettutor_app/config/theme.dart';

class HomePage extends StatelessWidget {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 105,
            color: AppTheme.mainColor,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: flatButtonStyle,
                    onPressed: () => {},
                    child:
                        Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      Icon(Icons.history),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        'History',
                        style: TextStyle(fontSize: 14),
                      )
                    ]),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    'Total time you study is',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('36 hours 12 minutes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white)),
              ],
            ),
          ),
          Container(
            // padding: EdgeInsets.all(15),
            color: AppTheme.myGreyColor,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Upcomming class',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Time remaining: 9h37m',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Container(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Colors.red,
                    ),
                    Container(
                      height: 30,
                    )
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
