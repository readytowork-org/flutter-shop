import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/products_provider.dart';

class AddEditProductScreen extends StatefulWidget {
  static const routeName = "/add-edit-product";
  const AddEditProductScreen({Key? key}) : super(key: key);

  @override
  State<AddEditProductScreen> createState() => _AddEditProductScreenState();
}

class _AddEditProductScreenState extends State<AddEditProductScreen> {
  final _priceNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _imageUrlNode = FocusNode();
  final _form = GlobalKey<FormState>();

  final _imageUrlController = TextEditingController();

  var _editedProduct = Product(
    id: null,
    title: '',
    description: '',
    price: 0,
    imageUrl: '',
  );

  var _isInit = true;
  var _isLoading = false;
  var _inititalValue = {
    'title': '',
    'price': '',
    'description': '',
  };

  @override
  void initState() {
    _imageUrlNode.addListener(_updateImageUrl);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final productId = ModalRoute.of(context)!.settings.arguments as String;
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _inititalValue = {
          'title': _editedProduct.title!,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description!,
          'imageUrl': ''
        };
        _imageUrlController.text = _editedProduct.imageUrl!;
      }
    }
    _isInit = false;

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    //Dispose nodes on widget close to avoid memory leak
    _priceNode.dispose();
    _descriptionNode.dispose();
    _imageUrlNode.dispose();
    _imageUrlNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlNode.hasFocus) {
      if (!_imageUrlController.text.startsWith('http') &&
              !_imageUrlController.text.startsWith('https') ||
          !_imageUrlController.text.endsWith('jpg') &&
              !_imageUrlController.text.endsWith('jpge') &&
              !_imageUrlController.text.endsWith('png')) {
        return;
      }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _form.currentState!.save();

    if (_editedProduct.id != null) {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id!, _editedProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (error) {
        // print(error);
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Error Occured"),
            content: const Text("Something went wrong"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Close"),
              )
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      //   Navigator.of(context).pop();
      // }

    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();

    // Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _inititalValue['title'],
                      decoration: const InputDecoration(
                        labelText: 'Product Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the value';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value,
                            description: _editedProduct.description,
                            price: _editedProduct.price,
                            imageUrl: _editedProduct.imageUrl,
                            isFavourite: _editedProduct.isFavourite);
                      },
                    ),
                    TextFormField(
                      initialValue: _inititalValue['price'],
                      decoration: const InputDecoration(
                        labelText: 'Price',
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _priceNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the value';
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            description: _editedProduct.description,
                            price: double.tryParse(value as String),
                            imageUrl: _editedProduct.imageUrl,
                            isFavourite: _editedProduct.isFavourite);
                      },
                    ),
                    TextFormField(
                      initialValue: _inititalValue['description'],
                      decoration: const InputDecoration(
                        labelText: 'Description',
                      ),
                      maxLines: 3,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionNode,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_imageUrlNode);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the value';
                        }
                        if (value.length < 10) {
                          return 'Should be longer than 10 characters';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          description: value,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          isFavourite: _editedProduct.isFavourite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 16),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: _imageUrlController.text.isEmpty
                              ? const Center(
                                  child: Text(
                                  "Enter a URL",
                                  textAlign: TextAlign.center,
                                ))
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Image URL',
                            ),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlNode,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the value';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return "Please enter correct url";
                              }
                              if (!value.endsWith('jpg') &&
                                  !value.endsWith('jpge') &&
                                  !value.endsWith('png')) {
                                return "Please enter correct url with image";
                              }
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              _saveForm();
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                id: _editedProduct.id,
                                title: _editedProduct.title,
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                imageUrl: value,
                                isFavourite: _editedProduct.isFavourite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        _saveForm();
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
