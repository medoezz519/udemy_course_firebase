import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udemy_flutter/layout/social_app/cubit/states.dart';
import 'package:udemy_flutter/modules/social_app/new_post/new_post_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is SocialNewPostState)
          navigateTo(context, NewPostScreen());
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
             cubit.titles[cubit.currentIndex],
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.notifications_outlined),),
              IconButton(onPressed: (){}, icon: Icon(Icons.search),),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_file), label: 'post'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on_outlined), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
}
