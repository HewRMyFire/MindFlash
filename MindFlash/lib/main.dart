import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MindFlashApp());
}

class MindFlashApp extends StatelessWidget {
  const MindFlashApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar style
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindFlash',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Top Section (White Background)
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 25),
                  _buildStatsRow(),
                ],
              ),
            ),
          ),

          // Bottom Section (Gradient Background)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF6A5AE0), // Blue-ish Purple
                    Color(0xFF9E55E6), // Purple
                    Color(0xFFFF5DAD), // Pink
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // CENTERED CONTENT
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildEmptyStateIcon(),
                          const SizedBox(height: 20),
                          const Text(
                            "No Decks Yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Create your first deck and start\nyour learning journey!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                          // Visual spacer to balance against the bottom button
                          const SizedBox(height: 60),
                        ],
                      ),
                    ),
                  ),

                  // Floating Bottom Button
                  Positioned(
                    bottom: 40,
                    left: 20,
                    right: 20,
                    child: _buildCreateDeckButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildHeader() {
    return Row(
      children: [
        // App Logo
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF5B4FE6), Color(0xFFE940A3)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6A5AE0).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 24,
          ),
        ),
        const SizedBox(width: 12),
        
        // Title and Subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF5B4FE6), Color(0xFFE940A3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: const Text(
                "MindFlash",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "Master anything, anytime",
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        const Spacer(),
        
        // "How It Works" Button
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, size: 14, color: Colors.grey[800]),
              const SizedBox(width: 4),
              Text(
                "How It Works",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // LEFT CARD
          Expanded(
            child: _buildStatCard(
              title: "Total Decks",
              count: "0",
              icon: Icons.chrome_reader_mode_outlined,
              colors: [
                const Color(0xFF3525AF), // Darker Blue
                const Color(0xFF7B52DD), // Purple
              ],
              shadowColor: const Color(0xFF3525AF),
            ),
          ),
          const SizedBox(width: 12),
          
          // RIGHT CARD
          Expanded(
            child: _buildStatCard(
              title: "Total Cards",
              count: "0",
              icon: Icons.auto_awesome_outlined,
              colors: [
                const Color(0xFF7B52DD), // Purple
                const Color(0xFFE940A3), // Pink
              ],
              shadowColor: const Color(0xFF7B52DD),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required List<Color> colors,
    required Color shadowColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            icon,
            color: Colors.white.withOpacity(0.8),
            size: 32,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Center(
        child: Icon(
          Icons.menu_book_rounded,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildCreateDeckButton() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add, color: Colors.black),
              SizedBox(width: 8),
              Text(
                "Create New Deck",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}