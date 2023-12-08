
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final CountDownController _controller = CountDownController();
  final player = AudioPlayer();

  bool isClicked = false;
  bool isToggle = false;
  bool isVolume = false;
  int seconds = 30;

  void playSound(){
    player.play(AssetSource('countdown_tick.mp3'),);
  }
  void stopSound(){
    player.stop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text("Mindful Meal Timer"),
      ),
      body: Column(
        children: [
          Text('Nom Nom :)',style: TextStyle(fontSize: 25,color: Colors.white),),
          SizedBox(height: 15,),
          Text('You have 10 minutes to eat before the pause\nFocus on eating slowly',style: TextStyle(color: Colors.white),),
        CircularCountDownTimer(
          duration: seconds,
          initialDuration: 0,
          controller: _controller,
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 2,
          ringColor: Colors.grey[300]!,
          ringGradient: null,
          fillColor: Colors.green,
          fillGradient: null,
          backgroundColor: Colors.white,
          backgroundGradient: null,
          strokeWidth: 20.0,
          strokeCap: StrokeCap.round,
          textStyle: TextStyle(
              fontSize: 33.0, color: Colors.black, fontWeight: FontWeight.bold),
          textFormat: CountdownTextFormat.S,
          isReverse: true,
          isReverseAnimation: true,
          isTimerTextShown: true,
          autoStart: false,
          onStart: () {
            debugPrint('Countdown Started');
          },
          onComplete: () {
            debugPrint('Countdown Ended');
          },
          onChange: (String timeStamp) {
            debugPrint('Countdown Changed $timeStamp');
          },
          timeFormatterFunction: (defaultFormatterFunction, duration) {
            if(duration.inSeconds<=5 && isVolume){
              playSound();
            }
            if (duration.inSeconds == 0) {
              stopSound();
              return "Start";
            } else {
              return Function.apply(defaultFormatterFunction, [duration]);
            }
          },
        ),
          CupertinoSwitch(value: isToggle, onChanged: (val){
            setState(() {
              val=isToggle;
              isToggle=!isToggle;
              isVolume = !isVolume;
            });
          }),
          Text("Sounds On",style: TextStyle(color: Colors.white),),
          //counter
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(onPressed: (){
                  setState(() {
                    isClicked=!isClicked;
                  });
                  if(isClicked){
                    _controller.start();
                  }else{
                    _controller.pause();
                  }
                }, child: Text(!isClicked ? 'Start' : 'Pause'))),
          ),
          if(isClicked)Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(onPressed: (){
                  _controller.pause();
                }, child: Text("LET's STOP I'M FULL"))),
          ),
        ],
      ),
    );
  }
}
