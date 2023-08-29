import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.6,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(color: Colors.white),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Color(0xFF674AEF),
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70)),
                  ),
                  child: Center(child: Image.asset('images/1.png', scale: 0.7)),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2.666,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(70)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Welcome to Car Tracker",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                wordSpacing: .5),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                "Allow location access and add your vehical to log the parking spot!",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black.withOpacity(.8),
                                ),
                              ))
                        ],
                      ),
                    )),
              ],
            )));
  }
}
