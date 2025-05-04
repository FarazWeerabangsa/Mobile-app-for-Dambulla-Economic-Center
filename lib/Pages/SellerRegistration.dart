import 'package:dec_app/Pages/SellerLogin.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'homeScreen.dart';

class SellerRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SignUpScreen());
  }
}

class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  //Define karanawa variable tika firebase ekata danna

  final FullNameController = TextEditingController();
  final ShopNameController = TextEditingController();
  final ShopRegNumController = TextEditingController();
  final PhnoController = TextEditingController();
  final NICController = TextEditingController();
  final EmailController = TextEditingController();
  final PWDController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'වෙළදසැල් හිමිවරයෙකු ලෙස ලියාපදිංචිය.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Image.asset('assets/images/signup_image.png', height: 150),
                SizedBox(height: 30),
                Text(
                  'ඔබගේ තොරතුරු ලබා දෙන්න.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: FullNameController,
                  decoration: InputDecoration(
                    labelText: 'සම්පූර්ණ නම',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: ShopNameController,
                  decoration: InputDecoration(
                    labelText: 'වෙළදසැලේ නම',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: ShopRegNumController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'වෙළදසැල් ලියාපදිංචි අංකය',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: PhnoController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'දුරකථන අංකය ඇතුලත් කරන්න.',
                    hintText: '07X-XXX-XXXX',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: NICController,
                  decoration: InputDecoration(
                    labelText: 'ජාතික හැදුනුම්පත් අංකය ඇතුලත් කරන්න.',
                    hintText: '20012800000V',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: EmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'විද්‍යුත් ලිපිනය ඇතුලත් කරනන. ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: PWDController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'නව මුරපදයක් ඇතුලත් කරන්න.',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        CollectionReference collRef = FirebaseFirestore.instance
                            .collection("SellerReg");
                        collRef.add({
                          'Email': EmailController.text,
                          'Full Name': FullNameController.text,
                          'NIC': NICController.text,
                          'PWD': PWDController.text,
                          'Shop Name': ShopNameController.text,
                          'Shop Reg Num': ShopRegNumController.text,
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("සාර්ථකයි!"),
                              content: Text("ඔබේ දත්ත සාර්ථකව යවා ඇත."),
                              actions: [
                                TextButton(
                                  child: Text("හරි"),
                                  onPressed: () {
                                    //Closed Cutton eka
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/menu',
                                    ); //Home Page ekata redirect karanawa
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        EmailController.clear();
                        FullNameController.clear();
                        NICController.clear();
                        PWDController.clear();
                        ShopNameController.clear();
                        ShopRegNumController.clear();

                        Navigator.pushReplacement(
                          //Redirect Karanna thiyenne page ekata
                          context,
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                        );
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Upload failed: $error')),
                        );
                      }
                    },
                    child: Text(
                      'ලියාපදිංචි කරන්න',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerloginPage(),
                      ),
                    );
                  },
                  child: Text('ගිණුමක්‌ තීබේද? මෙතන ක්ලික් කරන්න.'),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
