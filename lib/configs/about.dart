import 'package:flutter/material.dart';
import '../util/versaoNomeChangelog.dart';

class About extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(
          title: Text("Sobre"),
          centerTitle: true,
          elevation: 0.0,
        ),

        body: Container(
          padding: EdgeInsets.fromLTRB(6,0,6,5),
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
                
MARTELADO E REFEITO DO ZERO: 
0 X POR ENQUANTO !!!
(Esse Rendeu!!!)       
      ''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),


                Text( '''                     
                                
 Aplicativo criado utilizando 
o Flutter e a linguagem Dart,
usado para testes e aprendizado.       
                     
 Este aplicativo um dia terá 
seu código disponibilizado 
gratuitamente no GitHub e 
talvez adicionado ao F-Droid. 
            
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

