import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumbo_app_flutter/pages/arkit_page.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'pages/basket_page.dart';
import 'pages/catalogue_page.dart';
import 'pages/profile_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BottomNavCubit(),
        child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'Jumbo',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const MainPage(),
        ));
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pageNavigation = [
    const BasketPage(),
    const CataloguePage(),
    const ProfilePage(),
    const ARNavigationWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    return _pageNavigation.elementAt(index);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: context.read<BottomNavCubit>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeBottomNav,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket_outlined), label: "Basket"),
        BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined), label: "Catalogue"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: "Profile"),
        BottomNavigationBarItem(
            icon: Icon(Icons.location_city), label: "Navigation"),
      ],
      iconSize: 33,
      unselectedFontSize: 13,
      selectedFontSize: 13,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xffEEB717),
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomNavCubit>().updateIndex(index);
  }
}
