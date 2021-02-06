import 'package:flutter/material.dart';
import '../util/versaoNomeChangelog.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text("About"),
          centerTitle: true,
          elevation: 0,
        ),

        body: Container(
          padding: const EdgeInsets.fromLTRB(6,0,6,5),
          child: ListView(
              children: <Widget>[

                SizedBox(height: 20),
                Text(versaoNomeChangelog.nomeApp+" " + versaoNomeChangelog.versaoApp,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 25),

                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/avatar.jpg'),
                  ),
                ),

                Text( '''                     
                
HAMMERED AND REDONE:
0 Times !!!
( This is The Way! )  
     
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),


                Text( '''                     
                                
Application created using
Flutter and the Dart language,
used for testing and learning.
            
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    //fontWeight: FontWeight.bold
                  ),
                ),

                Text( ''' 
                      
“Software Engineering is a learning process, 
working code a side effect.” 
            
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ]),
        )
    );

  }
}

