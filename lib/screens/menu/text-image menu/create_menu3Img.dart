import 'dart:io';
import 'dart:convert';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tastesonway/models/theme_category_model.dart';
import 'package:tastesonway/utils/utilities.dart';
import '../../../apiServices/api_service.dart';
import '../../../models/theme_image_model.dart';
import '../../../utils/sharedpreferences.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/theme_data.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CreateImgMenu3 extends StatefulWidget {
  final int imageMenuId;

  const CreateImgMenu3({Key? key, required this.imageMenuId}) : super(key: key);

  @override
  State<CreateImgMenu3> createState() => _CreateImgMenu3State();
}

class _CreateImgMenu3State extends State<CreateImgMenu3> {
  int refreshCounter = 0;

  List<ThemeImageModel> image = <ThemeImageModel>[];
  String backgroundImage = "";
  int backgroundImageId = 1;
  List<ThemeCategoryModel> themeCategoryList = [];
  bool _isLoading = true;
  int selectedIndex = 0;
  int selectedBackgroundIndex = 0;
  List menuList = [];
  bool isProceed = false;
  Color menuFontColor = Colors.white;
  PdfColor pdfFontColor = const PdfColor.fromInt(0xFF1E1E1E);
  List<pw.ImageProvider> pdfImages = [];
  List<Uint8List> imageMenuList = [];
  List<String> images = [];
  String name = "";
  String imageMenuLink ="";
  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  Future getTheme(BuildContext context, int index) async {
    name = await Sharedprefrences.getMenuName();
    String token = await Sharedprefrences.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/get-theme'),
      headers: {'Authorization': 'Bearer $token'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      selectedBackgroundIndex = 0;
      themeCategoryList.clear();
      for (var categoryName in data['data'].keys) {
        themeCategoryList.add(ThemeCategoryModel(
            categoryName: categoryName.toString(), categoryIndex: index));
      }
      var themeName =
          data['data'][themeCategoryList[index].categoryName] as List;

      var tagObjs = themeName
          .map((tagJson) => ThemeImageModel.fromJson(tagJson))
          .toList();
      image = tagObjs;
      backgroundImage = image[0].picture;
      menuFontColor = await Utilities().menuTextColor(backgroundImage);

      pdfFontColor = await Utilities().pdfTextColor(backgroundImage);

      setState(() {
        _isLoading = false;
      });
    } else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? getTheme(context, index) : null;
      }
    }
    else {
      setState(() {
        _isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> Menu() async {
    String token =  await Sharedprefrences.getToken();
    String? ownerId = await Sharedprefrences.getId();
    final response =
        await http.post(Uri.parse('$baseUrl/get-menu-item'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'menu_id': '${widget.imageMenuId}',
      'category_id': '1',
      'business_owner_id': ownerId
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      menuList = (json['data'][1]['data']);
      print("menulist :$menuList");
    }
    else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? Menu() : null;
      }
    }else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      print(json['message']);
    }
  }

  Future<pw.PageTheme> _myPageTheme() async {
    // final bgShape = await rootBundle.loadString('assets/resume.svg');
    // final PdfImage pdfImage = await pdfImageFromImageProvider(
    //     pdf: pdf.document, image: NetworkImage(backgroundImage));

    var url = backgroundImage.toString();
    var response = await http.get(Uri.parse(url));
    final documentDirectory = Platform.isAndroid
        ? (await getExternalStorageDirectory())!.path //FOR ANDROID
        : (await getApplicationSupportDirectory()).path;
    var imgFile = File('$documentDirectory/backgroundImage.png');
    imgFile.writeAsBytesSync(response.bodyBytes);
    final imageProvider = pw.MemoryImage(File(imgFile.path).readAsBytesSync());

    //images.add('$documentDirectory/backgroundImage.png');

    // format = format.applyMargin(
    //     left: 2.0 * PdfPageFormat.cm,
    //     top: 4.0 * PdfPageFormat.cm,
    //     right: 2.0 * PdfPageFormat.cm,
    //     bottom: 2.0 * PdfPageFormat.cm);
    return pw.PageTheme(
      pageFormat: PdfPageFormat.a4,
      theme: pw.ThemeData.withFont(
        base: pw.Font.ttf(
            await rootBundle.load('assets/fonts/Poppins-Regular.ttf')),
        bold:
            pw.Font.ttf(await rootBundle.load('assets/fonts/Poppins-Bold.ttf')),
        // icons: pw.Font.ttf(await rootBundle.load('assets/material.ttf')),
      ),
      buildBackground: (pw.Context context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              child: pw.Container(
                  width: PdfPageFormat.a4.width.toDouble(),
                  height: PdfPageFormat.a4.height.toDouble(),
                  decoration: pw.BoxDecoration(
                    image: pw.DecorationImage(
                      image: imageProvider,
                      //image:pw.RawImage(bytes: logoImage,height: 50,width: 50),
                      fit: pw.BoxFit.fill,
                    ),
                  )),
              left: 0,
              top: 0,
            ),
            // pw.Positioned(
            //   child: pw.Transform.rotate(
            //       angle: pi, child: pw.SvgImage(svg: bgShape)),
            //   right: 0,
            //   bottom: 0,
            // ),
          ],
        ),
      ),
    );
  }

  getPdfImage() async {
    for (var i = 0; i < menuList.length; i++) {
      var url = menuList[i]['picture'].toString();
      var response = await http.get(Uri.parse(url));
      final documentDirectory = Platform.isAndroid
          ? (await getExternalStorageDirectory())!.path //FOR ANDROID
          : (await getApplicationSupportDirectory()).path;
      var imgFile = File('$documentDirectory/item_image$i.png');
      imgFile.writeAsBytesSync(response.bodyBytes);
      final imageProvider =
          pw.MemoryImage(File(imgFile.path).readAsBytesSync());
      setState(() {
        pdfImages.add(imageProvider);
      });
    }
  }

  writeOnPdf(String menuName, BuildContext contexts) async {
    final pdf = pw.Document();
    final pageThemes = await _myPageTheme();
    pdf.addPage(pw.MultiPage(
        pageTheme: pageThemes,
        maxPages: 100,
        build: (pw.Context context) => [
              // pw.Wrap(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.only(
                    left: 50, right: 20, top: 40, bottom: 15),
                child: pw.Column(
                  children: [
                    pw.Container(
                      // height: 108,
                      // decoration: pw.BoxDecoration(
                      //   // color: PdfColors.tr,
                      //   borderRadius: 8,
                      // ),
                      width: PdfPageFormat.a4.width.toDouble(),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            height: 15,
                          ),
                          pw.Text(
                            menuName,
                            style: pw.TextStyle(
                              color: pdfFontColor,
                              fontWeight: pw.FontWeight.bold,
                              fontSize: 28,
                            ),
                          ),
                          pw.SizedBox(
                            height: 10,
                          ),
                          pw.Text(
                            'Dishes in the Menu',
                            style: pw.TextStyle(
                              color: pdfFontColor,
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 22,
                            ),
                          ),
                          pw.SizedBox(
                            height: 16,
                          ),
                          pw.Container(
                              height: 6, width: 140, color: pdfFontColor),
                          pw.SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              for (int i = 0; i < menuList.length; i++)
                pw.Padding(
                  padding:
                      const pw.EdgeInsets.only(left: 50, right: 20, bottom: 25),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Expanded(
                          flex: 2,
                          child: pw.Container(
                              height: 66,
                              width: 66,
                              foregroundDecoration: pw.BoxDecoration(
                                border: pw.Border.all(color: pdfFontColor),
                                borderRadius: pw.BorderRadius.circular(5.0),
                              ),
                              child: pw.ClipRRect(
                                  horizontalRadius: 5.0,
                                  verticalRadius: 5.0,
                                  child: pw.Image(
                                      i >= pdfImages.length
                                          ? pdfImages[0]
                                          : pdfImages[i],
                                      height: 65,
                                      width: 65,
                                      fit: pw.BoxFit.cover)))),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.Expanded(
                          flex: 6,
                          child: pw.Column(
                              // mainAxisAlignment:
                              //     pw.MainAxisAlignment.center,
                              // crossAxisAlignment:
                              //     pw.CrossAxisAlignment.center,
                              children: [
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Row(children: [
                                  pw.Container(
                                    height: 17,
                                    width: 17,
                                    decoration: pw.BoxDecoration(
                                        border: pw.Border.all(
                                            color:
                                                menuList[i]['type'] == 'Non veg'
                                                    ? const PdfColor.fromInt(
                                                        0xFFF85649)
                                                    : const PdfColor.fromInt(
                                                        0xFF208824))),
                                    padding: const pw.EdgeInsets.all(2),
                                    child: pw.Container(
                                      height: 8,
                                      width: 8,
                                      decoration: pw.BoxDecoration(
                                          shape: pw.BoxShape.circle,
                                          color:
                                              menuList[i]['type'] == 'Non veg'
                                                  ? const PdfColor.fromInt(
                                                      0xFFF85649)
                                                  : const PdfColor.fromInt(
                                                      0xFF208824)),
                                    ),
                                  ),
                                  pw.SizedBox(
                                    width: 12,
                                  ),
                                  pw.Expanded(
                                      child: pw.Text(
                                          menuList[i]['name'].toString(),
                                          style: pw.TextStyle(
                                              fontSize: 22,
                                              color: pdfFontColor))),
                                ]),
                                menuList[i]['description'].toString() != 'null'
                                    ? pw.SizedBox(height: 10)
                                    : pw.Container(),
                                menuList[i]['description'].toString() != 'null'
                                    ? pw.Row(children: [
                                        pw.Container(
                                          height: 17,
                                          width: 17,
                                        ),
                                        pw.SizedBox(
                                          width: 12,
                                        ),
                                        pw.Expanded(
                                            child: pw.Padding(
                                                padding:
                                                    const pw.EdgeInsets.only(
                                                        right: 30),
                                                child: pw.Text(
                                                    '[${menuList[i]['description'].toString()}]',
                                                    style: pw.TextStyle(
                                                        fontSize: 18,
                                                        color: pdfFontColor)))),
                                      ])
                                    : pw.Container(),
                              ])),
                      pw.Expanded(
                          flex: 2,
                          child: pw.Padding(
                              padding: const pw.EdgeInsets.only(
                                top: 10,
                              ),
                              child: pw.Text('₹ ${menuList[i]['amount']}',
                                  style: pw.TextStyle(
                                      fontSize: 22, color: pdfFontColor))))
                    ],
                  ),
                ),
              // ])
            ])); // Page
    // });
    savePDF(menuName, pdf);
  }

  savePDF(String menuName, pw.Document document) async {
    imageMenuList.clear();
    try {
      await for (var page in Printing.raster(await document.save())) {
        // print('here');
        imageMenuList.add(await page.toPng());
      }
      addMenuImage(imageMenuList);

      // var type = int.parse(widget.menuType.toString());
      // print(type);
      // addMultipleMenuItems();
      for (var x = 0; x < imageMenuList.length; x++) {
        // createDoc['${menuName}_$x.png'] =
        //     imageMenuList[x].buffer.asUint8List();
        final documentDirectory = Platform.isAndroid
            ? (await getExternalStorageDirectory())!.path //FOR ANDROID
            : (await getApplicationSupportDirectory()).path;
        var imgFile = File('$documentDirectory/image$x.png');
        imgFile.writeAsBytesSync(imageMenuList[x].buffer.asUint8List());
        images.add('$documentDirectory/image$x.png');
      }
    } catch (e) {
      print('error $e');
    }
  }

  shareImages(String shortUrl) async {
    print("images ${images.length}");
    await Share.shareFiles(images,
        text: '\n🔗ℚ𝕦𝕚𝕔𝕜 𝕆𝕣𝕕𝕖𝕣 𝕃𝕚𝕟𝕜 : 👉 $shortUrl 🔗\n',
        subject: 'Share Menu Image');
  }

  Future addMenuImage(
      List<Uint8List> pictures,
      ) async {
    dynamic token = await Sharedprefrences.getToken();

    var headers = <String, String>{
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    }; // ignore this headers if there is no authentication
    var url = '$baseUrl/add-image-menu-link';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['id'] = widget.imageMenuId.toString();

    final documentDirectory = Platform.isAndroid
        ? (await getExternalStorageDirectory()) //FOR ANDROID
        : (await getApplicationSupportDirectory());
    var newList = <http.MultipartFile>[];
    print('pictures.length ${pictures.length}');
    for (var i = 0; i < pictures.length; i++) {
      // File imageFile = File(pictures[i].toString());

      var imageFile =
      await File('${documentDirectory!.path}/image_${widget.imageMenuId}$i.jpg')
          .create();
      imageFile.writeAsBytesSync(pictures[i].buffer.asUint8List());

      var multipartFile =
      await http.MultipartFile.fromPath("image_menu_link[]", imageFile.path);
      newList.add(multipartFile);
    }
    print('image_menu_link  ${newList.length}');

    request.files.addAll(newList);
    request.headers.addAll(headers);
    var streamResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamResponse);
    // tempDir.deleteSync(recursive: true);
    // return response;
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      await UpdateMenu(json['data'][0].toString());
      print(json['data'][0].toString());
      print(json['message']);

    } else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
        bool tokenRefreshed = await getNewToken(context);
        tokenRefreshed ? addMenuImage(pictures) : null;
      }
    }else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      print(json['message']);
    }
  }

  Future<void> UpdateMenu(String imageLink) async {
    imageMenuLink = imageLink;
    debugPrint("this is menuid ${widget.imageMenuId}");
    debugPrint("this is theme id $backgroundImageId");
    String token = await Sharedprefrences.getToken();
    final response =
    await http.post(Uri.parse('$baseUrl/create-or-update-menu'), headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'is_menu_completed':'1',
      'id': '${widget.imageMenuId}',
      "type": '2',
      "theme_id": '$backgroundImageId'
    });
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      //menuList = (json['data'][1]['data']);
      print(json['message']);
      return ScaffoldSnackbar.of(context).show(json['message']);

    } else if(response.statusCode == 401) {
      print("refresh token called");
      if (refreshCounter == 0) {
        refreshCounter++;
      bool tokenRefreshed = await getNewToken(context);
      tokenRefreshed ?UpdateMenu(imageLink):null;}
    }else {
      print('Request failed with status: ${response.statusCode}.');
      final json = jsonDecode(response.body);
      return ScaffoldSnackbar.of(context).show(json['message']);
      // print(json['message']);
    }
  }


  @override
  void initState() {
    super.initState();
    getTheme(context, 0);
    Menu().then((value) => getPdfImage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor(),
      appBar: AppBar(
        leading:  BackButton(
          onPressed:() => Navigator.popUntil(context, (route) => route.isFirst),
        ),
        elevation: 0,
        backgroundColor: backgroundColor(),
        title: Text(
          'Create New Image Menu',
          style: cardTitleStyle20(),
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'key_step1'.tr,
                          style: mTextStyle16(),
                        )),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: const Color.fromRGBO(53, 56, 66, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'key_step2'.tr,
                          style: mTextStyle16(),
                        )),
                  ),
                ),
                Card(
                  shadowColor: Colors.black,
                  color: orangeColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.28,
                    height: 45,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'key_step3'.tr,
                          style: mTextStyle16(),
                        )),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          isProceed
              ? Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: backgroundColor(),
                            child: _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: orangeColor()),
                                  )
                                : Image.network(
                                    backgroundImage ??
                                        'https://via.placeholder.com/150x150?text=Default%20Image',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      size: 55,
                                    ),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: orangeColor(),
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          isProceed
                              ? Container()
                              : const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.redAccent,
                                  ),
                                ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                          color: menuFontColor,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        "Dishes In The Menu",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: menuFontColor,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                        color: menuFontColor,
                                        indent: 30,
                                        endIndent: 30,
                                        thickness: 2.0),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: menuList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                            menuList[index][
                                                                    'picture'] ??
                                                                "",
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Image.asset(
                                                    './assets/images/veg.png',
                                                    color: menuList[index]
                                                                ['type'] ==
                                                            'Non veg'
                                                        ? Colors.red
                                                        : Colors.green,
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  menuList[index]['name'] ?? "",
                                                  style: TextStyle(
                                                    color: menuFontColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  '₹ ${menuList[index]['amount']}' ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: menuFontColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ])
              : Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.40,
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: backgroundColor(),
                            child: _isLoading
                                ? Center(
                                    child: CircularProgressIndicator(
                                        color: orangeColor()),
                                  )
                                : Image.network(
                                    backgroundImage ??
                                        'https://via.placeholder.com/150x150?text=Default%20Image',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      size: 55,
                                    ),
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: orangeColor(),
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: menuFontColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: Text(
                                        "Dishes In The Menu",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: menuFontColor,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                        color: menuFontColor,
                                        indent: 30,
                                        endIndent: 30,
                                        thickness: 2.0),
                                    ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: menuList.length,
                                        shrinkWrap: true,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                            menuList[index][
                                                                    'picture'] ??
                                                                "",
                                                            width: 50,
                                                            height: 50,
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Image.asset(
                                                    './assets/images/veg.png',
                                                    color: menuList[index]
                                                                ['type'] ==
                                                            'Non veg'
                                                        ? Colors.red
                                                        : Colors.green,
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  menuList[index]['name'] ?? "",
                                                  style: TextStyle(
                                                    color: menuFontColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Text(
                                                  '₹ ${menuList[index]['amount']}' ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: menuFontColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Themes", style: mTextStyle20()),
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              Text("All", style: mTextStyle14()),
                              const SizedBox(
                                width: 5,
                              ),
                              Image.asset(
                                './assets/images/Arrow - Right.png',
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: SizedBox(
                      height: 50,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: orangeColor(),
                              ),
                            )
                          : ListView.builder(
                              itemCount: themeCategoryList.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          getTheme(this.context, index);
                                        });
                                      },
                                      child: Card(
                                        shadowColor: Colors.black,
                                        color: selectedIndex == index
                                            ? orangeColor()
                                            : const Color.fromRGBO(
                                                53, 56, 66, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: SizedBox(
                                          height: 40,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              themeCategoryList[index]
                                                  .categoryName,
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: mTextStyle14(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                          height: 110,
                          width: MediaQuery.of(context).size.width,
                          child: _isLoading
                              ? const SizedBox()
                              : ListView.builder(
                                  itemCount: image.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Row(children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                              onTap: () async {
                                                selectedBackgroundIndex = index;
                                                backgroundImage =
                                                    image[index].picture;
                                                backgroundImageId = int.parse(image[index].id);
                                                menuFontColor =
                                                    await Utilities()
                                                        .menuTextColor(
                                                            backgroundImage);

                                                pdfFontColor = await Utilities()
                                                    .pdfTextColor(
                                                        backgroundImage);
                                                setState(() {});
                                              },
                                              child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  7),
                                                          topLeft:
                                                              Radius.circular(
                                                                  7)),
                                                  child: Stack(children: [
                                                    SizedBox(
                                                      height: 110,
                                                      width: 140,
                                                      child: Image.network(
                                                        image[index].picture ??
                                                            'https://via.placeholder.com/150x150?text=Default%20Image',
                                                        fit: BoxFit.fill,
                                                        errorBuilder: (context,
                                                                url, error) =>
                                                            const Icon(
                                                          Icons.error,
                                                          size: 25,
                                                        ),
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          }
                                                          return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              color:
                                                                  orangeColor(),
                                                              value: loadingProgress
                                                                          .expectedTotalBytes !=
                                                                      null
                                                                  ? loadingProgress
                                                                          .cumulativeBytesLoaded /
                                                                      loadingProgress
                                                                          .expectedTotalBytes!
                                                                  : null,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Positioned(
                                                        bottom: 0.0,
                                                        child: Container(
                                                            height: 20,
                                                            width: 140,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        3),
                                                            color: selectedBackgroundIndex ==
                                                                    index
                                                                ? orangeColor()
                                                                : menuFontColor,
                                                            child:  Center(
                                                                child: Text(
                                                                    image[index].name??
                                                                        'test',
                                                                    style:
                                                                        const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      color: Colors
                                                                          .black,
                                                                    )))))
                                                  ]))))
                                    ]);
                                  })))
                ]),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  onTap: () async {
                    print("imageMenuLink is $imageMenuLink");
                    var menuName = await Sharedprefrences.getMenuName();
                    if (isProceed) {
                      // share
                      dynamic id = await Sharedprefrences.getId();
                      var fullName = await Sharedprefrences.getFullName();
                      var profileImage = await Sharedprefrences.getProfilePic();
                      var parameters = DynamicLinkParameters(
                        uriPrefix: "https://tastesonway.page.link",
                        link: Uri.parse(
                            'https://www.tastesonway.com/welcome?menuId=${widget.imageMenuId}&buissnessownerId=$id&chefName=$menuName&profileImage=$profileImage'),
                        navigationInfoParameters:
                            const NavigationInfoParameters(
                                forcedRedirectEnabled: true),
                        androidParameters: const AndroidParameters(
                          packageName: 'com.testing.tastesonway.ios.android',
                        ),
                        iosParameters: const IOSParameters(
                            bundleId: 'com.testing.tastesonway.ios',
                            appStoreId: '123456789',
                            minimumVersion: '1.0.0'),
                        socialMetaTagParameters: SocialMetaTagParameters(
                            title: 'Tastes On Way',
                            description: 'Menu by Chef $fullName',
                            imageUrl: Uri.parse(imageMenuLink)),
                      );
                      // var dynamicUrl = await parameters.buildUrl();
                      // var shortLink = await parameters.buildShortLink();
                      // var shortUrl = shortLink.shortUrl;
                      final ShortDynamicLink shortLink =
                          await dynamicLinks.buildShortLink(parameters);
                      // final ShortDynamicLink shortLink = await DynamicLinkParameters.shortenUrl(
                      //     Uri.parse('https://example.page.link/?link=https://example.com/&apn=com.example.android&ibn=com.example.ios'),
                      //     DynamicLinkParametersOptions(ShortDynamicLinkPathLength.unguessable),
                      // );

                      var shortUrl = shortLink.shortUrl;
                      shareImages(shortUrl.toString());
                    } else {
                      isProceed = true;
                      setState(() {});
                      writeOnPdf(menuName, context);
                    }
                  },
                  child: Card(
                      shadowColor: Colors.black,
                      color: orangeColor(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: isProceed
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    './assets/images/whatsapp.png',
                                    width: 24,
                                    height: 24,
                                    color: Colors.white,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Text(
                                      'key_Whatsapp'.tr,
                                      style: mTextStyle14(),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'key_Proceed'.tr,
                                style: mTextStyle14(),
                              ),
                      )),
                )),
          ),
        ],
      ),
    );
  }
}
