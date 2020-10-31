import 'package:darq/darq.dart';
void main() {
  // Using Aggregate => applies an aggregate function to the list and return a single value
  final numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12 , 12, 12, 12, 12, 12, 12, 12, 1,2,12];
  final names = ["maunda", "alex", "mitchel", "James", 'Santoz', 'kelvin'];
  final pets = [
    Pet('Barley', 8),
    Pet('Boots', 4),
    Pet('Whiskers', 1),
    Pet('Daisy', 4),
  ];
  final sum = numbers.aggregate(10, (a, b) => a + b);

  printSeparator("Aggregate Function");
  print(sum);
  print('Numbers $numbers');
  print("names, $names");
  print('Count ${numbers.count()}');
  print('Select Distinct values ${numbers.distinct().count()}');
  print('Select Element at an index: \n ${numbers.elementAt(10)}');
  print('Select Element at an index or send a default if null: \n ${numbers.elementAtOrDefault(23, defaultValue: 12)}');
  print('Use of Except in a list: [10, 11, 12] \n ${numbers.except([10, 11, 12])}');

  print("Use of first or default: $names, \n ${names.firstOrDefault(defaultValue: "Andrew")}");
  print("First where $names, \n ${names.firstWhere((element) => element.length > 5)}");
  print("First where or default $names, \n ${names.firstWhereOrDefault((element) => element.length > 20, defaultValue: "En")}");


  print("Group By: $pets : \n ${pets.groupBy((p) => p.age)}");


  final results = pets.groupByValue(
    keySelector: (pet) => pet.age,
    valueSelector: (pet) => pet.name,
  );




  print("Group by value ${results.firstWhere((element) => element.length > 1)}");

  // Group Select:
  final ageLimit = (Pet p1, Pet p2) => p1.age.compareTo(p2.age);
  print("age limit => Compared, : $ageLimit");

  // in action
  final result = pets.groupSelect(
      (age, pets) => {
        'key': age,
        'count': pets.length,
        'min': pets.min(ageLimit),
        'max': pets.max(ageLimit),
      },
    keySelector: (pet) => pet.age.floor()
  );


  // group group select value
  final groupSelectValue = pets.groupSelectValue(
      (age, pets) => {
        'key': age,
        'count': pets.length,
        'names': pets
      },
    keySelector: (p) => p.age,
    valueSelector: (p) => p.name,
  );

  print("Select Group Value ${groupSelectValue.elementAt(1)}");

  result.forEach((element) {print(element);});

  print("Group Select result $result");


  // Working with intersections => the items that are occurring in both lists
  final listA = [1, 2, 3, 4, 5];
  final listB = [2, 3, 4, 5, 6, 7, 8];
  
  print("Intersection of two lists $listA, and $listB \n${listA.intersect(listB)} ");
}

void printSeparator (String message) {
  print("***************************** $message ******************************");
}
class Pet {
  Pet(this.name, this.age);

  String name;
  double age;
}