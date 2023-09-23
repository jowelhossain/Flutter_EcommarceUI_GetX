
import 'package:flutter/material.dart';

import '../model/product_model.dart';
class CartPage extends StatefulWidget {
  CartPage({super.key, this.cartList});
List<ProductModel> ?cartList;
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  var netTotal;
  void getTotal(){
    netTotal= widget.cartList!.map((item) => item.price!*item.quantity.toDouble()).reduce((value, element) => value+element);
  }
  @override
  void initState() {
    // TODO: implement initState
    widget.cartList!.length > 0?getTotal():null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Total item : ${widget.cartList!.length}"),),
      body: Container(
        padding: EdgeInsets.all(5),
        color: Colors.grey,
        child: Column(
          children: [
        Expanded(
          child: ListView.builder(

              itemCount:widget.cartList!.length,
              shrinkWrap: true,
              itemBuilder: (context,index){
           return Padding(
             padding: const EdgeInsets.symmetric(vertical: 5),
             child: Container(
               decoration: BoxDecoration(color: Colors.amber),
              height: 110,
                width:double.infinity ,
                child: Row(children: [
                  Image.network("${widget.cartList![index].image}"),

                  Expanded(
                    child: Column(

                      children: [
                      Padding(padding: EdgeInsets.only(top: 10),child: Text("Stylish ${widget.cartList![index].name}",style: TextStyle(fontSize: 18),)),
                      Padding(padding: EdgeInsets.only(top:4),child: Text("${widget.cartList![index].details}")),


                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                            Text("${widget.cartList![index].price!*widget.cartList![index].quantity}",style:TextStyle(fontSize: 18) ,),

                            Row(children: [
                              IconButton(onPressed: (){
                                widget.cartList![index].quantity<1?widget.cartList!.removeAt(index):widget.cartList![index].quantity--;
                                getTotal();
                                setState(() {

                                });
                              }, icon:Icon(Icons.remove)),
                              Text("${widget.cartList![index].quantity}"),
                              IconButton(onPressed: (){

                                widget.cartList![index].quantity++;
                                getTotal();
                                setState(() {

                                });
                              }, icon:Icon(Icons.add))
                            ],),
                              
                              IconButton(onPressed: (){

                                widget.cartList!.removeAt(index);
                                getTotal();
                                setState(() {

                                });
                              }, icon:Icon(Icons.delete))

                          ],),
                        )
                    ],),
                  )

                ],)

              ),
           );

          }),
        ),


Text("Total Price = ${netTotal??0}", style: TextStyle(fontSize: 24,color: Colors.white)),
          MaterialButton(onPressed: (){},child: Text("Check Out",style: TextStyle(color: Colors.white),),color: Colors.red,)
        ],),
      ),
    );
  }
}
