import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Register_Services{

  void resgidterData(String name,String email,String password,String mobile){

    final datarefrence = FirebaseDatabase.instance.reference();

    final key = datarefrence.child("Users").push().key;
    
    datarefrence.child("Users").child(key!).set({
      'id' : key,
      'name' : name,
      'email' :email,
      'password' : password,
      'mobile' : mobile
    });

  }

}