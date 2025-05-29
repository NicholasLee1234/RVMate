import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 163, 214, 127)
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    StatisticsPage(),
    StickersPage(),
    LeaderboardsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        selectedItemColor: Color.fromARGB(255,76,175,80),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: 'Stickers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboards',
          ),
        ],
      ),
    );
  }
}

// Home Page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
  
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0; // Current index state
  String? _selectedImage; // Store the selected image path
  
  void _updateProfilePicture(String imagePath) {
    setState(() {
      _selectedImage = imagePath; // Update the selected image
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
              child: Row(
                children: [
                  Icon(
                    Icons.home
                  ,),
                  Text("  "),
                  Text(
                    "Home",
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Yellow widget
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.only(
                      top: 1.0, bottom: 1.0, right: 16.0, left: 140.0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 255, 231, 111),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: GoogleFonts.inter(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Bob Ross",
                        style: GoogleFonts.bricolageGrotesque(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Are you ready to make a difference today? :)",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // White container for profile picture
                Positioned(
                  left: 16,
                  top: 60,
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 120,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectionPage(
                            onImageSelected: _updateProfilePicture, // Pass callback
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, bottom: 10, right: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: _selectedImage != null
                            ? Image.asset(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : Text(
                                "Choose         Your          Avatar",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Other parts of the HomePage...
            Padding(
              padding: const EdgeInsets.only(top:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded,),
                  Text("  "),
                  Text(
                    "New Events",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Carousel with different images
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  content(context), // Call the updated content method
                  buildIndicator(),
                ],
              ),
            ),
            // RVM Maps
            Padding(
              padding: const EdgeInsets.only(top:30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pin_drop_rounded,),
                  Text("  "),
                  Text(
                    "RVM Locations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            //RVM Maps button
            Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 20, left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse('https://www.hkrvms3.com.hk/en/');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 255, 231, 111),
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Find a Reverse Vending Machine (RVM) Near Me",
                        style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(Icons.pin_drop_rounded,color:Colors.black,size:50)
                  ],
                ))),
            // Subtitle: Recent Activity
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom:10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time,),
                  Text("  "),
                  Text(
                    "Recent Activity",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Recent Activity Rectangles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  buildRectangle("Alex just recycled 2 bottles"),
                  SizedBox(height: 10),
                  buildRectangle("Suan just recycled 3 bottles"),
                  SizedBox(height: 10),
                  buildRectangle("Andy just recycled 1 bottle"),
                ],
              ),
            ),
            // See More Button
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => LeaderboardsPage())
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 106, 139, 83),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "See More",
                  style: TextStyle(fontSize: 18,color: Colors.white, decoration: TextDecoration.underline,decorationColor: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    final List<String> carouselImages = [
      'assets/RVMbanner2.png',
      'assets/parkview_recycling.jpeg',
      'assets/BeachCleanup2.png',
      'assets/BeachCleanup3.png',
    ]; // Updated list for carousel images

    final List<String> carouselURLs = [
      'https://www.hkrvms3.com.hk/en/news',
      'https://www.hongkongparkview.com/sustainability',
      'https://www.instagram.com/p/DGsDQmDNADL/',
      'https://www.plasticfreeseas.org/db-community-beach-cleanup-schedule/',
      
     ];

    return CarouselSlider(
      items: List.generate(carouselImages.length,(index) {
        return GestureDetector(
          onTap: () async {
            Uri url = Uri.parse(carouselURLs[index]);
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(carouselImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.05,
        onPageChanged: (index, reason) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentIndex == index ? Colors.black : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget buildRectangle(String text) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(255,76,175,80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}


class SelectionPage extends StatelessWidget {
  final Function(String) onImageSelected; // Callback to update selected image

  const SelectionPage({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> images = [
      {'id': 1, 'path': 'assets/Common1.png'},
      {'id': 2, 'path': 'assets/Common2.png'},
      {'id': 3, 'path': 'assets/Common3.png'},
      {'id': 4, 'path': 'assets/Common4.png'},
      {'id': 5, 'path': 'assets/Rare1.png'},
      {'id': 6, 'path': 'assets/Rare2.png'},
      {'id': 7, 'path': 'assets/Rare3.png'},
      {'id': 8, 'path': 'assets/Legendary1.png'},
      {'id': 9, 'path':'assets/smiskiCommon1.png'},
      {'id': 10, 'path':'assets/smiskiRare1.png'},
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
              child: Row(
                children: [
                  Icon(
                    Icons.person
                  ,),
                  Text("  "),
                  Text(
                    "Avatars",
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 boxes per row
            crossAxisSpacing: 10.0, // Space between boxes
            mainAxisSpacing: 10.0, // Space between rows
          ),
          itemCount: images.length, // Total number of boxes
          itemBuilder: (context, index) {
            Color borderColor;

            // Set border color based on the ID
            switch (images[index]['id']) {
              case 1:
              case 2:
              case 3:
              case 4:
              case 9:
                borderColor = Colors.blue;
                break;
              case 5:
              case 6:
              case 7:
              case 10:
                borderColor = Colors.green.shade800;
                break;
              case 8:
                borderColor = Colors.yellow;
                break;
              default:
                borderColor = Colors.transparent; // Default case
            }

            return GestureDetector(
              onTap: () {
                onImageSelected(images[index]['path']); // Call the callback
                Navigator.pop(context); // Return to HomePage
              },
              child: Container(
                height: 20, // Set a fixed height for the boxes
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: borderColor, width: 3), // Set border color
                ),
                child: Center(
                  child: Image.asset(
                    images[index]['path'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


class Character {
  final String imagePath;
  final double probability;

  Character(this.imagePath, this.probability);
}

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  final List<FlSpot> _dataPoints = [];
  final List<FlSpot> _dataPointsEmissions = [];
  final TextEditingController _quantityController = TextEditingController();
  DateTime? _selectedDate;
  int totalBottlesRecycled = 0;

  Map<String, int> plasticData = {
    "PET": 0,
    "HDPE": 0,
    "PVC": 0,
    "LDPE": 0,
    "PP": 0,
    "PS": 0,
  };

  String? selectedBottleType;

  final List<Character> characters = [
    Character('assets/Common1.png', 0.15),
    Character('assets/Common2.png', 0.15),
    Character('assets/Common3.png', 0.15),
    Character('assets/Common4.png', 0.15),
    Character('assets/Rare1.png', 0.083),
    Character('assets/Rare2.png', 0.083),
    Character('assets/Rare3.png', 0.083),
    Character('assets/Legendary1.png', 0.05),
    Character('assets/smiskiCommon1.png', 0.15),
    Character('assets/smiskiRare1.png',0.083),
  ];

  final List<String> characterNames =[
    'The RVM',
    'Secret Summer Job',
    'Natural Money-Maker',
    'Recycling is Good!',
    'Bottled Bliss',
    'The Bottle Rocketeer',
    'The Apocalypse',
    'Money, Money, Money',
    'SMISKI Ta-da!',
    'SMISKI Bottle Hugger',
  ];

  final List<String> characterRarities= [
    'Common',
    'Common',
    'Common',
    'Common',
    'Rare',
    'Rare',
    'Rare',
    'Legendary',
    'Common',
    'Rare',
  ];

  final List<String> characterCollections = [
    'Big Waster Collection',
    'Big Waster Collection',
    'Big Waster Collection',
    'Big Waster Collection',
    'Big Waster Collection',
    'Big Waster Collection',
    'Big Waster Collection',
    'Big Waster Collection',
    'Smiski Collection',
    'Smiski Collection',
  ];

  void _addDataPoint() {
    final quantity = int.tryParse(_quantityController.text) ?? 0;

    if (quantity > 0 && _selectedDate != null) {
      totalBottlesRecycled += quantity;

      int dayOfWeek = _selectedDate!.weekday - 1;

      bool exists = false;
      for (int i = 0; i < _dataPoints.length; i++) {
        if (_dataPoints[i].x == dayOfWeek.toDouble()) {
          _dataPoints[i] = FlSpot(dayOfWeek.toDouble(), quantity.toDouble());
          exists = true;
          break;
        }
      }

      if (!exists) {
        _dataPoints.add(FlSpot(dayOfWeek.toDouble(), quantity.toDouble()));
      }


      for (int i = 0; i < _dataPointsEmissions.length; i++) {
        if (_dataPointsEmissions[i].x == dayOfWeek.toDouble()) {
          _dataPointsEmissions[i] = FlSpot(dayOfWeek.toDouble(), quantity*0.224.toDouble());
          exists = true;
          break;
        }
      }

      if (!exists) {
        _dataPointsEmissions.add(FlSpot(dayOfWeek.toDouble(), quantity*0.224.toDouble()));
      }

      if (selectedBottleType != null) {
        plasticData[selectedBottleType!] = plasticData[selectedBottleType!]! + quantity;
      }

      setState(() {
        _quantityController.clear();
        _selectedDate = null;
      });

      // Show the pack selection dialog
      _showPackSelectionDialog();
    }
  }

  Future<void> _showPackSelectionDialog() async {
    final packs = ['Pack 1', 'Pack 2', 'Pack 3', 'Pack 4', 'Pack 5'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select a Pack'),
          content: SizedBox(
            width: double.maxFinite,
            height: 200,
            child: ListView.builder(
              itemCount: packs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(packs[index]),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                    _openPack(); // Open the pack
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _openPack() {
    final character = _getRandomCharacter();
    final characterName = characterNames[characters.indexOf(character)];
    final characterRarity = characterRarities[characters.indexOf(character)];
    final characterCollection = characterCollections[characters.indexOf(character)];
    showDialog(
      context: context,
      barrierDismissible: true, // Allow dismissing by tapping outside
      builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  color: Colors.transparent,
                  width: 0,
                  height: 0,
                ),
                _CharacterDisplay(character: character, characterNames: characterName,characterRarities: characterRarity,characterCollections:characterCollection),
              ],
            ),
          )
        );
      },
    );
  }

  Character _getRandomCharacter() {
    double random = Random().nextDouble();
    double cumulativeProbability = 0.0;

    for (var character in characters) {
      cumulativeProbability += character.probability;
      if (random <= cumulativeProbability) {
        return character;
      }
    }
    return characters.last; // Default fallback
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 6)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _showinstructionsDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'How to Idenitfy the Type of Plastic:',
            style: GoogleFonts.bricolageGrotesque(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Near the bottom (or on the body) of the plastic bottle, there should be a symbol (called the Plastic Resin Identification Code) composed of a a triangle formed by three twisted arrows and a number (from 1-7) enclosed in the triangle.",
                style: GoogleFonts.inter(
                  fontSize: 17
                ),
              ),
              Text(" "),
              Text(
                "Here is how to identify the type of plastic based on the number in the symbol:",
                style: GoogleFonts.inter(
                  fontSize: 17
                ),                
              ), 
              Text(" "),
              Text(
                "1 = PET/PETE (Polyethylene Terephthalate)",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.blueAccent,
                ),),
              Text(
                "2 = HDPE (High-Density Polyethylene)",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.green,
                ),),
              Text(
                "3 = PVC (Polyvinyl Chloride)                 ",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: const Color.fromARGB(255, 201, 152, 5),
                ),),
              Text(
                "4 = LDPE (Low-Density Polyethylene)",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.redAccent,
                ),),
              Text(
                "5 = PP (Polypropylene)                              ",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.purpleAccent,
                ),),
              Text(
                "6 = PS (Polystyrene)                                 ",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Colors.deepPurpleAccent,
                ),),
              Text(
                "7 = Other Plastics (Essentially non-recylable)",
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),),
                
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cashRebate = totalBottlesRecycled * 0.1;

    return Scaffold(
      backgroundColor: Color.fromARGB(255,163,214,127),
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
              child: Row(
                children: [
                  Icon(Icons.bar_chart),
                  Text("  "),
                  Text(
                    "Recycling Statistics",
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Center(
              child: Text(
                "Bottles Recycled:", 
                style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 50,
                      child: Image.asset('assets/plastic_bottle_icon.png'),
                    ),
                    SizedBox(width: 20),
                    Center(
                      child: Text(
                        "$totalBottlesRecycled", 
                        style: const TextStyle(fontSize: 100),
                      ),
                    ),
                    SizedBox(
                      height: 90,
                      width:70
                    ),
                  ],
                ),
              ],
            ),
            const Center(
              child: Text(
                "Cash Rebate",
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
            Center(
              child: Text(
                "\$${cashRebate.toStringAsFixed(1)} HKD", 
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: const Text(
                "Bottles Recycled This Week", 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            
            // Line chart (bottles recycled)
            AspectRatio(
              aspectRatio: 2.0,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0: return const Text('Mon');
                            case 1: return const Text('Tue');
                            case 2: return const Text('Wed');
                            case 3: return const Text('Thu');
                            case 4: return const Text('Fri');
                            case 5: return const Text('Sat');
                            case 6: return const Text('Sun');
                            default: return const Text('');
                          }
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData( 
                      spots: _dataPoints.isNotEmpty ? _dataPoints : [FlSpot(0, 0)],
                      isCurved: false,
                      color: Color.fromARGB(255,76,175,80),
                      barWidth: 4,
                      belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),

            // Updated Pie Chart using fl_chart
            PlasticPieChart(plasticData: plasticData),
            SizedBox(height: 20,),
            
            Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: const Text(
                "Carbon Emission Saved (kg)", 
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),

            // chart for co2 emissions
            AspectRatio(
              aspectRatio: 2.0,
              child: ScatterChart(
                ScatterChartData(
                  minX: 0,
                  maxX: 10,
                  minY: 0,
                  maxY: 10,
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0: return const Text('Mon');
                            case 1: return const Text('Tue');
                            case 2: return const Text('Wed');
                            case 3: return const Text('Thu');
                            case 4: return const Text('Fri');
                            case 5: return const Text('Sat');
                            case 6: return const Text('Sun');
                            default: return const Text('');
                          }
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  scatterSpots: _dataPointsEmissions.isNotEmpty
                    ? _dataPointsEmissions.map((point) => ScatterSpot(
                          point.x,
                          point.y,
                        )).toList()
                    : [ScatterSpot(0, 0)],
                ),
              ),
            ),

            //check out community stats button
            SizedBox(
              child: ElevatedButton(
                onPressed: () async {
                  Uri url = Uri.parse('https//www.youtube.com');
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        "Check Out the Community Statistics",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          ),
                      ),
                    ),
                    Icon(
                      Icons.bar_chart,
                      color: Colors.black,
                      size: 50,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Cash Rebate Section
            Container(
              padding: const EdgeInsets.only(left: 5),
              child: const Row(
                children: [
                Icon(Icons.attach_money),
                Text(
                  "Recent Transactions", 
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                ],
              ),
            ),

            // Additional transaction cards...
            _buildTransactionCard("29 Mar 2025", "+\$0.30 HKD", "3 Plastic Bottles"),
            _buildTransactionCard("28 Mar 2025", "+\$2.20 HKD", "22 Plastic Bottles"),
            _buildTransactionCard("25 Mar 2025", "+\$1.30 HKD", "13 Plastic Bottles"),
            _buildTransactionCard("25 Mar 2025", "+\$0.70 HKD", "7 Plastic Bottles"),

            const Padding(
              padding: EdgeInsets.only(top: 5, left: 10),
              child: Text(
                "View all",
                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 40),
            
            //User input section
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.add_box,),
                  Text("  "),
                  Text(
                    "Add Bottles Recycled",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _quantityController,
                    decoration: const InputDecoration(
                      labelText: 'Quantity of Bottles Recycled',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255,0,90,26))
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255,0,90,26)
                  ),
                  child: const Text(
                    'Pick Date',
                    style:TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            // Dropdown for selecting type of plastic bottle
            Row(
              children: [
                Expanded(
                  child:
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Type of Plastic Bottle'),
                      items: [
                        'PET',
                        'HDPE',
                        'PVC',
                        'LDPE',
                        'PP',
                        'PS',
                      ].map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedBottleType = value;
                        });
                      },
                    ),
                ),
                TextButton(
                  child: Icon(Icons.info_outline,size: 30,color: Color.fromARGB(255,0,90,26),),
                  onPressed: () => _showinstructionsDialog(),
                ),
              ],
            ),
            const SizedBox(height: 16),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255,0,90,26),
              ),
              onPressed: _addDataPoint,
              child: const Text(
                'Submit Data',
                style: TextStyle(
                  color: Colors.white
                )),
            ),

            const SizedBox(height: 20),
          ],
      ),
    ),);
  }

  Card _buildTransactionCard(String date, String amount, String bottleCount) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "RVM receipt No. ########",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      amount,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    bottleCount,
                    style: const TextStyle(color: Colors.green, fontSize: 15, fontWeight: FontWeight.bold),  
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Updated Pie Chart using fl_chart
class PlasticPieChart extends StatelessWidget {
  final Map<String, int> plasticData;

  const PlasticPieChart({super.key, required this.plasticData});

  @override
  Widget build(BuildContext context) {
    final total = plasticData.values.fold(0, (sum, item) => sum + item);
    final pieChartData = plasticData.entries
        .map((entry) {
          return PieChartSectionData(
            value: entry.value.toDouble(),
            color: _getColor(entry.key),
            title: entry.key, // Acronym on the pie chart
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        })
        .toList();

    return Column(
      children: [
        const Text(
          "Types Of Plastic Bottles Recycled",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sections: pieChartData,
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 40,
            ),
          ),
        ),
        const SizedBox(height: 10),

        // Display percentages below the pie chart
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Wrap(
            spacing: 10,
            runSpacing: 5,
            children: plasticData.entries.map((entry) {
              final percentage = total > 0 ? (entry.value / total) * 100 : 0;
              return _LegendItem(
                color: _getColor(entry.key),
                label: "${entry.key} (${percentage.toStringAsFixed(1)}%)",
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Color _getColor(String key) {
    switch (key) {
      case "PET": return Colors.blueAccent;
      case "HDPE": return Colors.green;
      case "PVC": return Colors.amber;
      case "LDPE": return Colors.redAccent;
      case "PP": return Colors.purpleAccent;
      case "PS": return Colors.deepPurpleAccent;
      default: return Colors.grey;
    }
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class _CharacterDisplay extends StatefulWidget {
  final Character character;
  final String characterNames;
  final String characterRarities;
  final String characterCollections;

  const _CharacterDisplay({Key? key, required this.character,required this.characterNames,required this.characterRarities,required this.characterCollections}) : super(key: key);

  @override
  __CharacterDisplayState createState() => __CharacterDisplayState();
}

class __CharacterDisplayState extends State<_CharacterDisplay> {
  double _scale = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0; // Start the scale animation
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 500),
      child:
        Flexible(
          child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.character.imagePath, 
                  width: 250, 
                  height: 250,
                  alignment: Alignment.center,),
                const SizedBox(height: 20),
                Text(
                  "${widget.characterNames}",
                  style: GoogleFonts.inter(
                    color: Colors.white, 
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    ),
                  overflow: TextOverflow.visible,
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${widget.characterCollections} - ${widget.characterRarities}",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400
                  )
                ),
              ],
            ),
        ),
    );
  }
}

//Stickers Page
class StickersPage extends StatelessWidget {
  StickersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
              child: 
                Row(
                  children: [
                    Icon(Icons.emoji_events),
                    Text("  "),
                    Text(
                      "Sticker Index",
                      style: GoogleFonts.bricolageGrotesque(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top:10,bottom:5),
        child: Column(
          children: [
            //Big Waster Collection
            Text(
              "Big Waster", 
              style: GoogleFonts.bricolageGrotesque(fontSize:30,fontWeight: FontWeight.bold),
            ),
            
            GridView.count(
              crossAxisCount: 3, // 3 boxes per row
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildBox(context, Image.asset('assets/Common1.png'), const Id1(), Colors.blue),
                buildBox(context, Image.asset('assets/Common2.png'), const Id2(), Colors.blue),
                buildBox(context, Image.asset('assets/Common3.png'), const Id3(), Colors.blue),
                buildBox(context, Image.asset('assets/Common4.png'), const Id4(), Colors.blue),
                buildBox(context, Image.asset('assets/Rare1.png'), const Id5(), Colors.green.shade800),
                buildBox(context, Image.asset('assets/Rare2.png'), const Id6(), Colors.green.shade800),
                buildBox(context, Image.asset('assets/Rare3.png'), const Id7(), Colors.green.shade800),
                buildBox(context, Image.asset('assets/Legendary1.png'), const Id8(), Colors.yellow),
              ],
            ),

            SizedBox(height: 40,),

            //Smiskis 
            Text(
              "SMISKI", 
              style: GoogleFonts.bricolageGrotesque(fontSize:30,fontWeight: FontWeight.bold),
            ),

            GridView.count(
              crossAxisCount: 3, // 3 boxes per row
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildBox(context, Image.asset('assets/smiskiCommon1.png'), const Id9(), Colors.blue),
                buildBox(context, Image.asset('assets/smiskiblank1.png'), const Id0(), Colors.blue),
                buildBox(context, Image.asset('assets/smiskiblank2.png'), const Id0(), Colors.blue),
                buildBox(context, Image.asset('assets/smiskiblank3.png'), const Id0(), Colors.blue),
                buildBox(context, Image.asset('assets/smiskiRare1.png'), const Id10(), Colors.green.shade800),
                buildBox(context, Image.asset('assets/smiskiblank4.png'), const Id0(), Colors.green.shade800),
                buildBox(context, Image.asset('assets/smiskiblank5.png'), const Id0(), Colors.green.shade800),
                buildBox(context, Image.asset('assets/smiskiblank6.png'), const Id0(), Colors.yellow),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBox(BuildContext context, dynamic content, Widget page, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        color: color,
        height: 100,
        child: Center(
          child: content
        ),
      ),
    );
  }
}

//locked sticker Ids
class Id0 extends StatelessWidget {
  const Id0({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "???";
    const String imagePath = "assets/lock.png";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Sticker IDs
class Id1 extends StatelessWidget {
  const Id1({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "The RVM";
    const String description =
        "This is the RVM right outside Big Waster’s home – it’s only a few minutes walk away and Big Waster always visits it on the way to work! Wait…where is Big Waster?";
    const String imagePath = "assets/Common1.png";
    const String highlightedRarity = "Common";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Common
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Common"
                              ? Colors.blue
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Common"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Common",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Common"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id2 extends StatelessWidget {
  const Id2({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "Secret Summer Job";
    const String description =
        "Oh! Big Waster is working hard inside the RVM; helping everyone process their plastic bottles. Join him in creating a sustainable and clean environment by bringing him YOUR plastic bottles!";
    const String imagePath = "assets/Common2.png";
    const String highlightedRarity = "Common";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Common
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Common"
                              ? Colors.blue
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Common"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Common",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Common"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id3 extends StatelessWidget {
  const Id3({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "Natural Money-Maker";
    const String description = 
        "A cheerful orange creature sporting a colorful hat and holding an ice cream… this must be Big Waster’s younger self! He’s getting money to buy his favourite candy by recycling his plastic bottles! Such a smart kid!";
    const String imagePath = "assets/Common3.png";
    const String highlightedRarity = "Common";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Common
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Common"
                              ? Colors.blue
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Common"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Common",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Common"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id4 extends StatelessWidget {
  const Id4({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "Recycling is Good!";
    const String description = 
        "Flashing a big grin and giving a thumbs-up, Big Waster proudly holds his water bottle while on his way to recycle it at an RVM near him. His infectious positivity is encouraging others to join him in embracing eco-friendly habits with a smile.";
    const String imagePath = "assets/Common4.png";
    const String highlightedRarity = "Common";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Common
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Common"
                              ? Colors.blue
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Common"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Common",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Common"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 170,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id5 extends StatelessWidget {
  const Id5({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "Bottled Bliss";
    const String description = 
        "A mysterious lady has caught Big Waster’s eye! He is now seen snuggling a water bottle with sparkling eyes and is surrounded by hearts; could he be celebrating his love for clean hydration and the joy of saving the planet?";
    const String imagePath = "assets/Rare1.png";
    const String highlightedRarity = "Rare"; // Change this to "Rare" for an orange display

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Rare (Orange)
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Rare"
                              ? Colors.green.shade800
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Rare"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Rare",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Rare"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 140,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id6 extends StatelessWidget {
  const Id6({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "The Bottle Rocketeer";
    const String description = 
        "With a spark of adventure, Big Waster rockets off on a water bottle, flames trailing behind him. He’s ready to explore new heights and follow all the recycled water bottles on their journey to be revived.";
    const String imagePath = "assets/Rare2.png";
    const String highlightedRarity = "Rare"; // Change this to "Rare" for an orange display

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Rare (Orange)
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Rare"
                              ? Colors.green.shade800
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Rare"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Rare",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Rare"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id7 extends StatelessWidget {
  const Id7({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "The Apocalypse";
    const String description = 
        "Under a rain of discarded bottles, Big Waster looks up with wide eyes, sweat trickling down his face. He feels the weight of waste above him, determined to make a change for the environment before he drowns!";
    const String imagePath = "assets/Rare3.png";
    const String highlightedRarity = "Rare"; // Change this to "Rare" for an orange display

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Rare (Orange)
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Rare"
                              ? Colors.green.shade800
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Rare"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Rare",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Rare"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id8 extends StatelessWidget {
  const Id8({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "Money, Money Money";
    const String description = 
        "As dollar bills rain down like confetti, Big Waster beams with joy, reveling in his newfound fortune; his playful spirit shining brightly. If you start recycling plastic bottles at RVMs, YOU could be like him too!";
    const String imagePath = "assets/Legendary1.png";
    const String highlightedRarity = "Legendary"; // Change this to "Legendary" for a gold display

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Legendary (Gold)
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Legendary"
                              ? Colors.yellow
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Legendary"
                                  ? Colors.black
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Legendary",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Legendary"
                                    ? Colors.black
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Smiski character ID pages
class Id9 extends StatelessWidget {
  const Id9({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "Ta-da!";
    const String description =
        r'"Ta-da!" Smiski proudly holds up his squeaky-clean plastic bottle, now he can recycle it! Remember to always empty and rinse your bottles before recycling them!';
    const String imagePath = "assets/smiskiCommon1.png";
    const String highlightedRarity = "Common";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Common
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Common"
                              ? Colors.blue
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Common"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Common",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Common"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Id10 extends StatelessWidget {
  const Id10({super.key});

  @override
  Widget build(BuildContext context) {
    const String characterName = "The Bottle Hugger";
    const String description =
        "You can't possibly be thinking of throwing that bottle into the trash! Smiski won't stand for this, and he's not moving until you put the bottle where it belongs - in the recyling bin!";
    const String imagePath = "assets/smiskiRare1.png";
    const String highlightedRarity = "Rare";

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        title: const Text(
          "Character ID",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Character Image
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10,top: 40),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 350,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 232, 232, 232),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width * 0.7,
                height: 350,
              ),
            ),
            // Character Name
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.circle, size: 7),
                Text(
                  "  $characterName  ",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.circle, size: 7),
              ],
            ),
            // Rarity and Collection
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      // Rare (Orange)
                      Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 10),
                        height: 53,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: highlightedRarity == "Rare"
                              ? Colors.green.shade800
                              : const Color.fromARGB(255, 255, 232, 165),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_activity,
                              color: highlightedRarity == "Rare"
                                  ? Colors.white
                                  : const Color.fromARGB(255, 141, 141, 141),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              "Rare",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: highlightedRarity == "Rare"
                                    ? Colors.white
                                    : const Color.fromARGB(255, 141, 141, 141),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Description
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 130,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Leaderboards Page
class LeaderboardsPage extends StatelessWidget {
  final List<Map<String, dynamic>> leaderboard = [
    {'name': 'Nicholas', 'score': 150},
    {'name': 'Andy', 'score': 120},
    {'name': 'Suan', 'score': 100},
    {'name': 'Andrew', 'score': 90},
    {'name': 'Feifan', 'score': 80},
    {'name': 'Alex', 'score': 50},
    {'name': 'Saadat', 'score': 0}
  ];

  final List<Color> avatarColors = [
    const Color.fromARGB(255, 255, 217, 0),
    const Color.fromARGB(255, 175, 175, 175),
    const Color.fromARGB(255, 219, 90, 30),
    const Color.fromARGB(255, 163, 214, 127),
    const Color.fromARGB(255, 163, 214, 127),
    const Color.fromARGB(255, 163, 214, 127),
    const Color.fromARGB(255, 163, 214, 127),
  ];

  final List<Color> rankingColors = [
    Colors.white,
    Colors.white,
    Colors.white,
    const Color.fromARGB(255, 8, 52, 5),
    const Color.fromARGB(255, 8, 52, 5),
    const Color.fromARGB(255, 8, 52, 5),
    const Color.fromARGB(255, 8, 52, 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 7.0),
              child: 
              Row(
                children: [
                  Icon(Icons.leaderboard),
                  Text("  "),
                  Text(
                    "Leaderboard",
                    style: GoogleFonts.bricolageGrotesque(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),    
      body: ListView.builder(
        itemCount: leaderboard.length,
        itemBuilder: (context, index) {
          final entry = leaderboard[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: avatarColors[index % avatarColors.length],
              child: Text(
                (index + 1).toString(),
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: rankingColors[index % rankingColors.length]
                )),
            ),
            title: Text(
              entry['name'], 
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w600
              )
                ,),
            trailing: Text(
              '${entry['score']} pts',
              style:GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700
              ) ),
          );
        },
      ),
    );
  }
}
