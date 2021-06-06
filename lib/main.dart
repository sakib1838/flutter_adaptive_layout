import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_layout/person.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Adaptive Layout'),
        ),
        body: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

List<Person> person = new List<Person>();
void addItems(){
  person.add(new Person('Sak','SE','01884246427'));
  person.add(new Person('Rak','BA','01792208949'));
  person.add(new Person('Sam','MDL','0152152270'));
  person.add(new Person('Max','TF','01445686548'));
}

class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(){
    addItems();
  }



  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints){
        if(constraints.maxWidth>600){
          return WideLayout();
        }else{
          return NarrowLayout();
        }
      },

    );
  }
}

class PeopleList extends StatelessWidget {
  final void Function(Person) onPersonTap;
  const PeopleList({@required this.onPersonTap,Key key}) : super(key: key);

  Widget PersonItem(BuildContext context, int index){
    return GestureDetector(
       onTap: ()=> onPersonTap(person[index]),

      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PersonDetail(person[index])),);

      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(person[index].name),
              Text(person[index].work),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.builder(
        itemBuilder: (context,index)=>PersonItem(context,index),
        itemCount: person.length,

      ),
    );
  }
}


class WideLayout extends StatefulWidget {
  const WideLayout({Key key}) : super(key: key);

  @override
  _WideLayoutState createState() => _WideLayoutState();
}

class _WideLayoutState extends State<WideLayout> {
  Person _person;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          flex: 2,
          child: PeopleList(onPersonTap: (person){
            setState(() {
              _person = person;
            });
              },
            ),
        ),
        Expanded(
          flex: 3,
            child:_person==null? Placeholder(): PersonDetail(_person),
        ),

      ],
    );
  }
}


class NarrowLayout extends StatelessWidget {
  const NarrowLayout({Key key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      child: PeopleList(
        onPersonTap: (person)=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=> PersonDetail(person)),
        ),
      ),
    );
  }
}



class PersonDetail extends StatelessWidget {
  final Person person;
  const PersonDetail(this.person,{Key key}) : super(key: key);
  //PersonDetail(this.person);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Container(
              width: 200,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(person.name),
                  Text(person.work),
                  Text(person.phone),
                  ElevatedButton(onPressed: (){}, child:
                  Text('Contact Me'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




