import 'package:clean_arch_prac/core/connection/network_info.dart';
import 'package:clean_arch_prac/feature/user/presentation/cubit/user_cubit.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/custom_appbar.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/custom_slider_bar.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final networkInfo = NetworkInfoImpl();
    return BlocProvider(
      create: (context) => UserCubit()..eitherFailureOrUser(1),
      child: Scaffold(
        appBar: const CustomAppbar(),
        body: StreamBuilder(
          initialData: false,
          stream: networkInfo.onConnectionChange,
          builder: (context, snapshots) {
            final connected = snapshots.data ?? false;
            if (!connected) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Text(
                      "Ooops!",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'No Internet Connection',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffFFA61A),
                      ),
                    ),
                    SizedBox(height: 50),
                    Lottie.asset("assets/no_connection.json"),
                    SizedBox(height: 50),
                  ],
                ),
              );
            } else {
              return BlocConsumer<UserCubit, UserState>(
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
                    return Column(
                      children: [Lottie.asset("assets/loading.json")],
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
