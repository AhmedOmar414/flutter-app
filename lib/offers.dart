import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  final List<Offer> offers = [
    Offer(image: 'assets/images2/offers.png', name: 'كيف احفظ يا استاذ همام'),
    Offer(image: 'assets/images2/offers.png', name: 'كيف احفظ يا استاذ همام'),
    Offer(image: 'assets/images2/offers.png', name: 'كيف احفظ يا استاذ همام'),
    // Add more offers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('العروض')),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: ListView.builder(
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(offers[index].image, width: 250, height: 250),
                  SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50, // Set your desired height
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue, // Set the background color to blue
                        onPrimary: Colors.white, // Set the text color to white
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero, // Set border radius to zero
                        ),
                      ),
                      onPressed: () {
                        // Handle choose button press here
                      },
                      child: Text('اختر'),
                    ),
                  ),
                  SizedBox(height: 40), // Add a SizedBox with height 40px here
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class Offer {
  final String image;
  final String name;

  Offer({required this.image, required this.name});
}