import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fotomag3/domain/workout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(title: Text('IN_PRINT'), leading: Icon(Icons.photo_camera)),
        body: WorkoutList(),
      ),
    );
  }
}

class WorkoutList extends StatelessWidget {

  final workouts = <Workout>[
    Workout(title: 'Фото', author: 'Poli', description: 'Фото на документы', level: 'Фото на документы'),
    Workout(title: 'Футболки', author: 'Poli', description: 'Кибер тряпка', level: 'Кибер тряпка'),
    Workout(title: 'Кружки', author: 'Poli', description: 'Золотая чаша', level: 'Золотая чаша'),
    Workout(title: 'Мяу', author: 'Poli', description: 'Я сладкая булочка', level: 'Я сладкая булочка')
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, i) {
                return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Container(
                    decoration: BoxDecoration(color: Color.fromRGBO(124, 174, 246, 0.80)),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(Icons.photo_camera, color: Colors.white),
                        decoration: BoxDecoration(
                            border: Border(right: BorderSide(width: 1, color: Colors.white24))
                        ),
                      ),
                      title: Text(workouts[i].title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white60,),
                      subtitle: subtitle(context, workouts[i]),
                    ),
                  ),
                );
              }
          )
      ),
    );
  }
}

Widget subtitle(BuildContext context, Workout workout) {
  var color = Colors.grey;
  double indicatorLevel = 0;

  switch (workout.level) {
    case 'Фото на документы':
      color = Colors.green;
      indicatorLevel = 0.33;
      break;
    case 'Кибер тряпка':
      color = Colors.yellow;
      indicatorLevel = 0.50;
      break;
    case 'Золотая чаша':
      color = Colors.orange;
      indicatorLevel = 0.70;
      break;
    case 'Я сладкая булочка':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }
  return Row(
    children: <Widget>[
      Expanded(
          flex: 1,
          child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: indicatorLevel,
              valueColor: AlwaysStoppedAnimation(color)
          )
      ),
      SizedBox(width: 10),
      Expanded(
        flex: 3,
        child: Text(workout.level, style: TextStyle(color: Colors.white),),
      )
    ],
  );
}