
class Character{
  late int    id;
  late String firstName;
  late String lastName;
  late String fullName;
  late String title;
  late String family;
  late String image;
  late String imageUrl;
  

  Character.fromJson(Map<String,dynamic>json){
    id=json["id"];
    firstName=json["firstName"];
    lastName=json["lastName"];
    fullName=json["fullName"];
    title=json["title"];
    family=json["family"];
    image=json["image"];
    imageUrl=json["imageUrl"];
  }
 
}