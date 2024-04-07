import 'package:flutter/material.dart';

import 'package:innovins_task/features/static_pages/models/vegitables.dart';

import '../../core/theme/app_pallete.dart';

class VegitableDetailPage extends StatelessWidget {
  final Vegitables veg;
  const VegitableDetailPage({
    Key? key,
    required this.veg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(veg.image),
              ),
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20))),
            margin:
                EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.35),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 20, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    veg.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppPallete.purpleDark),
                  ),
                  RichText(
                    text: TextSpan(
                      text: veg.price,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppPallete.purpleDark,
                              fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: ' € / piece',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  Text(
                    veg.pergram,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent.shade400),
                  ),
                  Text(
                    veg.country,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppPallete.purpleDark),
                  ),
                  Text(
                    veg.des * 10,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppPallete.purpleDark.withOpacity(0.6)),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            backgroundColor: AppPallete.whiteColor,
                            shadowColor: AppPallete.transparentColor,
                          ),
                          onPressed: () {},
                          child: const Icon(Icons.favorite_border_outlined)),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6)),
                              backgroundColor:
                                  const Color.fromARGB(255, 47, 205, 129),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  color: AppPallete.whiteColor,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'ADD TO CART',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(color: AppPallete.whiteColor),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.02,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
