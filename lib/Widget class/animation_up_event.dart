import 'package:flutter/material.dart';
import 'package:quran__academy/Widget%20class/Eventcond.dart';
import 'package:quran__academy/Widget%20class/theme.dart';

class AnimatedEventList extends StatefulWidget {
  @override
  _AnimatedEventListState createState() => _AnimatedEventListState();
}

class _AnimatedEventListState extends State<AnimatedEventList> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    // Animation Controller for smooth scrolling
    _controller = AnimationController(
      duration: Duration(seconds: 10), // Adjust speed here
      vsync: this,
    );

    // Create an animation from the current scroll position to the maximum scroll extent
    _animation = Tween<double>(
      begin: 0.0,
      end: 1000.0, // Max Scroll position, adjust as needed
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear, // Linear scrolling
    ))
      ..addListener(() {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(_animation.value); // Move the scroll position
        }
      });

    // Start auto-scroll animation
    _startAutoScroll();
  }

  void _startAutoScroll() {
    // Start the animation and reset once completed
    _controller.forward().whenComplete(() {
      _controller.reset();
      _startAutoScroll(); // Repeat the scroll once finished
    });
  }

  void _pauseScroll() {
    _controller.stop(); // Pause scrolling
  }

  void _resumeScroll() {
    _controller.forward(); // Resume scrolling
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: AppColors.lightGreen,
          width: 1400,
          height: 400,
          child: ClipRect(
            child: ListView.builder(
              controller: _scrollController,
              physics: NeverScrollableScrollPhysics(), // Prevent manual scrolling
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapDown: (_) => _pauseScroll(), // Pause on touch
                  onTapUp: (_) => _resumeScroll(), // Resume on release
                  child: Eventcond(),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
