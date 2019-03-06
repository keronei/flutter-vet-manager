import 'package:flutter/material.dart';
import './paging/animal.dart';

class Animals extends StatelessWidget {
  final List<Map<String, dynamic>> animals;


  Animals(this.animals ) {}

  Widget _buildAnimalsList(BuildContext context, int position) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(animals[position]['imageUrl']),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child:
            Text(animals[position]['title'], style: TextStyle(
                fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'Oswald'),),
          ),

          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(child: Text("View"), onPressed: (){
                Navigator.pushNamed<String>(context, '/animal/'+position.toString());

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
