import 'package:flutter/material.dart';
import 'package:unilodge/core/configs/assets/app_images.dart';
import 'package:unilodge/presentation/profile/widgets/textRow.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Center(
              child: Container(
                width: 350,
                height: 80,
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 179, 179, 179)
                          .withOpacity(0.1), 
                      offset: Offset(0, 4), 
                      blurRadius: 6, // Blur radius of the shadow
                      spreadRadius: 1, // Spread radius of the shadow
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: BoxDecoration(
                            color: Color(0xff2E3E4A),
                            borderRadius: BorderRadius.circular(30)),
                        child: Icon(
                          Icons.person,
                          color: Color(0xFFFFFFFF),
                          size: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(color: Color(0xff434343)),
                          ),
                          Text(
                            "edit profile",
                            style: TextStyle(color: Color(0xff434343)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 350,
              height: 220,
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 179, 179, 179)
                        .withOpacity(0.1), // Shadow color with opacity
                    offset: Offset(0, 4), // Shadow position (x, y)
                    blurRadius: 6, // Blur radius of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextRow(
                        text: "Details",
                        icon: Icon(
                          Icons.person,
                          color: Color.fromARGB(176, 46, 62, 74),
                          size: 25,
                        )),
                        
                    TextRow(
                        text: "Bookings",
                        icon: Icon(
                          Icons.shopping_bag,
                          color: Color.fromARGB(176, 46, 62, 74),
                          size: 25,
                        )),
                    TextRow(
                        text: "Reviews",
                        icon: Icon(
                          Icons.star,
                          color: Color.fromARGB(176, 46, 62, 74),
                          size: 25,
                        )),
                    TextRow(
                        text: "Settings",
                        icon: Icon(
                          Icons.settings,
                          color: Color.fromARGB(176, 46, 62, 74),
                          size: 25,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 130,
              width: 350,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color.fromARGB(255, 252, 225, 225),
                    Color.fromARGB(255, 236, 174, 174),
                    Color.fromARGB(255, 252, 132, 132)
                  ], // Gradient colors
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 179, 179, 179)
                        .withOpacity(0.1), // Shadow color with opacity
                    offset: Offset(0, 4), // Shadow position (x, y)
                    blurRadius: 6, // Blur radius of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, left: 10.0),
                            child: Text(
                              "Need a place to stay?",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Color(0xff2E3E4A),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Find your perfect dorm and book now!",
                              style: TextStyle(
                                color: Color(0xff454545),
                              ),
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text("Book now"),
                              style: TextButton.styleFrom(
                                foregroundColor: Color(0xfffdfdfd),
                                backgroundColor: Color(0xff2E3E4A),
                                minimumSize: Size(150, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12),
                      child: Image.asset(
                        AppImages.findDorm,
                        width: 200,
                        height: 130,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
