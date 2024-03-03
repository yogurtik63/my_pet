import 'package:flutter/material.dart';

import '../utils/AnimalType.dart';
import 'event_class.dart';

class Pet {
  String name = '';
  String note = '';
  late AnimalType animalType;
  Image image = Image.asset("asset_files/images/no_photo.jpg");
  List<Event> events = [];

  Pet(String name, AnimalType animalType) {
    this.name = name;
    this.animalType = animalType;
  }

  setNote(String note) {
    this.note = note;
  }

  getNote() {
    return this.note;
  }

  addEvent(Event event) {
    this.events.add(event);
  }
  
  setImage() {
    switch (this.animalType) {
      case AnimalType.cat:
        this.image = Image.asset('asset_files/images/cat.jpg');
        break;
      case AnimalType.dog:
        this.image = Image.asset('asset_files/images/dog.jpg');
        break;
      case AnimalType.parrot:
        this.image = Image.asset('asset_files/images/parrot.jpg');
        break;
      case AnimalType.hamster:
        this.image = Image.asset('asset_files/images/hamster.jpg');
        break;
      case AnimalType.noExist:
        break;
    }
  }
}

