import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class InstagramService {
  List<String> obrazky;

  getAlbums() async {
    var token =
        'IGQVJWZAW1OU01LSkNNeG5DeWpuT0lHZAmViaDF5NkVBSl8weGZAPSkVWcGNKcHdTVURHSnNBTTdlSmpJWjUwT3pVdnF6VlZAXRUdaRlh4a2NndjNDWnc4NEJJMDhxVzhaYUNrZAWtzb0FfYXl1cHVwVFF3OAZDZD';

    var url =
        'https://graph.instagram.com/me/media?fields=id&access_token=$token';

    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    var sth = jsonResponse['data'].map((value) => value['id']);
    print(sth);

    // obsah postu
    var id = jsonResponse['data'][0]['id'];

    var albumContent = await http
        .get('https://graph.instagram.com/$id/children?access_token=$token');
    var jsonContent = convert.jsonDecode(albumContent.body);
    List<dynamic> contentIDS =
        jsonContent['data'].map((value) => value['id']).toList();
    print(contentIDS);

    return contentIDS;
  }

  // for (var item in contentIDS) {
  //   var obrazek = await http
  //       .get(
  //           'https://graph.instagram.com/$item?fields=media_url&access_token=$token')
  //       .then((value) => convert.jsonDecode(value.body));
  //   print(obrazky);
  //   obrazky.add(obrazek);
  // }

  // return obrazky;

  // contentIDS.forEach((element) async {
  //   await http
  //       .get(
  //           'https://graph.instagram.com/$element?fields=media_url&access_token=$token')
  //       .then((value) => convert.jsonDecode(value.body));
  // var jsonObrazek = convert.jsonDecode(obrazky.body);
  // return jsonObrazek['media_url']
  // });
}
