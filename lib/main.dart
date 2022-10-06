import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'animated_switcher_wrapper.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff598D99)))),
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Shopping Cart"),
          ),
          backgroundColor: const Color(0xff598D99),
          actions: const [
            Padding(
                padding: EdgeInsets.only(right: 10), child: Icon(Icons.shop)),
          ],
        ),
        body: const CartBody(),
      ),
    );
  }
}

class CartBody extends StatefulWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CartBody> {


  List<Product> products = [
    Product(name: "Nike", price: 20000),
    Product(name: "Adidas Nike", price: 1000)
  ];
  final totalPriceProvider = StateProvider<int>((ref) {
    return 0;
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF4F4F3),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    height: 70,
                                    child: Image.network(
                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRc74bcb-UZZ0esFbNFkYw8oCSdlnT4AkVDlw&usqp=CAU",
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(products[index].name),
                                        Consumer(
                                            builder: (context, ref, child) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                      "${products[index].price}")),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(
                                                    onTap: () {
                                                      if(ref.watch(products[index].quantity)>0){
                                                        ref
                                                            .read(products[index]
                                                            .quantity
                                                            .state)
                                                            .state--;
                                                        ref
                                                            .read(totalPriceProvider
                                                            .state)
                                                            .state = ref
                                                            .read(
                                                            totalPriceProvider
                                                                .state)
                                                            .state -
                                                            products[index].price;

                                                      }

                                                    },
                                                    child:
                                                        const Icon(Icons.remove)),
                                              ),
                                              AnimatedContainer(
                                                duration: Duration(seconds: 2),
                                                child: Text(
                                                    "${ref.watch(products[index].quantity)}"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: InkWell(

                                                    onTap: () {
                                                      ref
                                                          .read(products[index]
                                                              .quantity
                                                              .state)
                                                          .state++;

                                                      ref
                                                          .read(totalPriceProvider
                                                              .state)
                                                          .state = ref
                                                              .read(
                                                                  totalPriceProvider
                                                                      .state)
                                                              .state +
                                                          products[index].price;
                                                    },
                                                    child: const Icon(Icons.add)),
                                              ),
                                            ],
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                          itemCount: products.length),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Consumer(builder: (context, ref, child) {
                  final totalPrice = ref.watch(totalPriceProvider);

                  return Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Text(
                            "Total Price",
                            style: TextStyle(fontSize: 15),
                          ),
                          
                          trailing: AnimatedSwitcherWrapper(
                              child: Text("$totalPrice")),
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            child: const Center(child: Text("CHECKOUT")))
                      ],
                    ),
                  );
                })
              ],
            ),
          ),
        ));
  }
}

class Product {
  String name;
  int price;
  final quantity = StateProvider<int>((ref) {
    return 0;
  });

  Product({
    required this.name,
    required this.price,
  });
}
