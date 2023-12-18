import 'package:bloc_deneme/features/cart/ui/cart.dart';
import 'package:bloc_deneme/features/home/bloc/home_bloc.dart';
import 'package:bloc_deneme/features/home/ui/product_tile_widget.dart';
import 'package:bloc_deneme/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => WishListPage()));
        } else if (state is HomeProductItemCartedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item Carted')));
        } else if (state is HomeProductItemWishlistedActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Item Wishlisted')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );

          case HomeLoadedSuccessState:
            final succesSatte = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.teal,
                  title: const Text('Akshit Grocery App'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeWishListButtonNavigateEvent());
                        },
                        icon: Icon(Icons.favorite)),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtonNavigateEvent());
                        },
                        icon: Icon(Icons.shopping_bag_outlined)),
                  ],
                ),
                body: ListView.builder(
                    itemCount: succesSatte.products.length,
                    itemBuilder: (context, index) {
                      return ProductTileWidget(
                          homeBloc: homeBloc,
                          productDataModel: succesSatte.products[index]);
                    }));

          case HomeErrorstate:
            return Scaffold(
              body: Center(child: Text('Error')),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}
