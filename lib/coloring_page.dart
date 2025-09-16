// coloring_page.dart
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'dart:ui' as ui;

// Drawing point data structure
class DrawingPoint {
  final Offset point;
  final Paint paint;

  DrawingPoint({required this.point, required this.paint});
}

// CustomPainter to handle drawing lines on the image
class DrawingCanvas extends CustomPainter {
  final List<List<DrawingPoint?>> lines;

  DrawingCanvas(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      for (int i = 0; i < line.length - 1; i++) {
        if (line[i] != null && line[i + 1] != null) {
          canvas.drawLine(line[i]!.point, line[i + 1]!.point, line[i]!.paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingCanvas oldDelegate) {
    return true;
  }
}

class ColoringPage extends StatefulWidget {
  final String imagePath;

  const ColoringPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  State<ColoringPage> createState() => _ColoringPageState();
}

class _ColoringPageState extends State<ColoringPage> {
  late ConfettiController _confettiController;
  final GlobalKey _globalKey = GlobalKey();
  Color _selectedColor = Colors.red;
  double _strokeWidth = 5.0;
  List<List<DrawingPoint?>> _lines = [];

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _showCongratulations() {
    _confettiController.play();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Awesome job, little artist!')),
    );
  }

  void _clearCanvas() {
    setState(() {
      _lines.clear();
    });
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() {
      _lines.add([
        DrawingPoint(
          point: details.localPosition,
          paint: Paint()
            ..color = _selectedColor
            ..strokeCap = StrokeCap.round
            ..strokeWidth = _strokeWidth,
        )
      ]);
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _lines.last.add(
        DrawingPoint(
          point: details.localPosition,
          paint: Paint()
            ..color = _selectedColor
            ..strokeCap = StrokeCap.round
            ..strokeWidth = _strokeWidth,
        ),
      );
    });
  }

  // A simplified save function (will need external packages for a full solution)
  void _saveImage() async {
    // This part requires more advanced logic and packages like 'image_gallery_saver'
    // For now, it will just show a message.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Image Saved! (Functionality requires additional packages)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coloring Time!'),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearCanvas,
            tooltip: 'Reset',
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveImage,
            tooltip: 'Save',
          ),
        ],
      ),
      body: Stack(
        children: [
          // The image to color
          Center(
            child: Image.asset(widget.imagePath),
          ),

          // The drawing canvas on top of the image
          GestureDetector(
            onPanStart: _handlePanStart,
            onPanUpdate: _handlePanUpdate,
            child: CustomPaint(
              size: Size.infinite,
              painter: DrawingCanvas(_lines),
            ),
          ),

          // Confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 10,
              minBlastForce: 5,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.3,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        color: Colors.white,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Clear/Erase button
              IconButton(
                icon: const Icon(Icons.layers_clear),
                onPressed: () {
                  setState(() {
                    _selectedColor = Colors.white; // Eraser works by using white color
                    _strokeWidth = 20.0;
                  });
                },
                tooltip: 'Eraser',
              ),
              // Color Palette
              _buildColorButton(Colors.red),
              _buildColorButton(Colors.orange),
              _buildColorButton(Colors.yellow),
              _buildColorButton(Colors.green),
              _buildColorButton(Colors.blue),
              _buildColorButton(Colors.indigo),
              _buildColorButton(Colors.purple),
              _buildColorButton(Colors.pink),
              _buildColorButton(Colors.brown),
              _buildColorButton(Colors.grey),
              _buildColorButton(Colors.black),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedColor = color;
          _strokeWidth = 5.0; // Reset stroke width for drawing
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: _selectedColor == color ? Border.all(color: Colors.black, width: 3) : null,
          ),
        ),
      ),
    );
  }
}