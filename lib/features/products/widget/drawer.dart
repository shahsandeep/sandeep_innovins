import 'package:flutter/material.dart';

import 'package:innovins_task/core/utils/shared_pref.dart';
import 'package:innovins_task/features/auth/pages/login_page.dart';
import 'package:innovins_task/features/products/widget/sidebar_widget.dart';
import 'package:innovins_task/features/static_pages/models/vegitables.dart';
import 'package:innovins_task/features/static_pages/vegitable_page.dart';

import '../../static_pages/vegitable_detail.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * 0.7,
      child: SafeArea(
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SideMenuTileWidget(
                  onTap: () {
                    Navigator.push(context, VegitablePage.route(context));
                  },
                  text: 'Vegitables',
                ),
                const SizedBox(
                  height: 20,
                ),
                SideMenuTileWidget(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VegitableDetailPage(veg: veg[0]),
                    ));
                  },
                  text: 'Veg Details',
                ),
                const Spacer(),
                SideMenuTileWidget(
                  onTap: () {
                    SharedPref.clearSharedPreference(context);
                    Navigator.pushAndRemoveUntil(
                        context, LoginPage.route(context), (route) => false);
                  },
                  text: 'Sign Out',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
