import 'package:flutter/material.dart';
import './paging/animal.dart';

class Animals extends StatelessWidget {
  final List<Map<String, String>> animals;

  final Function deleteAnimal;

  Animals(this.animals,{this.deleteAnimal} ) {}

  Widget _buildAnimalsList(BuildContext context, int position) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(animals[position]['imageUrl']),
          Text(animals[position]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(child: Text("View"), onPressed: (){
                Navigator.pushNamed<String>(context, '/animal/'+position.toString())
                    .then((String onValue){
                  if (onValue == 'remove'){
                    deleteAnimal(position);
                  }
                });
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
