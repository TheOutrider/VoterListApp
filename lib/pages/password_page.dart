import 'package:flutter/material.dart';
import 'package:project_one/pages/splash_page.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  TextEditingController controller = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/elec3.jpg',
          ),
          fit: BoxFit.cover,
        )),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black87,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4)),
                  child: TextField(
                    controller: controller,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility)),
                        label: const Text("Enter password"),
                        fillColor: Colors.white,
                        focusColor: Colors.white),
                  ),
                ),
                ElevatedButton(onPressed: (){
                  if(controller.text == "qaztgbplm"){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> SplashPage()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
     content: Text("Incorrect Password", style: TextStyle(color: Colors.black),),
     backgroundColor: Colors.white,
));
                  }
                }, child: const Text("Submit") ,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                backgroundColor: Colors.green.shade700,textStyle: TextStyle(color: Colors.white)
               )),
                  
              ],
            )
          ],
        ),
      ),
    );
  }
}
