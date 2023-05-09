import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

final List<String> urls = [
    "https://nekobot.xyz/api/image?type=hentai",
    "https://api.waifu.pics/nsfw/waifu",
    "https://api.waifu.pics/nsfw/neko",
    "https://api.waifu.pics/nsfw/blowjob"
];

Future<void> main(List<String> arguments) async {
    if (!Directory("Hentai").existsSync()) {
        Directory("Hentai").createSync();
    }
    var i = 1;
    while (true) {
        final url = urls[Random().nextInt(urls.length)];
        final response = await HttpClient().getUrl(Uri.parse(url)).then((request) => request.close());
        final d = await response.transform(utf8.decoder).transform(json.decoder).first as Map<String, dynamic>;
        download(d, i);
        await Future.delayed(Duration(milliseconds: 1200));
        i++;
    }
}

void download(Map<String, dynamic> d, int i) async {
    final link = d['url'] != null ? d['url'] as String : d['message'] as String;
    final name = link.split('/').last;
    final file = File('Hentai/$name');
    final request = await HttpClient().getUrl(Uri.parse(link));
    final response = await request.close();
    await response.pipe(file.openWrite());
    print('$i Hentai Downloaded');
}