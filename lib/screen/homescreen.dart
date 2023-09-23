import 'package:ecommarce_ui_flutter_getx/model/product_model.dart';
import 'package:ecommarce_ui_flutter_getx/screen/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
List<ProductModel> cartList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
child: ListView(children: [
  DrawerHeader(child: Row(children: [
    CircleAvatar(backgroundImage: NetworkImage("https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&w=1000&q=80")),
    Text("User Name")
  ],))
],),
      ),
      appBar: AppBar(title: Text("Ecommarce UI"),centerTitle: true,actions: [
        Stack(children: [IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CartPage(cartList: cartList)));
        }, icon: Icon(CupertinoIcons.cart)),
        Positioned(
            top: 0,
            right: 0,
            child: Text("${cartList.length}",style: TextStyle(fontSize:15, color: Colors.black),))

        ]),
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications_on_outlined))

      ],
      backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Container(
          
          width: double.infinity,
          //height: MediaQuery.of(context).size.height*1,
          decoration: BoxDecoration(),
          padding: EdgeInsets.all(5),
          child: Column(children: [
              GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, mainAxisSpacing: 5, crossAxisSpacing: 5),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: productList.length,
                  itemBuilder: (context,index){
                return Container(
                  height: 70,
                  decoration: BoxDecoration(color: Colors.orange.withOpacity(.5),
                  borderRadius: BorderRadius.circular(10)
                  ),

                  child: Column(children: [
                    AspectRatio(child:Image.network("${productList[index].image}",fit:BoxFit.cover,),aspectRatio: 1.4,),
                    Text("${productList[index].name}",style: TextStyle(fontSize: 18),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("${productList[index].price}",style: TextStyle(color: Colors.green, fontSize: 16),),
                        GestureDetector(
                            onTap: (){
                              try{

                                cartList.firstWhere((element) => element.id==productList[index].id);
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text("Already Added this item"),
                                  duration: Duration(milliseconds: 300),
                                ));
                              }catch(e){cartList.add(productList[index]);}
                              setState(() {

                              });
                            },
                            child: Icon(Icons.shopping_cart))
                      ],
                    )


                  ],),

                );
                
                  })
          ],),
        ),
      ),
    );
}}
