import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'stories_page.dart';
import 'routines_page.dart';
import 'activities_page.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB3E5FC), // Light Blue
              Color(0xFFCE93D8), // Light Purple
              Color(0xFFF48FB1), // Light Pink
            ],
          ),
        ),
        child: Stack(
          children: [
            // Animated bubbles/stars (decorative elements)
            Positioned(
              top: 50,
              left: 30,
              child: _buildFloatingIcon(Icons.star, Colors.yellow, 1.5, 5000),
            ),
            Positioned(
              bottom: 100,
              right: 20,
              child: _buildFloatingIcon(Icons.bubble_chart, Colors.purple, 1.2, 4000),
            ),
            Positioned(
              top: 200,
              right: 50,
              child: _buildFloatingIcon(Icons.favorite, Colors.pink, 1.0, 6000),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [

                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    const SizedBox(height: 20),


                    const Text(
                      'Kidddy',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black26,
                            offset: Offset(3, 3),
                          ),
                        ],
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 10),


                    const Text(
                      'Hello, little hero! Your next adventure awaits you!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 50),


                    AnimationLimiter(
                      child: Column(
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 375),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                          children: [
                            _buildActionCard(
                              context,
                              icon: Icons.auto_stories,
                              label: 'Stories',
                              color: Colors.lightBlue,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _buildPageRoute(const StoriesPage()),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildActionCard(
                              context,
                              icon: Icons.access_time_filled,
                              label: 'Routines',
                              color: Colors.purple,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _buildPageRoute(const RoutinesPage()),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                            _buildActionCard(
                              context,
                              icon: Icons.family_restroom,
                              label: 'Activities',
                              color: Colors.pink,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  _buildPageRoute(const ActivitiesPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Animation for decorative floating icons
  Widget _buildFloatingIcon(IconData icon, Color color, double size, int duration) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: duration),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (0.5 - (value - 0.5).abs())),
          child: Opacity(
            opacity: value,
            child: Icon(
              icon,
              color: color.withOpacity(0.5),
              size: size * 40,
            ),
          ),
        );
      },
      onEnd: () {
        // Re-start animation
      },
    );
  }

  // Action card with a bouncing animation on tap
  Widget _buildActionCard(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 1.0, end: 1.0),
        duration: const Duration(milliseconds: 100),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 8,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: color.withOpacity(0.8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom page route for slide-up transition
  PageRouteBuilder _buildPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeOut;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}