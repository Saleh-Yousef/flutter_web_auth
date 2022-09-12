import 'package:aumet_assessment/models/favorite_model.dart';
import 'package:aumet_assessment/services/home_screen_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/universities_model.dart';
import '../../utils/bloc_life_cycle_interface.dart';

final homeScreenProvider = ChangeNotifierProvider<HomeBloc>((ref) {
  return HomeBloc();
});

class HomeBloc with ChangeNotifier implements BlocLifeCycleInterface {
  final CollectionReference favorites = FirebaseFirestore.instance.collection('favorites');
  final TextEditingController searchFieldController = TextEditingController();

  List<University>? listOfUniversities = [];
  List<University>? searchlistOfUniversities = [];

  List<String>? listOfFavoriteUniversities = [];
  int numberOfPages = 0;
  int selectedPages = 0;
  int listOfUniversitiesLenght = 0;
  bool isFavorite = false;
  String userID = '';
  final service = HomeScreenService();

  Future<void> getUniversities({required String country}) async {
    userID = await FlutterSecureStorage().read(key: 'usrID') ?? '';
    FavoriteModel json = FavoriteModel(favorite: []);

    listOfUniversities!.clear();
    listOfFavoriteUniversities!.clear();
    listOfUniversitiesLenght = 0;
    selectedPages = 0;
    numberOfPages = 0;
    listOfUniversities = await service.getUniversities(country: country);

    if (listOfUniversities!.length > 20) {
      numberOfPages = (listOfUniversities!.length / 15).ceil();
    }
    listOfUniversitiesLenght = listOfUniversities!.length;
    final value = (await favorites.doc(userID).get()).data() as Map<String, dynamic>;

    json = FavoriteModel.fromJson(value);

    for (var item in json.favorite!) {
      listOfFavoriteUniversities!.add(item.name!);
    }
    notifyListeners();
  }

  onNextPagePressed() {
    selectedPages = selectedPages + 1;
    listOfUniversitiesLenght = listOfUniversitiesLenght - 15;
    notifyListeners();
  }

  onPrePagePressed() {
    selectedPages = selectedPages - 1;
    listOfUniversitiesLenght = listOfUniversitiesLenght + 15;
    notifyListeners();
  }

  onFavoriteListOnTab(int index) async {
    if (listOfFavoriteUniversities!.contains(listOfUniversities![index].name)) {
      listOfFavoriteUniversities!.removeWhere((element) => element == listOfUniversities![index].name);
    } else {
      listOfFavoriteUniversities!.add(listOfUniversities![index].name!);
    }

    FavoriteModel myJson = FavoriteModel(favorite: []);

    for (var item in listOfFavoriteUniversities!) {
      myJson.favorite!.add(Favorite(name: item));
    }

    await favorites.doc(userID).set(myJson.toJson());

    notifyListeners();
  }

  search(String text) {
    searchlistOfUniversities!.clear();

    listOfUniversities!.forEach((element) {
      if (element.name!.toLowerCase().contains(text.toLowerCase())) {
        searchlistOfUniversities!.add(element);
      }
    });

    notifyListeners();
  }

  @override
  void clearLoadedData() {
    // TODO: implement clearLoadedData
  }

  @override
  void onAccountSwitch() {
    // TODO: implement onAccountSwitch
  }

  @override
  void pauseSubscription({List? arguments}) {
    // TODO: implement pauseSubscription
  }

  @override
  void resumeSubscription({List? arguments}) {
    // TODO: implement resumeSubscription
  }

  @override
  void startSubscription({List? arguments}) {
    // TODO: implement startSubscription
  }

  @override
  void stopSubscription({List? arguments}) {
    // TODO: implement stopSubscription
  }
}
