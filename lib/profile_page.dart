import 'package:flutter/material.dart';
import 'package:projet_interactif_widget/profile.dart';


class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() =>ProfilePageState() ;

}

class ProfilePageState extends State<ProfilePage>{

  Profile myprofile = Profile(surname : "Aisha" , name :"seye");
  late TextEditingController surname ;
  late TextEditingController name ;
  late TextEditingController secret ;
  bool showSecret = false ;
  Map<String , bool> hobbies = {
    "Petanque" : false ,
    "Fottball" : false ,
    "Basket" : false ,
    "Code" : false ,
    "Manga" : false,
    "Food" : false ,
   };



  @override
  void initState() {
    // TODO: implement initState
    surname = TextEditingController();
    name = TextEditingController();
    secret = TextEditingController();
    surname.text = myprofile.surname! ;
    name.text = myprofile.name! ;
    secret.text = myprofile.secret! ;


    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    surname.dispose();
    name.dispose();
    secret.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: AppBar(title: Text("mon profile")),
    body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Card(
            color: Colors.purple.shade100,
            child : Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),

              child: Column(
                children: [Text(myprofile.setName()),
                  Text( "Age : ${myprofile.setAge()}"),
                  Text( "Height : ${myprofile.setHeight()}"),
                  Text( "gender : ${myprofile.genderString()}"),
                  Text( "hobbies : ${myprofile.setHobbies()}"),
                  Text( "langage de prog : ${myprofile.favoriteLang}"),
                  ElevatedButton(
                    onPressed: UpdateSecret,
                    child: Text((showSecret)?"Cacher secret": "Montrer secret" )
                  ),
                  (showSecret) ? Text(myprofile.secret!) : Container(height: 0,width: 0,),
                 
                ],
            ),
            ),    
          ),
          Divider(thickness: 2, color: Colors.deepPurpleAccent,),
          myTitle("Modifier les infos"),
          myTextField(controller: surname, hint: "Entrer votre prenom"),
          myTextField(controller: name, hint: "Entrer votre nom"),
          myTextField(controller: secret, hint: "Dites nous un secret", isSecret: true),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("genre : ${myprofile.genderString()}"),
              Switch(value: myprofile.gender!, onChanged: ((newBool){
              setState(() {
              myprofile.gender = newBool ;
              });
              })),
              
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Taille: ${myprofile.setHeight()}"),
              Slider(value: myprofile.height!, onChanged: ((newHeight){
                setState(() {
                  myprofile.height = newHeight ;
                });
              }))
            ],
              
          ),
          Divider(color : Colors.deepPurpleAccent, thickness:2),
          myHobbies(),

        ],
      ),
    ),
   );

  }

  TextField myTextField ( { required TextEditingController controller , required String hint , bool isSecret = false}){
    return TextField(
      controller: controller ,
      decoration : InputDecoration(
        hintText: hint , 
      ),
      obscureText: isSecret,
      onSubmitted: ((newValue){
        //print(newValue);
        //print(controller.text);
        UpdateUser();
      }),
    );

  }

  UpdateUser(){
    setState(() {
      Profile(
        surname: (surname.text != myprofile.name) ?surname.text :myprofile.surname ,
        name :  (name.text != myprofile.name) ?name.text :myprofile.name , 
        secret :  (secret.text != myprofile.secret) ?secret.text :myprofile.secret , 
      );
    });
  }

  UpdateSecret(){
    setState(() {
      showSecret = ! showSecret ;
    });
  }

  Column myHobbies(){
    List<Widget> widgets = [myTitle("Mes hobbies")];
    hobbies.forEach((hobby , like){
     Row r = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(hobby),
          Checkbox(value: like, onChanged: (newBool){ 
            setState(() {
              hobbies[hobby] = newBool ?? false ;
              List<String> str = [];
              hobbies.forEach((key, value) {
                if(value == true){
                  str.add(key);
                }
              });
              myprofile.hobbies = str ;
            }); 
                    
          }),

        ],

      );
      widgets.add(r);

    });
    return Column(
      children:  widgets,
    

    );
  }
  
  Row myRadios(){
    List<Widget> w = [myTitle("Langage prefere")];
    List<String>  langs= ["Dart", "Swift", "kotlin"];
    int index = langs.indexWhere((lang) => lang.startsWith(myprofile.favoriteLang!));
    for (var x =0  ; x< langs.length ; x++){
      Column c = Column(
        children: [
          Text(langs[x]),
          Radio(value: x, groupValue: index, onChanged: (newVlaue){
            setState(() {
              myprofile.favoriteLang = langs[newVlaue as int] ;
            });
          })
          ],
      );

      w.add(c);
    }
    return Row(
      children: w,
    );
  }

  Text myTitle(String text){
    return Text(
              text ,
              style: const TextStyle(
                color: Colors.deepPurpleAccent ,
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            );
  }
  

}