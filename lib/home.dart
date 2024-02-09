import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/slider_service.dart';
import 'package:flutter_application_1/courses.dart';
import 'package:flutter_application_1/library.dart';
import 'package:flutter_application_1/login_screen.dart';
import 'package:flutter_application_1/offers.dart';
import 'package:flutter_application_1/sign_up.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _ThirdState();
}

class _ThirdState extends State<Home> {
  _launchURLFb() async {
  Uri url = Uri.parse('https://www.facebook.com/groups/538791984160744');
  if (await canLaunch(url.toString())) {
    await launch(url.toString());
  } else {
    throw 'Could not launch $url';
  }
}

   _launchURLWp() async {
  var whatsappUrl = "whatsapp://send?phone=00962797848483&text=${Uri.parse('السلام عليكم')}";
  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}
   _launchURLWP() async {
    Uri url = Uri.parse('https://al-maher.net/libs.pdf');
    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'Could not launch $url';
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // Set this to change the AppBar height
        child: AppBar(
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5, // 50% of screen width
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                                Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                              );            },
                  child: Text('انشاء حساب', style: TextStyle(fontSize:18)),
                ),
                Container(
                  width: 100, // Set this to change the image width
                  child: Image.asset('assets/images2/1024.png', fit: BoxFit.cover),
                ),
                TextButton(
                  onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                              );            },
                  child: Text('تسجيل الدخول',style: TextStyle(fontSize:18)),
                ),
              ],
            ),
          ),
        ),
      ),

      ),
        body: Center(
          child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color.fromARGB(255, 5, 134, 209), // Change this color to change the border color
              width: 3, // Change this to adjust the width of the border
            ),
            borderRadius: BorderRadius.circular(10), // ChanCoursesge this to adjust the border radius
          ),

        child: ListView(
          children: [
            Center(
              child: Column(
                children: <Widget>[
                  FutureBuilder<List<SliderItem>>(
                    future: SliderService().fetchSliders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CarouselSlider(
                          options: CarouselOptions(
                            height: 400,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 5),
                            viewportFraction: 1.0,
                            aspectRatio: 2.0,
                            pageSnapping: true,
                            onPageChanged: (index, _) {},
                            enlargeCenterPage: true,
                          ),
                          items: snapshot.data!.map((slider) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: SizedBox(
                                width: 900,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.network(
                                    slider.image,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const CircularProgressIndicator();
                    }
                  ),
                
                    SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoursesPage()),
                        );
                    },
                    child: const Text('الدورات',
                        style: TextStyle(color: Colors.indigo, fontSize: 25)),
                  ),
                  Image.asset(
                    'assets/images2/course.png',
                    width: 200,
                    height: 250,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.indigoAccent,
                    height: 5,
                  ),
                  SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                       Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OffersPage()),
                        );
                    },
                    child: const Text('العروض',
                        style: TextStyle(color: Colors.indigo, fontSize: 25)),
                  ),
                  Image.asset(
                    'assets/images2/offers.png',
                    width: 200,
                    height: 250,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.indigoAccent,
                    height: 5,
                  ),
                  SizedBox(height: 15),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LibraryPage()),
                        );
                    },
                    child: const Text('المكتبة',
                        style: TextStyle(color: Colors.indigo, fontSize: 25)),
                  ),
                  Image.asset(
                    'assets/images2/files.png',
                    width: 200,
                    height: 250,
                  ),
                  Container(
                    width: double.infinity,
                    color: Colors.indigoAccent,
                    height: 5,
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),

            Center(
              child:Row(

                mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 20,),

                InkWell(
                onTap: _launchURLFb,
                child: const Text(
                  'حساب الفيسبوك',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                  ),
                ),
              ),
                const SizedBox(width: 8,),
                Image.asset(
                  'assets/images2/fb.png',
                  width: 35,
                  height: 35,
                ),

                const SizedBox(width: 100,),

                InkWell(
                  onTap: () async => await launch(
         "https://wa.me/${00962797848483}?text=السلام عليكم أريد طلب بطاقة"),
                  child: const Text(
                    'اطلب البطاقة',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(width: 8,),
                Image.asset(
                  'assets/images2/whts.png',
                  width: 35,
                  height: 35,
                )


      ]
      
            )
            ),
            SizedBox(height: 15),
              ElevatedButton(
                onPressed: _launchURLWP,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // This is the background color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // This makes the button corners have zero radius
                  ),
                  minimumSize: Size(
                    MediaQuery.of(context).size.width, // This makes the button have the full width of the page
                    70, // This is the height of the button
                  ),
                ),
                child: Text('أماكن توزيع بطاقات الماهر', style: TextStyle(color: Colors.white,fontSize: 20)), // This is the text inside the button
              ),
                          
          ],
            )
        ),
        ),
      ),
    );
  }
}