import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:ecommerce/backend/models/product.dart';
import 'package:ecommerce/backend/services/db_products.dart';
import 'package:ecommerce/frontend/pages/registration/custom_textfield.dart';
import 'package:ecommerce/frontend/widgets/global_appbar.dart';
import 'package:ecommerce/frontend/widgets/global_btn.dart';
import 'package:ecommerce/frontend/widgets/gradient_border.dart';
import 'package:ecommerce/frontend/widgets/gradient_widget.dart';

import '../../../constants.dart';

enum PageMode { add, edit }

class AddProduct extends StatefulWidget {
  static const String routeName = 'addProduct';

  final mode;
  final data;

  const AddProduct({Key key, this.mode, this.data}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  String valueChooser, name, price, amount, description;
  String id = ProductsDB().getId();
  List items = ['Electronics', 'chemicals', 'Equipments'];
  PageMode pageMode;
  File image;
  String imgUrl;
  final picker = ImagePicker();
  var formKey = GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();

  Product product;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController descController = TextEditingController();

  Future getImage(source) async {
    final pickedFile = await picker.getImage(source: source, imageQuality: 30);
    setState(() {
      image = File(pickedFile.path);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    amountController.dispose();
    descController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    product = widget.data;
    if (widget.mode == 'add') {
      setState(() {
        pageMode = PageMode.add;
      });
    } else {
      setState(() {
        pageMode = PageMode.edit;
        nameController.text = product.name;
        priceController.text = product.price;
        amountController.text = product.amount;
        descController.text = product.description;
        valueChooser = product.category;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(
        title: 'Add Product',
        icon: Icons.arrow_back_ios_rounded,
        onClick: () {
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: formKey,
              child: Column(
                children: [
/*------------------------------------------------------------------------------------*/
/*----------------------------------  Product Image  ---------------------------------*/
/*------------------------------------------------------------------------------------*/
                  GestureDetector(
                    onTap: () async {
                      showDialoge(
                          context,
                          Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  child: Text("Camera"),
                                  onPressed: () {
                                    setState(() {
                                      getImage(ImageSource.camera).then(
                                        (value) => Navigator.of(context).pop(),
                                      );
                                    });
                                  },
                                ),
                              ),
                              Expanded(
                                child: MaterialButton(
                                  child: Text("Gallery"),
                                  onPressed: () {
                                    setState(() {
                                      getImage(ImageSource.gallery).then(
                                        (value) => Navigator.of(context).pop(),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ],
                          ));
                    },
                    child: GradientBorder(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 160,
                      radius: 20,
                      child: (pageMode == PageMode.add)
                          ? (image == null)
                              ? GradientWidget(
                                  child: Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 35,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.file(image),
                                )
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.network(product.img),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
/*------------------------------------------------------------------------------------*/
/*----------------------------------  Product Name  ----------------------------------*/
/*------------------------------------------------------------------------------------*/
                  CustomTextField(
                    controller: nameController,
                    icon: Icons.title_rounded,
                    hint: 'Name',
                    inputAction: TextInputAction.next,
                    kType: TextInputType.name,
                    onSave: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
/*------------------------------------------------------------------------------------*/
/*--------------------------------  Product Category  --------------------------------*/
/*------------------------------------------------------------------------------------*/
                  _dropdownBtn(context),
                  const SizedBox(height: 10),
/*------------------------------------------------------------------------------------*/
/*----------------------------------  Product Price  ---------------------------------*/
/*------------------------------------------------------------------------------------*/
                  CustomTextField(
                    controller: priceController,
                    icon: Icons.money_outlined,
                    focusNode: focusNode,
                    hint: 'Price',
                    inputAction: TextInputAction.next,
                    kType: TextInputType.name,
                    onSave: (value) {
                      setState(() {
                        price = value;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
/*------------------------------------------------------------------------------------*/
/*--------------------------------  Product Quantity  --------------------------------*/
/*------------------------------------------------------------------------------------*/
                  CustomTextField(
                    controller: amountController,
                    icon: Icons.equalizer_outlined,
                    hint: 'Quantity',
                    inputAction: TextInputAction.next,
                    kType: TextInputType.name,
                    onSave: (value) {
                      setState(() {
                        amount = value;
                      });
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
/*------------------------------------------------------------------------------------*/
/*------------------------------  Product Description  -------------------------------*/
/*------------------------------------------------------------------------------------*/
                  _descriptionField(context),
                  const SizedBox(height: 20),
/*------------------------------------------------------------------------------------*/
/*--------------------------------  Add Product Btn  ---------------------------------*/
/*------------------------------------------------------------------------------------*/
                  GlobalBtn(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 50,
                    text: (pageMode == PageMode.add) ? "Add" : "Edit",
                    onClick: (pageMode == PageMode.add)
                        ? () async {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              await uploadImage();
                              ProductsDB()
                                  .saveData(Product(
                                    name: name,
                                    description: description,
                                    amount: amount,
                                    price: price,
                                    category: valueChooser,
                                    id: id,
                                    img: imgUrl,
                                  ))
                                  .then((value) => Navigator.of(context).pop());
                            }
                          }
                        : () {
                            if (formKey.currentState.validate()) {
                              formKey.currentState.save();
                              ProductsDB()
                                  .updateData(
                                    Product(
                                      name: name,
                                      description: description,
                                      amount: amount,
                                      price: price,
                                      category: valueChooser,
                                      img: product.img,
                                      id: product.id,
                                    ),
                                  )
                                  .then(
                                    (value) => Navigator.of(context).pop(),
                                  );
                            }
                          },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

/*--------------------------------------------------------------------------------------------*/
/*--------------------------------  Dropdown Menu Btn Func.  ---------------------------------*/
/*--------------------------------------------------------------------------------------------*/
  _dropdownBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.83,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        borderRadius: BorderRadius.circular(60),
      ),
      child: DropdownButton(
        itemHeight: 50,
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        isExpanded: true,
        hint:const Text('Select Category'),
        icon: GradientWidget(child:const Icon(Icons.keyboard_arrow_down_rounded)),
        underline:const SizedBox(),
        autofocus: true,
        value: valueChooser,
        items: items.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            valueChooser = value;
            FocusScope.of(context).requestFocus(focusNode);
          });
        },
      ),
    );
  }

/*--------------------------------------------------------------------------------------------*/
/*--------------------------------  Description TField Func.  --------------------------------*/
/*--------------------------------------------------------------------------------------------*/
  _descriptionField(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: descController,
        onSaved: (value) {
          setState(() {
            description = value;
          });
        },
        validator: (value) {
          return null;
        },
        maxLines: 6,
        cursorColor: Theme.of(context).accentColor,
        decoration: InputDecoration(
          labelText: 'Description',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).accentColor, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        ),
      ),
    );
  }

/*--------------------------------------------------------------------------------------------*/
/*-----------------------------------  Upload Image Func.  -----------------------------------*/
/*--------------------------------------------------------------------------------------------*/
  uploadImage() async {
    try {
      FirebaseStorage storage =
          FirebaseStorage(storageBucket: "gs://ecommerce-c03f5.appspot.com/");
      StorageReference ref =
          storage.ref().child('products').child(id).child(basename(image.path));
      var task = ref.putFile(image);
      StorageTaskSnapshot snap = await task.onComplete;
      String url = await snap.ref.getDownloadURL();
      setState(() {
        imgUrl = url;
      });
    } catch (e) {
      print(e);
    }
  }
}
