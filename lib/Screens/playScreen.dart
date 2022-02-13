import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futsaller/Pages/playPage.dart';
import 'package:geolocator/geolocator.dart';

class PlayScreen extends StatefulWidget {
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  int playtime = 15;
  String gameStyle = '풋살';

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: 300,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30.0,
                scrollController: FixedExtentScrollController(initialItem: 14),
                children: [
                  Text('1분'),
                  Text('2분'),
                  Text('3분'),
                  Text('4분'),
                  Text('5분'),
                  Text('6분'),
                  Text('7분'),
                  Text('8분'),
                  Text('9분'),
                  Text('10분'),
                  Text('11분'),
                  Text('12분'),
                  Text('13분'),
                  Text('14분'),
                  Text('15분'),
                  Text('16분'),
                  Text('17분'),
                  Text('18분'),
                  Text('19분'),
                  Text('20분'),
                  Text('21분'),
                  Text('22분'),
                  Text('23분'),
                  Text('24분'),
                  Text('25분'),
                  Text('26분'),
                  Text('27분'),
                  Text('28분'),
                  Text('29분'),
                  Text('30분'),
                ],
                onSelectedItemChanged: (value) {
                  setState(() {
                    playtime = value + 1;
                  });
                },
              ),
            ));
  }

  void getLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(position);
  }

  void getLocationPermission() async{
    LocationPermission permission = await Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
          Container(
              child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "방식",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) =>
                            CupertinoActionSheet(actions: [
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    setState(() {
                                      gameStyle = '풋살';
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text('풋살')),
                              CupertinoActionSheetAction(
                                  onPressed: () {
                                    setState(() {
                                      gameStyle = '축구';
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text('축구'))
                            ]));
                  },
                  child: Text(
                    gameStyle,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "시간",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () => _showPicker(context),
                  child: Text(
                    "$playtime분",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ))
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "장소",
                style: TextStyle(fontSize: 30, color: Colors.grey),
              ),
              SizedBox(width: 10),
              TextButton(
                  onPressed: () {
                    getLocationPermission();
                  },
                  child: Text(
                    "안필드",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ))
            ])
          ])),
          Column(children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => PlayPage(gameTime: playtime)));
                getLocation();


                },
              child: Text(
                "KICK OFF",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(120, 120), shape: const CircleBorder()),
            ),
            SizedBox(
              height: 20,
            )
          ])
        ])));
  }
}
