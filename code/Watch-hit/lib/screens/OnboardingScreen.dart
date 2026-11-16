import 'package:flutter/material.dart';
import 'package:flutter_project/screens/HomeScreen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;

  final PageController _pageController = PageController(); //Pour swiper entre les slides du carousel

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (currentPage == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            children: [
              // Logo
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.movie_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Watch-HIT',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Slides
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    _buildSlide(
                      icon: Icons.local_movies_outlined,
                      title: 'Garde une trace\nde tes films.',
                      description:
                      'Organise les films que tu as vus '
                          'et ceux que tu veux regarder.',
                    ),
                    _buildSlide(
                      icon: Icons.bookmark_outline,
                      title: 'Sauvegarde tes\nfilms préférés.',
                      description:
                      'Ajoute facilement les films que tu '
                          'souhaites retrouver plus tard.',
                    ),
                    _buildSlide(
                      icon: Icons.star_outline,
                      title: 'Note les films\nque tu regardes.',
                      description:
                      'Donne une note à tes films et garde '
                          'une trace de tes préférences.',
                    ),
                    _buildSlide(
                      icon: Icons.movie_creation_outlined,
                      title: 'Prêt à Plonger\ndans un monde de cinéphile ?',
                      description:
                      'Tout est prêt. Commence ton aventure '
                          'avec Watch-HIT.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Indicateurs
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: currentPage == index
                          ? Colors.white
                          : Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Bouton
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(
                    currentPage == 3 ? 'Commencer' : 'Suivant',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlide({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Illustration
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            size: 90,
            color: Colors.white,
          ),
        ),

        const SizedBox(height: 40),

        // Titre
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            height: 1.15,
          ),
        ),

        const SizedBox(height: 16),

        // Description
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: Colors.grey.shade400,
          ),
        ),
      ],
    );
  }
}