import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map/login_screen.dart';

class MainSignUp extends StatelessWidget {
  const MainSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: double.infinity,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12.0),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpVolScreen()));
              },
              child:  Text(
                'Volunteer'.toUpperCase(),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),),
            const SizedBox(width: 5,),
            Expanded(child: ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 12.0),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPassScreen()));
              },
              child:  Text(
                'Passenger'.toUpperCase(),
                style: const TextStyle(fontSize: 16.0),
              ),
            ),),
          ],
        ),
      ),
    );
  }
}

class SignUpVolScreen extends StatelessWidget {
  SignUpVolScreen({Key? key}) : super(key: key);
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController studentId=TextEditingController();
  GlobalKey<FormState> kForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: kForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const  Text('Register',style: TextStyle(color: Colors.grey,fontSize: 25),),
              const SizedBox(height: 40,),
              TextFormField(
                controller: name,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: email,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'email',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: password,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: studentId,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'StudentId',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: phone,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Phone',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  ),
                  onPressed: (){
                    if(kForm.currentState!.validate()){
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim()).
                      then((value){
                        FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set({
                          'Name':name.text,
                          'Email':email.text,
                          'ID':value.user!.uid,
                          'idUser':studentId.text,
                          'password':password.text,
                          'phone':phone.text,
                          'TypeAcc':'User',
                        }
                        ).then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        });});
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


class SignUpPassScreen extends StatelessWidget {
  SignUpPassScreen({Key? key}) : super(key: key);
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController studentId=TextEditingController();
  GlobalKey<FormState> kForm=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: kForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const  Text('Register',style: TextStyle(color: Colors.grey,fontSize: 25),),
              const SizedBox(height: 40,),
              TextFormField(
                controller: name,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: email,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'email',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: password,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: studentId,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'NationalId',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: phone,
                validator: (value){
                  if(value!.isEmpty){
                    return 'Check Data';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Phone',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const  BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                  ),
                  onPressed: (){
                    if(kForm.currentState!.validate()){
                      FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim()).
                      then((value){
                        FirebaseFirestore.instance.collection('Users').doc(value.user!.uid).set({
                          'Name':name.text,
                          'Email':email.text,
                          'ID':value.user!.uid,
                          'idUser':studentId.text,
                          'password':password.text,
                          'phone':phone.text,
                          'TypeAcc':'Dir',
                        }
                        ).then((value){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        });});
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}