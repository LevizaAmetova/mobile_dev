import 'package:flutter/material.dart';

// DATA_MODEL
class NutritionalFact {
  final String value;
  final String label;
  final String? subLabel; // For %DV

  const NutritionalFact({
    required this.value,
    required this.label,
    this.subLabel,
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Big Mac Nutrition',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
          0xFF2C6C2F,
        ), // Dark green background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C6C2F), // Dark green
          elevation: 0,
        ),
        textTheme: Theme.of(
          context,
        ).textTheme.apply(bodyColor: Colors.white, displayColor: Colors.white),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<NutritionalFact> _nutritionalFacts = <NutritionalFact>[
    const NutritionalFact(value: '550 CAL.', label: 'Calories'),
    const NutritionalFact(
      value: '30G',
      label: 'Total Fat',
      subLabel: '(38% DV)',
    ),
    const NutritionalFact(
      value: '45G',
      label: 'Total Carbs',
      subLabel: '(16% DV)',
    ),
    const NutritionalFact(value: '25G', label: 'Protein'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            // Use SingleChildScrollView to prevent overflow on small screens
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Top Bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16.0,
                    40.0,
                    16.0,
                    16.0,
                  ), // More padding at top for status bar
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Icon(
                        Icons.fastfood,
                        color: Colors.amber,
                        size: 30,
                      ), // McDonald's M-like icon
                      const Text(
                        'Big Mac',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 30,
                      ), // Menu icon
                    ],
                  ),
                ),
                // Burger Image
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Image.network(
                      'https://wallpapers.com/images/hd/caption-a-delicious-whopper-from-burger-king-bbv4vqxednwhvpqa.jpg',
                      height:
                          MediaQuery.of(context).size.height *
                          0.35, // Responsive height
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Navigation Dots/Indicators
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber[700], // Yellow dot for active
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white70, // White dot for inactive
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            2,
                          ), // Small square
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                // Nutritional Information Header
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 16.0,
                  ),
                  child: Text(
                    'NUTRITIONAL INFORMATION',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                // Nutritional Facts Grid - Centered with a maximum width
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 500.0,
                    ), // Limit the maximum width of the facts block
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              _buildNutritionalFactItem(_nutritionalFacts[0]),
                              const SizedBox(
                                width: 24,
                              ), // Spacing between items
                              _buildNutritionalFactItem(_nutritionalFacts[1]),
                            ],
                          ),
                          const SizedBox(height: 30), // Spacing between rows
                          Row(
                            children: <Widget>[
                              _buildNutritionalFactItem(_nutritionalFacts[2]),
                              const SizedBox(
                                width: 24,
                              ), // Spacing between items
                              _buildNutritionalFactItem(_nutritionalFacts[3]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Extra space at bottom
              ],
            ),
          ),
          // CALCULATOR text on the right side
          Positioned(
            right:
                -40, // Adjust position to be partially off-screen for visual effect
            top:
                MediaQuery.of(context).size.height * 0.6, // Position vertically
            child: RotatedBox(
              quarterTurns: 1, // Rotate 90 degrees clockwise
              child: Text(
                'CALCULATOR',
                style: TextStyle(
                  color: Colors.yellow[700], // Yellowish color
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build individual nutritional fact items
  Widget _buildNutritionalFactItem(NutritionalFact fact) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment
            .center, // Centering the content within each fact item
        children: <Widget>[
          Text(
            fact.value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            fact.label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          if (fact.subLabel != null)
            Text(
              fact.subLabel!,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
        ],
      ),
    );
  }
}
