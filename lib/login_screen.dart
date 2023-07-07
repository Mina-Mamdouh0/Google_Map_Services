import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:map/button_screen.dart';
import 'package:map/current_loc_div.dart';
import 'package:map/driver_screen.dart';
import 'package:map/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
   TextEditingController email=TextEditingController();
   TextEditingController password=TextEditingController();
  GlobalKey<FormState> kForm=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
         title: const Text('Login'),
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
             const  Text('Login',style: TextStyle(color: Colors.grey,fontSize: 25),),
              const SizedBox(height: 40,),
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
                 FirebaseAuth.instance.signInWithEmailAndPassword(
                     email: email.text.trim(),
                     password: password.text.trim()).then((value){
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ButtonScreen()));
                 });
               }
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 16.0),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPassScreen()));
                  },
                  child: const Text(
                    'Login Passenger',
                    style: TextStyle(fontSize: 16.0),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MainSignUp()));
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




class LoginPassScreen extends StatelessWidget {
  LoginPassScreen({Key? key}) : super(key: key);
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  GlobalKey<FormState> kForm=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text('Login'),
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
              const  Text('Login',style: TextStyle(color: Colors.grey,fontSize: 25),),
              const SizedBox(height: 40,),
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
                      FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: email.text.trim(),
                          password: password.text.trim()).then((value){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CurrentDivLocation()));
                      });
                    }
                  },
                  child: const Text(
                    'Login Passenger',
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
