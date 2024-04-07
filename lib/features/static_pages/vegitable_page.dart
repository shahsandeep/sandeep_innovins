import 'package:flutter/material.dart';

import 'package:innovins_task/core/theme/app_pallete.dart';
import 'package:innovins_task/core/theme/theme.dart';
import 'package:innovins_task/features/static_pages/vegitable_detail.dart';

import 'models/vegitables.dart';

class VegitablePage extends StatefulWidget {
  static route(BuildContext context) => MaterialPageRoute(
        builder: (context) => const VegitablePage(),
      );

  const VegitablePage({super.key});

  @override
  State<VegitablePage> createState() => _VegitablePageState();
}

class _VegitablePageState extends State<VegitablePage> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.getFlexTheme().copyWith(
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: AppPallete.whiteColor),
      ),
      child: Scaffold(
        bottomSheet: Container(
          padding: const EdgeInsets.all(10),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.home,
                  color: AppPallete.purple,
                ),
                Icon(Icons.shopping_cart_outlined),
                Icon(Icons.person)
              ],
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  child: Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        'assets/images/background.png',
                        width: MediaQuery.sizeOf(context).width * 0.45,
                        height: MediaQuery.sizeOf(context).height * 0.26,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.04,
                        ),
                        Text(
                          'Vegetables',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppPallete.purpleDark),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[200],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              hintText: 'Search',
                              contentPadding: const EdgeInsets.all(8),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.02,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  for (int i = 0;
                                      i < filter.length / 2;
                                      i++) ...[
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: FilterChip(
                                        label: Text(filter[i]),
                                        backgroundColor: Colors.transparent,
                                        shape: const StadiumBorder(
                                            side: BorderSide()),
                                        selected: i % 2 == 0 ? true : false,
                                        onSelected: (bool value) {},
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Column(
                                children: [
                                  for (int i = 0;
                                      i < filter.length / 2;
                                      i++) ...[
                                    Container(
                                      margin: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: FilterChip(
                                        label: Text(filter[i]),
                                        backgroundColor: Colors.transparent,
                                        shape: const StadiumBorder(
                                            side: BorderSide()),
                                        selected: i % 2 == 0 ? true : false,
                                        onSelected: (bool value) {},
                                      ),
                                    ),
                                  ],
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.5,
                          child: ListView.builder(
                            itemCount: veg.length,
                            itemBuilder: (context, index) {
                              final i = veg[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        VegitableDetailPage(veg: i),
                                  ));
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    bottom: 15,
                                  ),
                                  child: IntrinsicHeight(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.14,
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                i.image,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              i.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      color:
                                                          AppPallete.purpleDark,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: i.price,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                        color: AppPallete
                                                            .purpleDark,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                children: [
                                                  TextSpan(
                                                    text: ' € / kg',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      side: const BorderSide(
                                                          color: Colors.grey),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      backgroundColor:
                                                          AppPallete.whiteColor,
                                                      shadowColor: AppPallete
                                                          .transparentColor,
                                                    ),
                                                    onPressed: () {},
                                                    child: const Icon(Icons
                                                        .favorite_border_outlined)),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              47,
                                                              205,
                                                              129),
                                                    ),
                                                    onPressed: () {},
                                                    child: const Icon(
                                                      Icons
                                                          .shopping_cart_outlined,
                                                      color:
                                                          AppPallete.whiteColor,
                                                    ))
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
