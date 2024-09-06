import 'package:sealed_languages/sealed_languages.dart';

void main(){
  var a =NaturalLanguage.maybeFromCodeShort("kan")?.name??"Kannada";
  print(a);
}