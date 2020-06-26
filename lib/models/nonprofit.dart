import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Nonprofit with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final String expenditures;
  final String coverPhoto;
  final List<String> additionalPhotos;
  final List<String> tags;

  Nonprofit({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.expenditures,
    @required this.coverPhoto,
    @required this.additionalPhotos,
    @required this.tags,
  });


  //return nonprofit from DataSnapshot
  Nonprofit.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        name = snapshot.value["name"],
        description = snapshot.value["description"],
        expenditures = snapshot.value["money"],
        coverPhoto = snapshot.value["coverPhoto"],
        additionalPhotos = snapshot.value["additonalPhotos"],
        tags = snapshot.value["tags"];

  //return JSON from nonprofit data
  toJson(){
    return {
      'id': id,
      'name': name,
      'description': description,
      'money': expenditures,
      'coverPhoto': coverPhoto,
      'additionalPhotos': additionalPhotos,
      'tags': tags,
    };
  }

}
