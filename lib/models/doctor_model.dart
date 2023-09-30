import 'service_model.dart';
import 'animals_model.dart';

class DoctorModel {
  String name;
  String image;
  List<String> services;
  int distance;
  List<String> animals;

  DoctorModel(
      {required this.name,
      required this.image,
      required this.services,
      required this.distance,
      required this.animals});
}

var doctors = [
  DoctorModel(
      name: "Dr. Aditya",
      image: "stone.png",
      services: [Service.vaccine, Service.surgery, Service.spaAndTreatment],
      distance: 10,
      animals: [Animal.cat, Animal.dog]),
  DoctorModel(
    name: "Dr. Stone",
      image: "anna.jpg",
      services: [Service.surgery],
      distance: 10,
      animals: [Animal.cat]),
  DoctorModel(
      name: "Dr. Anna",
      image: "stone.png",
      services: [Service.consultation],
      distance: 10,
      animals: [Animal.dog])
];