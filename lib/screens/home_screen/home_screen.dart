import 'package:aumet_assessment/screens/home_screen/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/universities_model.dart';
import '../../shared_widgets/text_field.dart';
import '../../utils/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeBloc = ref.watch(homeScreenProvider);
    final _auth = ref.watch(authenticationProvider);

    var items_number = 10;

    return Scaffold(
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(),
              child: Text('List of contries'),
            ),
            ListTile(
              leading: const Icon(
                Icons.flag,
              ),
              title: const Text('Jordan'),
              onTap: () async {
                await homeBloc.getUniversities(country: 'Jordan');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.flag,
              ),
              title: const Text('Egypt'),
              onTap: () async {
                await homeBloc.getUniversities(country: 'egypt');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.flag,
              ),
              title: const Text('Spain'),
              onTap: () async {
                await homeBloc.getUniversities(country: 'spain');

                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
              ),
              title: const Text('Logout'),
              onTap: () async {
                await _auth.signOut().whenComplete(
                      () => _auth.authStateChange.listen((event) async {
                        if (event == null) {
                          return;
                        }
                      }),
                    );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('List Of Universities'),
      ),
      body: homeBloc.listOfUniversities!.isEmpty
          ? const Center(
              child: Text('Please select a country from the drop down button top right the screen'),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextField(
                    controller: homeBloc.searchFieldController,
                    hintText: 'search for university',
                    keyboardType: TextInputType.text,
                    onChange: (text) {
                      homeBloc.search(text);
                    },
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                    ),
                  ),
                  homeBloc.searchFieldController.text.isEmpty
                      ? PaganationGridView(
                          homeBloc: homeBloc,
                          itemCount: homeBloc.listOfUniversities!.length >= 20
                              ? homeBloc.listOfUniversitiesLenght >= 15
                                  ? 15
                                  : homeBloc.listOfUniversitiesLenght
                              : homeBloc.listOfUniversities!.length,
                          list: homeBloc.listOfUniversities)
                      : PaganationGridView(
                          homeBloc: homeBloc, itemCount: homeBloc.searchlistOfUniversities!.length, list: homeBloc.searchlistOfUniversities),
                  homeBloc.searchFieldController.text.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            homeBloc.selectedPages > 0
                                ? OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      side: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    onPressed: () {
                                      homeBloc.onPrePagePressed();
                                    },
                                    child: const Text('Previews page'),
                                  )
                                : Container(),
                            homeBloc.listOfUniversitiesLenght <= 15
                                ? Container()
                                : OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      side: BorderSide(
                                        width: 2,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    onPressed: () {
                                      homeBloc.onNextPagePressed();
                                    },
                                    child: const Text('Next page'),
                                  ),
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
    );
  }
}

class PaganationGridView extends StatelessWidget {
  const PaganationGridView({
    Key? key,
    required this.homeBloc,
    required this.itemCount,
    required this.list,
  }) : super(key: key);

  final HomeBloc homeBloc;
  final int itemCount;
  final List<University>? list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisExtent: 200, maxCrossAxisExtent: 200, childAspectRatio: 3 / 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: itemCount,
        itemBuilder: (BuildContext ctx, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  homeBloc.onFavoriteListOnTab(
                      homeBloc.listOfUniversities!.indexOf(list![index + (homeBloc.selectedPages * 15)]) + (homeBloc.selectedPages * 15));
                },
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  width: 20,
                  height: 20,
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  child: !homeBloc.listOfFavoriteUniversities!.contains(list![index + (homeBloc.selectedPages * 15)].name)
                      ? const Icon(
                          Icons.favorite_border,
                          color: Colors.blue,
                          size: 25,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.blue,
                        ),
                ),
              ),
              Container(
                height: 180,
                width: 180,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(15)),
                child: Text(list![index + (homeBloc.selectedPages * 15)].name!),
              ),
            ],
          );
        },
      ),
    );
  }
}
