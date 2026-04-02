import 'package:flutter/material.dart';

class Errorscreen extends StatelessWidget{
  String error;
  int? errorcode;
  Errorscreen({required this.error,this.errorcode});
  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud_off,size: 100,color: Colors.red,),
          Text(error),
          Text(errorcode.toString()),
          ElevatedButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Back"))
        ],
      ),
    ),
  );
  }

}