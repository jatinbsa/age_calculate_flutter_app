import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Age Calculator Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  var selectedYear;
  double age=0.0;
  Animation animation;
  AnimationController animationController;
  @override
  void initState() {
    // TODO: implement initState
    animationController=new AnimationController(vsync: this,duration: new Duration(microseconds: 1500));
    animation=animationController;
    super.initState();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();

  }

  void _showPicker(){
    showDatePicker(context: context,
        initialDate: new DateTime(2018),
        firstDate: new DateTime(1900),
        lastDate:DateTime.now()).then((DateTime dt){
          setState(() {
            selectedYear=dt.year;
            calculateAge();
          });
          });
  }

  void calculateAge(){
    setState(() {

      age=(2018-selectedYear).toDouble();
      animation=Tween<double>(begin: animation.value,end: age).animate(new CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn));

      animation.addListener((){
        setState(() {

        });
      });
      animationController.forward();
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Age Calculator"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new OutlineButton(
                onPressed: _showPicker,
              child: new Text(selectedYear!=null?selectedYear.toString():"Select Year Of Birth"),
              borderSide: new BorderSide(color: Colors.black,width: 3.0),
              color: Colors.white,

            ),
            new Padding(padding: const EdgeInsets.all(20.0)),
            new Text("Your age is ${animation.value.toStringAsFixed(0)}",style: new TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic),)
          ],
        ),
      ),
    );
  }
}

