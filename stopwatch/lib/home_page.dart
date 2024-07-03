import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int seconds = 0, minutes = 0, milliseconds = 0;
  String digSec = "00", digMin = "00", digMs = "00";
  Timer? timer;
  bool started = false;
  List<String> laps = [];

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void stop() {
    timer?.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      milliseconds = 0;
      digSec = "00";
      digMin = "00";
      digMs = "00";
      laps.clear();
      started = false;
    });
  }

  void addLap() {
    String lap = "$digMin:$digSec:$digMs";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        milliseconds += 10;
        if (milliseconds >= 1000) {
          seconds++;
          milliseconds = 0;
        }
        if (seconds >= 60) {
          minutes++;
          seconds = 0;
        }

        digMs = (milliseconds % 1000 ~/ 10).toString().padLeft(2, '0');
        digSec = (seconds % 60).toString().padLeft(2, '0');
        digMin = (minutes % 60).toString().padLeft(2, '0');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2657),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Stopwatch App',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF313E66),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$digMin:$digSec:$digMs',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 55.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color(0xFF313E66),
                  ),
                  child: ListView.builder(
                    itemCount: laps.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap ${index + 1}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "${laps[index]}",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 48,
                    icon: Icon(
                      started ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () => started ? stop() : start(),
                  ),
                  SizedBox(width: 24),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(
                      Icons.flag,
                      color: Colors.white,
                    ),
                    onPressed: addLap,
                  ),
                  SizedBox(width: 24),
                  IconButton(
                    iconSize: 48,
                    icon: Icon(
                      Icons.stop,
                      color: Colors.white,
                    ),
                    onPressed: reset,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
