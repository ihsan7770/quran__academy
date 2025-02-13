import 'package:flutter/material.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _radiusAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller setup (duration set to 1 second for faster animation)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Faster animation (1 second)
    )..repeat(reverse: true);

    // Animation setup for the CircleAvatar size change
    _radiusAnimation = Tween<double>(begin: 55.0, end: 65.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Navigate to home page after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
       Navigator.pushNamed(context, 'Home');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular progress indicator
            SizedBox(
              width: 116, // Slightly larger than the image
              height: 116,
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey[300],
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
            ),
            // Animated CircleAvatar for the image
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CircleAvatar(
                  radius: _radiusAnimation.value,
                  backgroundImage: AssetImage("assets/qa.png"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
