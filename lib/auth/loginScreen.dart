import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:point_of_sale/screens/homePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        Flexible(
          flex: 2,
          child: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(26.0),
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                    width: 600,
                  ),
                  const Text(
                    'Point of Sale',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                  Text(
                    "Effortlessly manage inventory with real-time \ntracking and Firebase integration for smart business insights",
                    style: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 25,
                        fontFamily: 'Schyler'),
                  ),
                  const SizedBox(
                    height: 300,
                  ),
                  const Text(
                    'Powered By Al-bastie\nVersion 1.3.0',
                    style: TextStyle(fontSize: 20, fontFamily: 'Schyler'),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Center(
            child: SizedBox(
              width: 400,
              child: Wrap(
                alignment: WrapAlignment.start,
                children: [
                  const SizedBox(
                    width: 600,
                  ),
                  const Text(
                    'Login ',
                    style: TextStyle(
                        fontSize: 40, color: Color.fromARGB(255, 161, 47, 214)),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.purple), // Text color
                    cursorColor: Colors.purple, // Cursor color
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                      labelStyle: const TextStyle(
                          color: Colors.purple), // Label text color

                      hintStyle: TextStyle(
                          color: Colors.purple
                              .withOpacity(0.6)), // Hint text color
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple), // Default border color
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple), // Enabled border color
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple), // Focused border color
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.purple), // Text color
                    cursorColor: Colors.purple, // Cursor color
                    decoration: InputDecoration(
                      labelText: 'Enter Password',
                      labelStyle: const TextStyle(
                          color: Colors.purple), // Label text color

                      hintStyle: TextStyle(
                          color: Colors.purple
                              .withOpacity(0.6)), // Hint text color
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple), // Default border color
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple), // Enabled border color
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple), // Focused border color
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () {
                      Get.off(() => const MyHomePage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      height: 60,
                      width: double.infinity,
                      child: const Center(
                          child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 25),
                      )),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/bg.png'),
                              fit: BoxFit.cover)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
