import 'dart:convert' as convert;
import 'package:buffit_beta/models/album.dart';
import 'package:http/http.dart' as http;

class InstagramService {
  List<String> obrazky;

  getAlbums() async {
    var token =
        'IGQVJVb1ktQzN3c04xa0w1bEtqc2Jydy1xcFFZAenJHTHlYbUFiSWZASVUY4ZAmJEeGZAZAMk82LTFXalBFUGJrOFg0RTdBS1VyUkNMbmZA3S1J6NVh5WXJid0NwWFY3NUZAjYTNiTDRROUdxeUtwVWpJRE90aQZDZD';

    var url =
        'https://graph.instagram.com/me/media?fields=id&access_token=$token';

    var response = await http.get(url);
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse['data'][0]['id']);
    List sth = jsonResponse['data'].map((val) => val['id']).take(14).toList();

    List<Album> albums = new List<Album>();

    for (var alb_id in sth) {
      var albumContent = await http.get(
          'https://graph.instagram.com/$alb_id/children?access_token=$token');
      var jsonContent = convert.jsonDecode(albumContent.body);
      List<dynamic> contentIDS =
          jsonContent['data'].map((value) => value['id']).toList();
      Album album = Album(images: contentIDS);
      print(album);
      albums.add(album);
    }

    return albums;
  }
}
