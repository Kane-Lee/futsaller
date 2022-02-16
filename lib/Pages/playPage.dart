import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:futsaller/Pages/gameEndPage.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:futsaller/Location.dart';

class PlayPage extends StatefulWidget {
  final int gameTime;
  final double currentLatitude;
  final double currentLongitude;

  const PlayPage({required this.gameTime, required this.currentLatitude, required this.currentLongitude});

  @override
  State<PlayPage> createState() => _PlayPageState(initialTime: gameTime, initialLatitude: currentLatitude, initialLongitude: currentLongitude);
}

class _PlayPageState extends State<PlayPage> {
  _PlayPageState({required this.initialTime, required this.initialLatitude, required this.initialLongitude});

  Completer<GoogleMapController> _controller = Completer();

  int initialTime = 0;
  double initialLatitude;
  double initialLongitude;
  bool gameIsPlaying = true;

  Location _location = Location();

  void _showCupertinoAlert() {
    setState(() {
      gameIsPlaying = false;
    });
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('경기 중단'),
              content: const Text('경기를 끝내시겠습니까?'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('네'),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => GameEndPage()));
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('아니오'),
                  onPressed: () {
                    Navigator.pop(context);
                    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    setState(() {
                      gameIsPlaying = true;
                    });
                  },
                )
              ],
            ));
  }

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(0),
      // onChange: (value) => print('onChange $value'),
      // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
      // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
      onEnded: () {
        // print('onEnd');
      });

  @override
  void initState() async {
    final _position = await _location.getCurrentLocation();
    initialLatitude = await _position.latitude;
    initialLongitude = await _position.longitude;
    // print('current latitude : $initialLatitude');
    // print('current longitude : $initialLongitude');
    // test = '초기화 후';

    // _stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records $value'));
    _stopWatchTimer.setPresetMinuteTime(initialTime);
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    Timer(Duration(minutes: initialTime), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => GameEndPage()));
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Text('-\'--"',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                    Text('평균 페이스',
                        style: TextStyle(fontSize: 18, color: Colors.grey))
                  ],
                ),
                Column(
                  children: [
                    Text('--',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                    Text('심박수',
                        style: TextStyle(fontSize: 18, color: Colors.grey))
                  ],
                ),
                Column(
                  children: [
                    Text('-- km',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500)),
                    Text('운동 거리',
                        style: TextStyle(fontSize: 18, color: Colors.grey))
                  ],
                )
              ]),
              Container(
                  height: 200,
                  child: GoogleMap(
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(initialLatitude, initialLongitude),
                          zoom: 16),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      })),
              Column(
                children: [
                  Text('남은 시간',
                      style: TextStyle(fontSize: 20, color: Colors.grey)),
                  StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        final displayTime = StopWatchTimer.getDisplayTime(value,
                            hours: false,
                            minuteRightBreak: '분 ',
                            secondRightBreak: '초 ');
                        return Text(displayTime,
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w500));
                      })
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        if (gameIsPlaying == true) {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                          gameIsPlaying = false;
                        } else {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                          gameIsPlaying = true;
                        }
                      });
                    },
                    child: FaIcon(gameIsPlaying == true
                        ? FontAwesomeIcons.pause
                        : FontAwesomeIcons.play),
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(100, 100),
                        shape: const CircleBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: _showCupertinoAlert,
                      child: const Text('경기 중단하기'))
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}

// Pace, Heart Rate, Distance
