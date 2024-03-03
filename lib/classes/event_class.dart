import 'package:my_pet/classes/pet_class.dart';

class Event {
  late Pet refPet;
  late String note;
  late DateTime date;

  Event (Pet pet, String note, DateTime date) {
    this.refPet = pet;
    this.note = note;
    this.date = date;
  }
}