import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_test/business_logic/cubit/character_cubit.dart';
import 'package:bloc_test/constant/my_colors.dart';
import 'package:bloc_test/data/models/characters.dart';
import 'package:bloc_test/data/models/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CaracterDtailsScreen extends StatelessWidget {
  final Character character;
  const CaracterDtailsScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
     BlocProvider.of<CharacterCubit>(context).getQuote(character.fullName);
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Mycolor.mygrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(h, w),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.symmetric(horizontal: w * 0.1),
              padding:
                  EdgeInsets.symmetric(horizontal: w * 0.1, vertical: h * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo("Name : ", character.fullName),
                  buildDivider(((character.fullName).length).toDouble(), w),
                  characterInfo("Family: ", character.family),
                  buildDivider(((character.family).length).toDouble(), w),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.01,
            ),
            BlocBuilder<CharacterCubit, CharacterState>(
                builder: (context, state) {
              return checkQuotesLoaded(state);
            }),
            SizedBox(
              height: h * 0.6,
            ),
          ]))
        ],
      ),
    );
  }

  buildSliverAppBar(var h, var w) {
    return SliverAppBar(
      expandedHeight: h * 0.7,
      pinned: true,
      stretch: true,
      backgroundColor: Mycolor.mygrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.title,
          style: const TextStyle(
            color: Mycolor.mywhite,
          ),
          //textAlign: TextAlign.center,
        ),
        background: Hero(
          tag: character.id,
          child: Image.network(
            character.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  characterInfo(String title, String value) {
    return RichText(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: Mycolor.mywhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          TextSpan(
              text: value,
              style: const TextStyle(color: Colors.white30, fontSize: 16)),
        ]));
  }

  buildDivider(double endpoint, w) {
    return Divider(
      height: 30,
      endIndent: w * 0.443,
      color: Mycolor.myyellow,
      thickness: 2,
    );
  }

  Widget checkQuotesLoaded(CharacterState state) {
    if (state is QuotesLoaded) {
      return displayQuote(state);
    } else {
      return showLoadingIndicator();
    }
  }

  showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Mycolor.myyellow,
      ),
    );
  }

  Widget displayQuote(CharacterState state) {
    if (state is QuotesLoaded) {
      String quotes = state.quotes;

      return Center(
          child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, color: Mycolor.mywhite, shadows: [
          Shadow(blurRadius: 7, color: Mycolor.myyellow, offset: Offset(0, 0))
        ]),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText("$quotes "),
          ],
          onTap: () {
            //print("Tap Event");
          },
        ),
      ));
    } else {
      return Container(); // Return an empty container or handle other states if needed
    }
  }
}
