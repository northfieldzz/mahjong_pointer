import 'player/objects.dart';

class Setting {
  int defaultPoint = 25000;
  int reachPoint = 1000;

  List<Person> persons = [
    Person(name: 'East Player'),
    Person(name: 'South Player'),
    Person(name: 'West Player'),
    Person(name: 'North Player')
  ];
}
