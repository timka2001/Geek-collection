import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geek_collectors/boxes.dart';
import 'package:geek_collectors/data/category.dart';
import 'package:geek_collectors/data/collection.dart';
import 'package:geek_collectors/navigation/navigation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class AddCollectionPage extends StatefulWidget {
  AddCollectionPage({super.key, this.category = ''});
  String? category;
  @override
  State<AddCollectionPage> createState() => _AddCollectionPageState();
}

class _AddCollectionPageState extends State<AddCollectionPage> {
  TextEditingController nameCollectionController = TextEditingController();
  TextEditingController yearOfProductionController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Uint8List? _image;
  Future getLostData() async {
    XFile? picker = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picker == null) return;
    List<int> imageBytes = await picker.readAsBytes();
    _image = Uint8List.fromList(imageBytes);
  }

  _updateFormCompletion() {
    bool isFilled = nameCollectionController.text.isNotEmpty &&
        yearOfProductionController.text.isNotEmpty &&
        costController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        widget.category != "" &&
        _image != null;
    setState(() {});
    return isFilled;
  }

  @override
  void initState() {
    super.initState();
    nameCollectionController.addListener(_updateFormCompletion);
    yearOfProductionController.addListener(_updateFormCompletion);
    costController.addListener(_updateFormCompletion);
    descriptionController.addListener(_updateFormCompletion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          child: Text(
            "Add the first collection",
            style: TextStyle(color: Colors.white, fontSize: 24.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              widget.category == ""
                  ? GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          home_screen,
                          arguments: true,
                        ).then((value) {
                          widget.category = value.toString();
                          print(value.toString());
                          setState(() {});
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Container(
                          child: Row(
                            children: [
                              Text(
                                "Select category",
                                style: TextStyle(
                                    color: Colors.pink, fontSize: 20.sp),
                              ),
                              Icon(
                                Icons.add,
                                color: Colors.pink,
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      width: 340.w,
                      child: Text(
                        widget.category.toString(),
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Color(0xFF4477B1),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Pick an image",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 38.h,
              ),
              GestureDetector(
                onTap: () {
                  getLostData().whenComplete(() {
                    _updateFormCompletion();
                  });
                },
                child: Container(
                  height: 170.h,
                  width: 140.w,
                  decoration: BoxDecoration(
                    color: Color(0xFF4477B1).withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    image: _image == null
                        ? null
                        : DecorationImage(
                            image: MemoryImage(_image!), fit: BoxFit.cover),
                  ),
                  child: Center(
                      child: CircleAvatar(
                    radius: 30.r,
                    backgroundColor: Colors.white.withOpacity(0.12),
                    child: Image(image: AssetImage("assets/icons/Image.png")),
                  )),
                ),
              ),
              SizedBox(
                height: 75.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Name of collection",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 55.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: nameCollectionController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: 'Collection',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18.sp)),
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.transparent,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      onChanged: (text) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Year of production",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 55.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: yearOfProductionController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: 'XX.XX.XXXX',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18.sp)),
                      keyboardType: TextInputType.datetime,
                      cursorColor: Colors.transparent,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      onChanged: (text) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Cost",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 55.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Center(
                    child: TextField(
                      controller: costController,
                      decoration: InputDecoration(
                          border: InputBorder.none, // Убираем обводку
                          focusedBorder:
                              InputBorder.none, // Убираем обводку при фокусе
                          hintText: '\$',
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 18.sp)),
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.transparent,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.sp),
                      onChanged: (text) {},
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 310.w,
                child: Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Container(
                height: 120.h,
                width: 310.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    color: Color(0xFF4477B1).withOpacity(0.2),
                    border: Border.all(color: Color(0xFF4477B1))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: TextField(
                    maxLines: 6,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        border: InputBorder.none, // Убираем обводку
                        focusedBorder:
                            InputBorder.none, // Убираем обводку при фокусе
                        hintText: 'Description',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 18.sp)),
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.transparent,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp),
                    onChanged: (text) {},
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30.h),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 14.w),
                          Text(
                            "Back",
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_updateFormCompletion()) {
                          Box<Collection> contactsBox =
                              Hive.box<Collection>(HiveBoxes.collection);
                          Collection addwishfriend = Collection(
                            name_category: widget.category.toString(),
                            image_collection: _image!,
                            name_collection: nameCollectionController.text,
                            year_of_production: yearOfProductionController.text,
                            cost: costController.text,
                            description: descriptionController.text,
                          );
                          contactsBox.add(addwishfriend);
                          Navigator.of(
                            context,
                          ).pop();
                        }
                      },
                      child: Container(
                        width: 320.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                            color: _updateFormCompletion()
                                ? Color(0xFF4477B1)
                                : Color(0xFF4477B1).withOpacity(0.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12.r))),
                        child: Center(
                          child: Text(
                            'Complete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}