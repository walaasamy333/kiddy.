import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';


const Map<String, dynamic> _articles = {
  'sleep': {
    'title': 'Sleep',
    'icon': Icons.bedtime,
    'short': 'Sufficient sleep is essential for your child\'s healthy growth. Learn about the recommended hours.',
    'long':
    'Sleep is not just rest; it\'s a fundamental time for brain and body growth. Children need more hours of sleep than adults, and these hours vary by age:\n\n'
        '- **Infants (0-3 months):** 14-17 hours per day.\n'
        '- **Toddlers (1-2 years):** 11-14 hours per day.\n'
        '- **Preschoolers (3-5 years):** 10-13 hours per day.\n'
        '- **School-aged (6-13 years):** 9-11 hours per day.\n\n'
        'Make sure to provide a quiet and comfortable environment for your child to help them sleep better.',
  },
  'nutrition': {
    'title': 'Nutrition',
    'icon': Icons.food_bank,
    'short': 'Proper nutrition builds a strong child. Learn about healthy foods and eating habits.',
    'long':
    'Nourishing your child is an investment in their future health. Encourage your child to eat a variety of foods rich in vitamins and minerals:\n\n'
        '- **Fruits and Vegetables:** An excellent source of vitamins and fiber. Make them part of every meal.\n'
        '- **Proteins:** Such as meat, chicken, fish, and eggs. Important for muscle development.\n'
        '- **Whole Grains:** Such as whole-wheat bread and brown rice. Provide sustained energy.\n'
        '- **Dairy Products:** Milk, cheese, and yogurt. Essential for strong bones and teeth.\n\n'
        'Encourage healthy habits like eating slowly and avoiding fast food and sugary drinks.',
  },
  'vaccinations': {
    'title': 'Vaccinations',
    'icon': Icons.local_hospital,
    'short': 'Vaccinations protect your child from serious diseases. Learn about their importance and dates.',
    'long':
    'Vaccination is your child\'s first line of defense against infectious diseases. It works by training the immune system to recognize and fight off germs. Your commitment to the vaccination schedule protects your child and the community from the spread of illnesses.\n\n'
        'It is crucial to follow the vaccination schedule with your pediatrician. Do not hesitate to ask any questions you have about the benefits of vaccines or any concerns you may have.',
  },
  'dental_health': {
    'title': 'Dental Health',
    'icon': Icons.local_florist_rounded,
    'short': 'A beautiful smile starts with healthy habits. Here\'s how to care for your child\'s teeth.',
    'long':
    'Good dental habits should start early. Here are some tips:\n\n'
        '- **Start early:** Clean your baby\'s gums even before the first tooth appears.\n'
        '- **First tooth:** Start brushing with a soft toothbrush and a tiny smear of fluoride toothpaste.\n'
        '- **Healthy diet:** Limit sugary snacks and drinks. Encourage water consumption.\n'
        '- **Regular check-ups:** Visit the dentist regularly to ensure healthy teeth development.',
  },
  'physical_activity': {
    'title': 'Physical Activity',
    'icon': Icons.sports_soccer,
    'short': 'Active play is a key part of growth. Discover fun ways to keep your child moving.',
    'long':
    'Physical activity is vital for a child\'s development. It helps build strong muscles and bones, improves coordination, and boosts confidence. Here are some ideas:\n\n'
        '- **For toddlers:** Simple games like "follow the leader" or dancing to music.\n'
        '- **For older children:** Playing outdoors, riding a bike, or joining a sports team.\n'
        '- **Set a good example:** Join in on the fun and be an active role model for your child.',
  },
  'emotional_wellbeing': {
    'title': 'Emotional Wellbeing',
    'icon': Icons.sentiment_satisfied_alt,
    'short': 'Support your child\'s feelings. Learn how to help them express emotions and build resilience.',
    'long':
    'A child\'s emotional health is just as important as their physical health. Help them navigate their feelings with these simple steps:\n\n'
        '- **Acknowledge feelings:** When your child is sad or angry, say, "I see you\'re feeling sad. It\'s okay to be sad."\n'
        '- **Talk openly:** Create a safe space for them to talk about their day and their feelings.\n'
        '- **Teach problem-solving:** Help them find solutions to small problems, which builds confidence.\n'
        '- **Praise their efforts:** Acknowledge their courage and resilience, not just their achievements.',
  },
};


