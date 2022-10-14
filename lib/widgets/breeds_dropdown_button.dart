import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/preferences_model.dart';

class BreedsDropdownButton extends StatefulWidget{
  final List<BreedInfo> listToMap;
  BreedInfo? previousBreed;
  final ValueChanged<BreedInfo> onChanged;
  BreedsDropdownButton({super.key, required this.listToMap, previousBreed, required this.onChanged});

  @override
  State<BreedsDropdownButton> createState() => _BreedsDropdownButtonState();

  String get selectedBreed => previousBreed?.breedName ?? "None";
  List<String> getList() {
    List<String> output = ["None"];

    for (var item in listToMap) {
      output.add(item.breedName);
    }
    return output;
  }
}

class _BreedsDropdownButtonState extends State<BreedsDropdownButton>{
  late String dropdownValue;
  @override
  void initState(){
    dropdownValue = widget.selectedBreed;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    var list = widget.getList();
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.blue),
      underline: Container(
        height: 2,
        color: Colors.blueAccent,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        _checkIfValidAndAssign(value!);
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _checkIfValidAndAssign(String value){
    var output = widget.listToMap.where((element) => element.breedName == value).first;
    if(value != "none" && output != widget.selectedBreed){
      widget.previousBreed = output;
      widget.onChanged(output);
    }
  }
}