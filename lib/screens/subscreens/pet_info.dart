import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_pet/screens/subscreens/pet_creating.dart';

import '../../classes/pet_class.dart';
import '../../global.dart';
import '../../utils/AnimalType.dart';
import 'add_event.dart';

class PetInfoPage extends StatefulWidget {
  final String title;
  final Pet pet;

  Function callback;

  PetInfoPage({super.key, required this.title, required this.pet, required this.callback});

  @override
  State<PetInfoPage> createState() => _PetInfoPageState();

}

class _PetInfoPageState extends State<PetInfoPage> {
  late Pet pet = widget.pet;

  callback () {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => PetCreatePage(title: "Изменение", pet: pet, callbackParent: callback, callbackMain: widget.callback)),
              );
            },
            icon: const Icon(Icons.edit),
            iconSize: 32,
          ),
          IconButton(
            onPressed: () {
              gPets.remove(pet);
              // isNeedUpdatePets.value = true;
              widget.callback();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.delete),
            iconSize: 32,
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
          child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                          child:
                          Container(
                            width: 96.0,
                            height: 96.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: pet.image.image,
                              ),
                            ),
                          )
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              pet.name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold)
                          ),
                          Text(
                            getAnimalTypeStr(pet.animalType),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ]
                      ),
                    ],
                  )
              ),
              const Divider(height: 16, color: Color.fromRGBO(0, 0, 0, 0)),

              TextFormField(
                onChanged: (text) {
                  pet.setNote(text);
                },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  hoverColor: Colors.white,
                  border: OutlineInputBorder(),
                  hintText: "Заметка...",
                ),
                initialValue: pet.getNote(),
                maxLines: 4,
                minLines: 1,
              ),

              const Divider(height: 16, color: Color.fromRGBO(0, 0, 0, 0)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: Text(
                          "Напоминания",
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold)
                      )
                  ),
                  Ink(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child:
                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => AddEvent(
                                  pet: this.pet,
                                  callbackParent: callback,
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.now().add(const Duration(days: 365)))
                                  ),
                            );
                          },
                          icon: const Icon(Icons.add)
                      )
                  )
                ],
              ),

              const Divider(height: 16, color: Color.fromRGBO(0, 0, 0, 0)),

              SingleChildScrollView(
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Container(
                              padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(15))
                              ),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
                                      child:
                                      Row(
                                        children: [
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    pet.events[index].note,
                                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                                                Text(
                                                    DateFormat('dd/MM/yyyy HH:mm a').format(pet.events[index].date),
                                                    style: Theme.of(context).textTheme.labelLarge)
                                              ]
                                          ),
                                        ],
                                      ),
                                    ),
                                    Ink(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child:
                                        IconButton(
                                          // iconSize: 32,
                                            onPressed: () {
                                              gEvents.remove(pet.events[index]);
                                              pet.events.remove(pet.events[index]);
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.delete)
                                        )
                                    ),
                                  ]
                              ),
                            )
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 16, indent: 10, endIndent: 10),
                      itemCount: pet.events.length
                  )
              ),
            ]
          )
      )
    );
  }
}