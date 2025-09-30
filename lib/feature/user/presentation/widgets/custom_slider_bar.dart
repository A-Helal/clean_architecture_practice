import 'package:clean_arch_prac/feature/user/presentation/cubit/user_cubit.dart';
import 'package:clean_arch_prac/feature/user/presentation/widgets/get_user_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomSliderBar extends StatefulWidget {
  const CustomSliderBar({super.key});

  @override
  State<CustomSliderBar> createState() => _CustomSliderBarState();
}

double id = 5;

class _CustomSliderBarState extends State<CustomSliderBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: id,
          onChanged: (value) {
            setState(() {
              id = value;
            });
          },
          min: 1,
          max: 10,
          divisions: 9,
          label: "${id.toInt()}",
        ),
        GetUserButton(
          onPressed: () {
            BlocProvider.of<UserCubit>(context).eitherFailureOrUser(id.toInt());
          },
        ),
      ],
    );
  }
}
