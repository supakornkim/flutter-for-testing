import 'package:flutter/material.dart';
import 'package:flutter_stock/models/Product.dart';
import 'package:flutter_stock/services/rest_api.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({Key key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  final formKey = GlobalKey<FormState>();
  String productName, productDetail, productBarcode, productQty, productImage;

  Widget productNameText(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        // icon: Icon(Icons.email),
          prefixIcon: Icon(Icons.mail, color: Colors.teal, size: 24,),
          // hintText: 'you@email.com',
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'Product name',
          labelStyle: TextStyle(
              color: Colors.teal, fontSize: 20
          ),
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          errorStyle: TextStyle(fontSize: 16.0)
      ),
      validator: (value){
        if (value.isEmpty){
          return "pleaase input";
        }else{
          return null;
        }
      },
      onSaved: (value){
        productName = value;
      },
    );
  }

  Widget productDetailText(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        // icon: Icon(Icons.email),
          prefixIcon: Icon(Icons.mail, color: Colors.teal, size: 24,),
          // hintText: 'you@email.com',
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'Product detail',
          labelStyle: TextStyle(
              color: Colors.teal, fontSize: 20
          ),
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          errorStyle: TextStyle(fontSize: 16.0)
      ),
      onSaved: (value){
        productDetail = value;
      },
    );
  }

  Widget productBarcodeText(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        // icon: Icon(Icons.email),
          prefixIcon: Icon(Icons.mail, color: Colors.teal, size: 24,),
          // hintText: 'you@email.com',
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'Product barcode',
          labelStyle: TextStyle(
              color: Colors.teal, fontSize: 20
          ),
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          errorStyle: TextStyle(fontSize: 16.0)
      ),
      onSaved: (value){
        productBarcode = value;
      },
    );
  }

  Widget productQtyText(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        // icon: Icon(Icons.email),
          prefixIcon: Icon(Icons.mail, color: Colors.teal, size: 24,),
          // hintText: 'you@email.com',
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'Product qty',
          labelStyle: TextStyle(
              color: Colors.teal, fontSize: 20
          ),
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          errorStyle: TextStyle(fontSize: 16.0)
      ),
      onSaved: (value){
        productQty = value;
      },
    );
  }

  Widget productImageText(){
    return TextFormField(
      keyboardType: TextInputType.phone,
      autofocus: false,
      style: TextStyle(fontSize: 20, color: Colors.teal),
      decoration: InputDecoration(
        // icon: Icon(Icons.email),
          prefixIcon: Icon(Icons.mail, color: Colors.teal, size: 24,),
          // hintText: 'you@email.com',
          hintStyle: TextStyle(fontSize: 20, color: Colors.grey),
          labelText: 'Product image',
          labelStyle: TextStyle(
              color: Colors.teal, fontSize: 20
          ),
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32.0),
          ),
          errorStyle: TextStyle(fontSize: 16.0)
      ),
      onSaved: (value){
        productImage = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Form(
          key: formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: productNameText(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: productDetailText(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: productBarcodeText(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: productImageText(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: productQtyText(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: RaisedButton(
                  onPressed:() async {

                    if (formKey.currentState.validate()){
                      formKey.currentState.save();
                      print('validation pass');
                      print('productname = $productName, productdetail=$productDetail');
                    }
                    Product productdata = new Product(
                        productName:productName,
                        productDetail:productDetail,
                        productBarcode:productBarcode,
                        productCategory:'Computer',
                        productImage:productImage,
                        productPrice: '8900',
                        productQty:int.parse(productQty),
                        productStatus: 1,
                        createdAt:new DateTime.now(),
                        updatedAt:new DateTime.now(),
                    );

                    print(productdata);
                    var response = await CallAPI().createProduct(productdata);
                    print(response);
                    if (response == true) {
                      print(response);
                      //Navigator.pushNamed(context, '/dashboard');
                      Navigator.pop(context, true);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('submit'),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}