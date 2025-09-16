import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'story_player_page.dart';

class StoriesPage extends StatelessWidget {
  const StoriesPage({Key? key}) : super(key: key);

  final List<Map<String, String>> storiesData = const [
    {
      'title': 'Zain & Zina',
      'arabic_title': 'زين و زينة',
      'description': 'About cheating',
      'video_path': 'assets/vidio/b1.mp4',
      'coloring_image_path': 'assets/img/b3.png',
      'image_path': 'assets/img/c1.png',
    },
    {
      'title': 'SpongeBob',
      'arabic_title': 'سبونج بوب',
      'description': 'Fun & laughter',
      'video_path': 'assets/vidio/b2.mp4',
      'coloring_image_path': 'assets/img/b2.png',
      'image_path': 'assets/img/c2.png',
    },
    {
      'title': 'Allah Sees Us',
      'arabic_title': 'الله يرانا',
      'description': 'Islamic moral story',
      'video_path': 'assets/vidio/b3.mp4',
      'coloring_image_path': 'assets/img/b4.png',
      'image_path': 'assets/img/c3.png',
    },
    {
      'title': 'The Elephant Story',
      'arabic_title': 'قصة الفيل',
      'description': 'The Islamic',
      'video_path': 'assets/vidio/b4.mp4',
      'coloring_image_path': 'assets/img/b1.png',
      'image_path': 'assets/img/c4.png',
    },
    {
      'title': 'The Greedy Mouse',
      'arabic_title': 'الفار الطماع',
      'description': 'Greedy mouse',
      'video_path': 'assets/vidio/b5.mp4',
      'coloring_image_path': 'assets/img/b5.png',
      'image_path': 'assets/img/c5.png',
    },
    {
      'title': 'The 3 Fish',
      'arabic_title': '3 سمكات',
      'description': 'Not listening to mom',
      'video_path': 'assets/vidio/b6.mp4',
      'coloring_image_path': 'assets/img/b6.png',
      'image_path': 'assets/img/c6.png',
    },
    {
      'title': 'Coming Soon',
      'arabic_title': 'قريبًا',
      'description': 'New adventures await!',
      'video_path': '',
      'coloring_image_path': '',
      'image_path': 'assets/img/c7.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB3E5FC),
              Color(0xFFCE93D8),
              Color(0xFFF48FB1),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // تم إضافة زر الرجوع هنا
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 28),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const Text(
                      'Kiddy',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2.0,
                        shadows: [
                          Shadow(
                            blurRadius: 5.0,
                            color: Colors.black26,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hello, little hero, choose a new story!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: AnimationLimiter(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: storiesData.length,
                      itemBuilder: (context, index) {
                        final story = storiesData[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: 2,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: _buildStoryCard(
                                context,
                                title: story['title']!,
                                description: story['description']!,
                                imagePath: story['image_path']!,
                                storyData: story,
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildStoryCard(BuildContext context, {
    required String title,
    required String description,
    required String imagePath,
    required Map<String, String> storyData,
  }) {

    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 100),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 8,
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (storyData['video_path']!.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StoryPlayerPage(storyData: storyData),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Coming Soon!')),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imagePath,
                    height: 100,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}