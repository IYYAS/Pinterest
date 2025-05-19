import 'dart:ffi';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:media_scanner/media_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:pintrestcubit/data/models/imagemodel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial()) {
    getaction();
    // getImage();
    // finosearch();
    getserch(query: textEditingController.text);
  }
  DateTime? lastPressedTime;
  final int backPressTimeout = 2; // 2 seconds

  bool settingdarklight = false;
  int counter = 1;
  bool change = true;
 String ? serchname ;
  int naviterbottom = 1;

  set(int value) {
    naviterbottom = value;
    emit(HomeInitial());
  }

  toggleTheme(bool value) {
    settingdarklight = value;
    print(value);
    emit(Homeloaded()); // emit a new state to notify listeners
  }

  ontap() {
    change = !change; // This toggles true <-> false
    emit(HomeInitial());
  }

  finosearch() {
    if (textEditingController.text.isEmpty) {
      // getImage();
      emit(HomeInitial());
    }
  }

  List imagesData = [];
  List<String> actionlist = [];
  final ScrollController scrollControllerinf = ScrollController();
  bool isPaginationListenerAttached = false;
  TextEditingController textEditingController = TextEditingController();
  final scrollController = ScrollController();

  TextEditingController serchCtrl = TextEditingController();
  final String apikey = dotenv.env['apikey'] ?? '';

  String? url;

  final String Serchurl =
      "https://api.pexels.com/v1/search?query=nature&page=1&per_page=20";

  getImage() async {
    final String url =
        "https://api.pexels.com/v1/search?query=car&page=1&per_page=20";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': apikey,
      },
    );
    if (response.statusCode == 200) {
      final data = imageModelFromJson(response.body);

      imagesData = data.photos.map((photo) {
        return {
          "id": photo.id,
          "portrait": photo.src.portrait,
          "photographer_url": photo.photographerUrl,
        };
      }).toList();

      print(imagesData);

      emit(HomeInitial());
    } else {
      print("Failed to load images. Status code: ${response.statusCode}");
    }
  }

  Future<void>getaction() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<String>? items = prefs.getStringList('items');
    actionlist=items!;
    emit(HomeInitial());
  }

  Future<void>getserch({required String query}) async {
    print("funtion is calling");
    // actionlist.add(query);
    final text= textEditingController.text.trim();
    if(text.isNotEmpty){
      actionlist.add(text);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('items', actionlist);

      print(actionlist);
    }
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setStringList('action',actionlist.toSet().toList());
    // print(actionlist);




    imagesData.clear();
    final url = query.isNotEmpty
        ? "https://api.pexels.com/v1/search?query=$query&page=1&per_page=20"
        : "https://api.pexels.com/v1/curated?page=1&per_page=20";
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': apikey,
      },
    );
    if (response.statusCode == 200) {
      final data = imageModelFromJson(response.body);

      imagesData.addAll(data.photos.map((photo) {
        return {
          "id": photo.id,
          "portrait": photo.src.portrait,
          "photographer_url": photo.photographerUrl,
        };
      }).toList());

      print(imagesData);

      emit(HomeInitial());
    } else {
      print("Failed to load images. Status code: ${response.statusCode}");
    }
  }

  getpage({required int page, String? query}) async {
    if (textEditingController.text.trim().isEmpty) {
      url = "https://api.pexels.com/v1/search?query=car&page=$page&per_page=20";
    } else {
      url =
          "https://api.pexels.com/v1/search?query=$query&page=$page&per_page=20";
    }

    final response = await http.get(
      Uri.parse(url!),
      headers: {
        'Authorization': apikey,
      },
    );
    if (response.statusCode == 200) {
      final data = imageModelFromJson(response.body);

      imagesData.addAll(data.photos.map((photo) {
        return {
          "id": photo.id,
          "portrait": photo.src.portrait,
          "photographer_url": photo.photographerUrl,
        };
      }).toList());

      print(imagesData);

      emit(HomeInitial());
    } else {
      print("Failed to load images. Status code: ${response.statusCode}");
    }
  }
  Future<void> downloadImage(
      {required String imageUrl,
        required int id,

        required BuildContext context}) async {
    try {
      print(imageUrl);
      print("eorking");
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final bytes = response.bodyBytes;
        final directory = await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOAD);



        final file = File("$directory/$id.png");
        print(file);
        await file.writeAsBytes(bytes);

        MediaScanner.loadMedia(path: file.path);
        print("Saved");

        if (context.mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text("File's been saved at: ${file.path}"),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        else{
          print("Somnthfjc");
        }
      }
    } catch (_) {}
  }
  Future<bool> onWillPop(BuildContext context) async {
    final now = DateTime.now();
    if (lastPressedTime == null ||
        now.difference(lastPressedTime!) > Duration(seconds: backPressTimeout)) {
      // Update the time of last press
      lastPressedTime = now;
      // Show a message asking the user to press again to exit
      showExitPrompt(context);
      return Future.value(false); // Don't exit yet
    }
    return Future.value(true); // Exit the app
  }

   showExitPrompt(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Press back again to exit")),
    );
  }


}
