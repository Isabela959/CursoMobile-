import '../services/pet_dbhelper.dart';
import '../models/pet_model.dart';

class PetController {
  final PetShopDBHelper _dbHelper = PetShopDBHelper();

  //métodos controllers

  Future<int> createPe(Pet pet) async{
    return _dbHelper.insertPet(pet);
  }

  Future<List<Pet>> readPets() async{
    return _dbHelper.getPets();
  }

  Future<Pet?> readPetById(int id) async {
    return _dbHelper.getPetById(id);
  }

  Future<int> deletePet(int id) async{
    return _dbHelper.deletePet(id);
  }
}