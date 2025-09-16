import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:math' as math;


List<Map<String, dynamic>> dailyRoutines = [
  {'label': '😴 Sleep', 'icon': Icons.bedtime, 'isCompleted': false},
  {'label': '🍽️ Eat', 'icon': Icons.restaurant, 'isCompleted': false},
  {'label': '🎮 Play', 'icon': Icons.sports_esports, 'isCompleted': false},
  {'label': '💧 Drink Water', 'icon': Icons.local_drink, 'isCompleted': false},
];

class RoutinesPage extends StatefulWidget {
  const RoutinesPage({Key? key}) : super(key: key);

  @override
  State<RoutinesPage> createState() => _RoutinesPageState();
}

class _RoutinesPageState extends State<RoutinesPage> {
  int completedCount = 0;

  @override
  void initState() {
    super.initState();
    _resetRoutines();
  }

  void _resetRoutines() {
    for (var routine in dailyRoutines) {
      routine['isCompleted'] = false;
    }
    completedCount = 0;
  }

  void _toggleRoutineStatus(int index) {
    setState(() {
      final bool isCurrentlyCompleted = dailyRoutines[index]['isCompleted'];
      dailyRoutines[index]['isCompleted'] = !isCurrentlyCompleted;

      if (!isCurrentlyCompleted) {
        completedCount++;
      } else {
        completedCount--;
      }
    });

    if (completedCount == dailyRoutines.length) {
      _showCongratulationsDialog();
    }
  }

  void _showCongratulationsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('🌟 Congratulations! 🌟'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'You are a real hero!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset('assets/img/nn.png', height: 100),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Awesome!'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF90CAF9),
              Color(0xFF9575CD),
              Color(0xFF4527A0),
            ],
          ),
        ),
        child: Stack(
          children: [
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

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      'Daily Routines',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(blurRadius: 10.0, color: Colors.black26, offset: Offset(3, 3)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Let's complete today's missions together.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 30),

                    Expanded(
                      child: AnimationLimiter(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: dailyRoutines.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: _buildRoutineCard(
                                    label: dailyRoutines[index]['label'],
                                    icon: dailyRoutines[index]['icon'],
                                    isCompleted: dailyRoutines[index]['isCompleted'],
                                    onTap: () => _toggleRoutineStatus(index),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 15),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      'Daily Report',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0.0,
                            end: completedCount / dailyRoutines.length,
                          ),
                          duration: const Duration(milliseconds: 1000),
                          builder: (context, value, child) {
                            return CustomPaint(
                              painter: PieChartPainter(
                                completedCount: value * dailyRoutines.length,
                                totalCount: dailyRoutines.length,
                              ),
                            );
                          },
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

  Widget _buildRoutineCard({
    required String label,
    required IconData icon,
    required bool isCompleted,
    required VoidCallback onTap,
  }) {
    Color cardColor = isCompleted ? Colors.green.shade400 : Colors.blueGrey.shade400;
    Color buttonColor = isCompleted ? Colors.green.shade700 : Colors.white;
    String buttonText = isCompleted ? 'Completed ✅' : '✅ Done';

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: cardColor.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: isCompleted ? Colors.white : Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
      onEnd: () {},
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double completedCount;
  final int totalCount;

  PieChartPainter({required this.completedCount, required this.totalCount});

  @override
  void paint(Canvas canvas, Size size) {
    double sweepAngle = (completedCount / totalCount) * math.pi * 2;
    double startAngle = -math.pi / 2;

    final Paint completedPaint = Paint()..color = Colors.greenAccent.shade700;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle,
      sweepAngle,
      true,
      completedPaint,
    );

    final Paint pendingPaint = Paint()..color = Colors.grey.shade400;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle + sweepAngle,
      (totalCount - completedCount) / totalCount * math.pi * 2,
      true,
      pendingPaint,
    );
  }

  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    return oldDelegate.completedCount != completedCount;
  }
}
