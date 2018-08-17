import 'package:flutter/material.dart';

enum GenderList {male, female}

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyFormState();
}

class MyFormState extends State {
  final _formKey = GlobalKey<FormState>();
  GenderList _gender;
  bool _agreement = false;

  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10.0), child: new Form(key: _formKey, child: new Column(children: <Widget>[
      new Text(' Name:', style: TextStyle(fontSize: 20.0),),
      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Please input your name';
      }),

      new SizedBox(height: 20.0),

      new Text(' E-mail:', style: TextStyle(fontSize: 20.0),),

      new TextFormField(validator: (value){
        if (value.isEmpty) return 'Please input your E-mail';

        String p = "[a-zA-Z0-9+.\_\%-+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9-]{0,64}(.[a-zA-Z0-9][a-zA-Z0-9-]{0,25})+";
        RegExp regExp = new RegExp(p);

        if (regExp.hasMatch(value)) return null;

        return 'E-mail is not formatted properly...';
      }),

      new SizedBox(height: 20.0),

      new Text('Gender:', style: TextStyle(fontSize: 20.0),),

      new RadioListTile(
        title: const Text('Male'),
        value: GenderList.male,
        groupValue: _gender,
        onChanged: (GenderList value) {setState(() { _gender = value;});},
      ),

      new RadioListTile(
        title: const Text('Female'),
        value: GenderList.female,
        groupValue: _gender,
        onChanged: (GenderList value) {setState(() { _gender = value;});},
      ),

      new SizedBox(height: 20.0),

      new RaisedButton(onPressed: (){
        if(_formKey.currentState.validate()) {
          Color color = Colors.red;
          String text;

          if (_gender == null) text = 'Select your gender';
            else {text = 'You have successfully completed this form...'; color = Colors.green;}

          Scaffold.of(context).showSnackBar(SnackBar(content: Text(text), backgroundColor: color,));
        }
      }, child: Text('Check'), color: Colors.blue, textColor: Colors.white,),
    ],)));
  }
}

void main() => runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            backgroundColor: Colors.white,
            appBar: new AppBar(title: new Text('Himnark.am'),
            leading: new IconButton(icon: new Icon(Icons.group), onPressed: null),),
            body: new MyForm()

        )
    )
);