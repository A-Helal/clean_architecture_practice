import 'package:clean_arch_prac/feature/user/presentation/cubit/user_cubit.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/custom_appbar.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/custom_slider_bar.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/get_user_button.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..eitherFailureOrUser(1),
      child: Scaffold(
        appBar: const CustomAppbar(),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetUserSuccessfully) {
              return ListView(
                children: [
                  UserData(user: state.user),
                  const CustomSliderBar(),

                ],
              );
            } else if (state is GetUserFailure) {
              return Center(child: Text(state.errMessage));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
