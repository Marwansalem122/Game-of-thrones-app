

class Quotes{
  late int    id;
  late String quote;
  late String from;
  late String to ;
  late int season;
  late int episode;

  

  Quotes.fromJson(Map<String,dynamic>json){
    id=json["_id"];
    quote=json["quote"];
    from=json["from"];
    to=json["to"];
    season=json["season"];
    episode=json["episode"];
  }
 
}