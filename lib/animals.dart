import 'package:flutter/material.dart';
import './paging/animal.dart';

class Animals extends StatelessWidget {
  final List<String> animals;

  Animals(this.animals) {}

  Widget _buildAnimalsList(BuildContext context, int position) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset('asset/cat.jpeg'),
          Text(animals[position]),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(child: Text("View"), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>AnimalPage()));
              },)
            ],
          )
        ],

      ),
    );
  }

  Widget _buildWidgetConditionally() {
    return animals.length > 0
        ? ListView.builder(
            itemBuilder: _buildAnimalsList,
            itemCount: animals.length,
          )
        : Center(
            child: Text("Looks like there is no animal yet, just add"),
          );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidgetConditionally();
  }
}
