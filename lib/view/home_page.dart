import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  centerTitle: false,
  automaticallyImplyLeading: false,
  titleSpacing: 0, // Removes default spacing from the start
  title: Row(
    children: [
      SizedBox(width: 8), // Optional small left padding
      Text(
        'Home',
        style: TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontFamily: 'Poppins Bold',
        ),
      ),
    ],
  ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_none, color: Color(0xFFD9534F)),
          onPressed: () {
            // Add your notification logic here
          },
        ),
      ],
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/newarival.png',
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: _buildLabelCard(
                        'New Arrival',
                        'assets/images/armcuff.png',
                      ),
                    ),
                    SizedBox(width: 12),
                    Flexible(
                      flex: 1,
                      child: _buildLabelCard(
                        'Best Seller',
                        'assets/images/waist.png',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Top Categories',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildCategoryImage('assets/images/earing.png'),
                      _buildCategoryImage('assets/images/bracelet.png'),
                      _buildCategoryImage('assets/images/tradnecklace.png'),
                      _buildCategoryImage('assets/images/necklace.png'),
                      _buildCategoryImage('assets/images/rings.png'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _buildProductSection("Best Seller", [
                  'assets/images/earing1.jpg',
                  'assets/images/heart.png',
                  'assets/images/dia.jpg',
                  'assets/images/necklace1.jpg',
                ]),
                SizedBox(height: 10),
                _buildProductSection("Flash Sale Upto 70% off ", [
                  'assets/images/jhumka.png',
                  'assets/images/waist.png',
                  'assets/images/jhumka1.jpg',
                ]),
                SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (_) => ExploreAllPage()));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore All',
                          style: TextStyle(
                            color:  Color(0xFFD9534F),
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward,
                          color:  Color(0xFFD9534F),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelCard(String title, String imagePath) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(2, 4),
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              imagePath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                color:  Color(0xFFD9534F),
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryImage(String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 6),
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildProductSection(String title, List<String> imagePaths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                width: 130,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(imagePaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}