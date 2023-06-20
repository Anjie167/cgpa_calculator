import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  const CountdownWidget(
      {Key? key, this.width, this.height, this.time, this.color})
      : super(key: key);

  final double? width;
  final double? height;
  final DateTime? time;
  final Color? color;

  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  late Timer _timer;
  late DateTime _targetDateTime;
  Duration _remainingTime = const Duration();
  bool less = false;

  @override
  void initState() {
    super.initState();
    // Set the target date and time for the countdown
    _targetDateTime = widget.time ?? DateTime.now();
    // Start the countdown timer
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        // Calculate the remaining time
        _remainingTime = _targetDateTime.difference(DateTime.now());
      });
      if (_remainingTime.inSeconds <= 0) {
        // Countdown reached zero, cancel the timer
        setState(() {
          less = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 50,
      width: widget.width ?? 200,
      decoration: BoxDecoration(
        border: Border.all(
            color: less ? Colors.red : (widget.color ?? Colors.white)),
        borderRadius: BorderRadius.circular(20.0),
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${(_remainingTime.toString().contains("-") && _remainingTime.inDays == 0) ? "-" : ""}${_remainingTime.inDays} Days',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color:
              less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
            ),
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color:
            less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
          ),
          Text(
            '${_remainingTime.inHours % 24} Hrs',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color:
              less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
            ),
          ),
          Container(
            width: 1,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            color:
            less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
          ),
          Text(
            '${_remainingTime.inMinutes % 60} Min',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color:
              less ? Colors.red : (widget.color ?? const Color(0xFFC57979)),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {


  List<String> images = [
    'https://c8.alamy.com/comp/GNB27H/abstract-crystal-random-shape-big-super-sale-banner-design-vector-GNB27H.jpg',
    'https://i.stack.imgur.com/Rwk3J.jpg',
    'https://us.123rf.com/450wm/mayanko/mayanko2007/mayanko200700011/150808851-colored-different-school-supplies-on-yellow-paper-background-back-to-school-background-flat-lay.jpg?ver=6',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 200.0,
      width: widget.width ?? 700.0,
      child: CarouselSlider(
        options: CarouselOptions(
          height: widget.height ?? 200.0,
          autoPlay: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
        ),
        items: images.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}