List<Map<String, dynamic>> _vaccinationSchedule = [
  {
    'age': 'At Birth',
    'vaccines': [
      {'name': 'BCG', 'isDone': false},
      {'name': 'Hepatitis B', 'isDone': false},
    ]
  },
  {
    'age': '2 Months',
    'vaccines': [
      {'name': 'DTP', 'isDone': false},
      {'name': 'Hib', 'isDone': false},
      {'name': 'IPV', 'isDone': false},
      {'name': 'PCV', 'isDone': false},
      {'name': 'Rotavirus', 'isDone': false},
    ]
  },
  {
    'age': '4 Months',
    'vaccines': [
      {'name': 'DTP', 'isDone': false},
      {'name': 'Hib', 'isDone': false},
      {'name': 'IPV', 'isDone': false},
      {'name': 'PCV', 'isDone': false},
      {'name': 'Rotavirus', 'isDone': false},
    ]
  },
  {
    'age': '6 Months',
    'vaccines': [
      {'name': 'DTP', 'isDone': false},
      {'name': 'Hib', 'isDone': false},
      {'name': 'IPV', 'isDone': false},
      {'name': 'PCV', 'isDone': false},
      {'name': 'Rotavirus', 'isDone': false},
      {'name': 'Flu', 'isDone': false},
    ]
  },
  {
    'age': '1 Year',
    'vaccines': [
      {'name': 'MMR', 'isDone': false},
      {'name': 'Varicella', 'isDone': false},
      {'name': 'Hepatitis A', 'isDone': false},
    ]
  },
];

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  // عرض مقال
  void _showArticleDetails(String title, String content, IconData icon) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(icon, size: 30, color: const Color(0xFF42A5F5)),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF42A5F5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  content,
                  style: const TextStyle(fontSize: 16, height: 1.5, color: Colors.black87),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  void _showFirstAidPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 40,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'What to do if my child has a fever?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(height: 20),
                _buildFirstAidStep('🌡️ Take their temperature',
                    'Use a thermometer to measure your child\'s temperature. A reading above 37.5°C is considered a fever.'),
                _buildFirstAidStep('💧 Give plenty of fluids',
                    'Encourage your child to drink water and natural juices to replace lost fluids and prevent dehydration.'),
                _buildFirstAidStep('🧊 Lukewarm compresses',
                    'Place a cloth dampened with lukewarm (not cold) water on the child\'s forehead and under their armpits.'),
                _buildFirstAidStep('🛁 Lukewarm bath',
                    'If the fever is high, a short bath with lukewarm water can help.'),
                _buildFirstAidStep('🚑 When to see a doctor',
                    'If the fever is very high (above 39.5°C) or does not respond to home remedies, or if your child has difficulty breathing or severe lethargy.'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFirstAidStep(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            content,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  // واجهة الصفحة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFE8F5E9),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 28),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: [
                    Icon(Icons.family_restroom, size: 40, color: Color(0xFF42A5F5)),
                    SizedBox(width: 10),
                    Text(
                      'Your Child\'s Health',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF42A5F5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                _buildSectionTitle('Mini Articles'),
                const SizedBox(height: 16),
                _buildMiniArticlesSection(),
                const SizedBox(height: 40),

                _buildSectionTitle('Vaccination Schedule'),
                const SizedBox(height: 16),
                _buildVaccinationSchedule(),
                const SizedBox(height: 40),

                _buildSectionTitle('First Aid'),
                const SizedBox(height: 16),
                _buildFirstAidSection(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildMiniArticlesSection() {
    return AnimationLimiter(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles.values.elementAt(index);
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildArticleCard(
                    title: article['title'],
                    icon: article['icon'],
                    shortText: article['short'],
                    longText: article['long'],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticleCard({
    required String title,
    required IconData icon,
    required String shortText,
    required String longText,
  }) {
    return GestureDetector(
      onTap: () => _showArticleDetails(title, longText, icon),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 40, color: const Color(0xFF42A5F5)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                shortText,
                style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5),
                textAlign: TextAlign.justify,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVaccinationSchedule() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: _vaccinationSchedule.map((entry) {
          final int index = _vaccinationSchedule.indexOf(entry);
          final bool isAllDone =
          (entry['vaccines'] as List).every((v) => v['isDone'] == true);

          return Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: Icon(
                isAllDone ? Icons.check_circle : Icons.radio_button_unchecked,
                color: isAllDone ? Colors.green : Colors.grey,
              ),
              title: Text(
                entry['age'],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              children: [
                ...(entry['vaccines'] as List<Map<String, dynamic>>)
                    .map<Widget>((vaccine) {
                  final int vaccineIndex =
                  (entry['vaccines'] as List).indexOf(vaccine);
                  return CheckboxListTile(
                    title: Text(vaccine['name']),
                    value: vaccine['isDone'],
                    onChanged: (bool? newValue) {
                      setState(() {
                        _vaccinationSchedule[index]['vaccines'][vaccineIndex]
                        ['isDone'] = newValue!;
                      });
                    },
                    activeColor: Colors.green,
                  );
                }).toList(),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFirstAidSection() {
    return GestureDetector(
      onTap: _showFirstAidPopup,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: const Color(0xFFE8F5E9),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.health_and_safety, size: 40, color: Color(0xFF4CAF50)),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  'What to do if my child has a fever?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
