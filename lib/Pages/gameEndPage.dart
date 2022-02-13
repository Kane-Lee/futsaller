import 'package:flutter/material.dart';
import 'package:futsaller/Pages/mainPage.dart';

class GameEndPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 130.0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: AssetImage('assets/IMG_6676.jpg'),
            ),
            SizedBox(height: 15),
            Row(children: [
              Text('경기 결과',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
              Text('입니다.', style: TextStyle(fontSize: 30, color: Colors.grey)),
            ]),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainPage()));
                },
                child: Text('홈으로 돌아가기')),
          ],
        ),
      ),
    );
  }
}
