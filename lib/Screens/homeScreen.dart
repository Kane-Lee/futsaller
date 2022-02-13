import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  String userName = '청라메시';
  String teamName = '청라FC';
  String nextSchedule = '2022년 2월 28일';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0,130.0,0,0),
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30.0,
              backgroundImage: AssetImage('assets/IMG_6676.jpg'),
          ),
          SizedBox(height: 15),
          Row(children: [
            Text(userName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            Text('님 환영합니다', style: TextStyle(fontSize: 30, color: Colors.grey))
          ]),
          Row(children: [
            Text(teamName,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            Text('의 다음 경기는', style: TextStyle(fontSize: 30, color: Colors.grey)),

          ]),
          Row(children: [

            Text(nextSchedule,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
            Text('입니다.', style: TextStyle(fontSize: 30, color: Colors.grey))
          ]),
        ],
      )),
    );
  }
}
