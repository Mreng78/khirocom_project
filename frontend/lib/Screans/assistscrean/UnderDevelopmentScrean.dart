import "package:flutter/material.dart";

class UnderDevelopmentScrean extends StatelessWidget {
  String name;
  UnderDevelopmentScrean({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
      child:
       Padding(padding: const EdgeInsets.all(30),
       child: Column(
        children: [
          Icon(Icons.construction,size: 100,color: Colors.green,),
          Text("مرحبا ${name} ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Text("هذه الصفحة قيد التطوير",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        ],
       )
        )
     ),
    );
  }
}
