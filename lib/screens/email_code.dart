import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vegi/screens/tabs_page.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  ///the boolean to handle the dynamic operations
  bool submitValid = false;

  ///testediting controllers to get the value from text fields
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _otpcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  ///a void function to verify if the Data provided is true
  void verify() {
    var snackBar = SnackBar(
      content: Text('verify'),
      duration: const Duration(seconds: 1),
    );
    var snackBar1 = SnackBar(
      content: Text('verification failed'),
      duration: const Duration(seconds: 1),
    );

    var res = EmailAuth.validate(
        receiverMail: _emailcontroller.value.text,
        userOTP: _otpcontroller.value.text);
    if (res) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TabsPage()));
      setState(() async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailcontroller.value.text);
      });


    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);

    }
  }

  ///a void funtion to send the OTP to the user
  void sendOtp() async {
    var snackBar = SnackBar(
      content: Text('Code has been send'),
      duration: const Duration(seconds: 4),
    );
    EmailAuth.sessionName = "Food Inc";
    bool result =
        await EmailAuth.sendOtp(receiverMail: _emailcontroller.value.text);
    if (result) {
      setState(() {

        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        submitValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify E-mail'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Lottie.asset('assets/images/lottie1.json'),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: 'Enter Email',
                        labelText: 'Email',
                        suffixIcon: TextButton(
                          child: Text('Send Code'),
                          onPressed: () => sendOtp(),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _otpcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter Code',
                      labelText: 'Code',
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () => verify(), child: Text('Verify Code'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
