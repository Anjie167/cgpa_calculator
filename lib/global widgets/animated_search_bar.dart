import 'package:flutter/material.dart';

import '../utils/colors.dart';


class AnimatedSearchBar extends StatefulWidget {
  const AnimatedSearchBar({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  State<AnimatedSearchBar> createState() => _AnimatedSearchBarState();
}

class _AnimatedSearchBarState extends State<AnimatedSearchBar> with SingleTickerProviderStateMixin {
  AnimationController? _controller;


  Animation<double>? animation;
  bool isForward = false;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);

    final curvedAnimation = CurvedAnimation(parent: _controller!, curve: Curves.easeOutExpo);

    animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation)
    ..addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return  SizedBox(
          width: size.width,
          height: size.height*0.06,
          child: Row(
            children: [
               Container(
                    width: size.height*0.06,
                    height:size.height*0.06,
                    decoration: BoxDecoration(
                      color:kPrimaryBase,
                      borderRadius: animation!.value >0 ?const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        topRight: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                    ): BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 22,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                        if(!isForward){
                          _controller!.forward();
                          isForward = true;
                        }
                        else{
                          _controller!.reverse();
                          isForward = false;
                        }
                      },
                    ),
                  ),
              Container(
                width: size.width*0.7* animation!.value,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 5),
                  child: widget.child,
                ),
              ),
            ],
          ),
        );
  }
}
