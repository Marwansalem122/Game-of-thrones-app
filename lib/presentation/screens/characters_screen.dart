import 'package:bloc_test/business_logic/cubit/character_cubit.dart';
import 'package:bloc_test/constant/my_colors.dart';
// import 'package:bloc_test/constant/string.dart';
import 'package:bloc_test/data/models/characters.dart';
import 'package:bloc_test/presentation/widget/characters_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allcharacters;
  late List<Character> searchedforcharacters;
  final TextEditingController con = TextEditingController();
  bool issearch = false;

  @override
  void initState() {
    BlocProvider.of<CharacterCubit>(context).getAllcharacters();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Mycolor.myyellow,
          title: issearch ? searchField() : buildAppBarTitle(),
          actions: buildAppBarAction(),
          leading: issearch
              ? const BackButton(
                  color: Mycolor.mygrey,
                )
              : Container(),
        ),
        body: OfflineBuilder(
          connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlockBWidget();
          } else {
            return noInternet(h);
          }
        },child: showLoadingIndicator(),)
        );
  }

  Widget searchField() {
    return Center(
      child: TextField(
        controller: con,
        cursorColor: Mycolor.mygrey,
        decoration: const InputDecoration(
          hintText: "Find The Character.....",
          border: InputBorder.none,
          hintStyle: TextStyle(fontSize: 15, color: Mycolor.mygrey),
        ),
        style: const TextStyle(fontSize: 15, color: Mycolor.mygrey),
        onChanged: (searchedcharacter) {
          searchitem(searchedcharacter);
        },
      ),
    );
  }

  void searchitem(String itemsearch) {
    setState(() {
      searchedforcharacters = allcharacters
          .where((character) => character.fullName
              .toLowerCase()
              .contains(itemsearch.toLowerCase()))
          .toList();
    });
  }

  List<Widget>? buildAppBarAction() {
    if (issearch) {
      return [
        IconButton(
            onPressed: () {
              clearsearch();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Mycolor.mygrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: statsearch,
            icon: const Icon(
              Icons.search,
              color: Mycolor.mygrey,
            ))
      ];
    }
  }

  statsearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopsearch));
    setState(() {
      issearch = true;
    });
  }

  stopsearch() {
    clearsearch();
    setState(() {
      issearch = false;
    });
  }

  clearsearch() {
    con.clear();
  }

  Widget buildAppBarTitle() {
    return const Text(
      "Characters",
      style: TextStyle(color: Mycolor.mygrey),
    );
  }

  buildBlockBWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharactersLoad) {
        allcharacters = state.characters;
        return buildLoadedList();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  buildLoadedList() {
    return SingleChildScrollView(
      child: Container(
        color: Mycolor.mygrey,
        child: Column(children: [buildCharacterList()]),
      ),
    );
  }

  buildCharacterList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: con.text.isEmpty
            ? allcharacters.length
            : searchedforcharacters.length,
        itemBuilder: (context, i) {
          return Characteritem(
            character:
                con.text.isEmpty ? allcharacters[i] : searchedforcharacters[i],
          );
        });
  }

  showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Mycolor.myyellow,
      ),
    );
  }

  Widget noInternet(var h) {
    return Container(
      width: double.infinity,
        color: Colors.white,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Text(
                "Can't connect Check The Internet",
                style: TextStyle(fontSize: h * 0.03, color: Colors.red),
              ),
              Image.asset("assets/images/nointernet.jpg",fit: BoxFit.fill,) 
            ],
          ),
        );
  }
}
