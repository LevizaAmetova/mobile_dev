import 'dart:convert';

import 'package:http/http.dart' as http;
void main() async
{
  var persons= await http.get(Uri.parse('https://fakerapi.it/api/v2/persons?_locale=ru_RU'));
  print(persons);
  //print('body:');
  //print(persons.body);

  var data = jsonDecode(persons.body);
  print('Статус: ${data['status']}');
    print('Код: ${data['code']}');
    print('Всего записей: ${data['total']}');
    print('--- Люди ---');
  print(data["data"]);

  var i=0;
  while( i<10 )
  {
  print(data["data"][i]["firstname"]);
  i++;
}
}