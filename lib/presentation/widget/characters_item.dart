import 'package:bloc_test/constant/my_colors.dart';
import 'package:bloc_test/constant/string.dart';
import 'package:bloc_test/data/models/characters.dart';
import 'package:flutter/material.dart';

class Characteritem extends StatelessWidget {
  final Character character;
  const Characteritem({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Container(
        width: w,
        margin: EdgeInsets.symmetric(horizontal: w * 0.003, vertical: h * 0.006),
        padding: EdgeInsets.all(w * 0.01),
        decoration: BoxDecoration(
            color: Mycolor.mywhite, borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: ()=>Navigator.of(context).pushNamed(charactersDetailScreen,arguments:character),
          child: Hero(
            tag: character.id,
            child: GridTile(
              footer: Container(
                width: w,
                padding:
                    EdgeInsets.symmetric(horizontal: w * 0.03, vertical: h * 0.02),
                color: Colors.black54,
                alignment: Alignment.bottomCenter,
                child: Text(
                  character.fullName,
                  style: TextStyle(
                      height: 1.3, fontSize: w * 0.03, color: Mycolor.mywhite),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              child: Container(
                color: Mycolor.mygrey,
                child: character.image.isNotEmpty
                    ? FadeInImage(
                        width: w,
                        height: h,
                        placeholder:  const AssetImage("assets/images/loading.gif"),
                        image: NetworkImage(character.imageUrl),
                        fit: BoxFit.cover,
                      )
                    : Image.asset("assets/images/placeholder.jpg"),
              ),
            ),
          ),
        ));
  }
}
