import 'package:assignment10/core/ui.dart';
import 'package:assignment10/data/models/user/user_model.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment10/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment10/presentation/widgets/gap_widget.dart';
import 'package:assignment10/presentation/widgets/primary_button.dart';
import 'package:assignment10/presentation/widgets/primary_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const routeName = 'edit_profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: SafeArea(
        child: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UserErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is UserLoggedInState) {
              return editProfile(state.userModel);
            }
            return const Center(
              child: Text('An error occured!!'),
            );
          },
        ),
      ),
    );
  }

  Widget editProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Personal Details',
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          labelText: 'Full Name',
          initialValue: userModel.fullName,
          onChanged: (value) {
            userModel.fullName = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'Phone Number',
          initialValue: userModel.phoneNumber,
          onChanged: (value) {
            userModel.phoneNumber = value;
          },
        ),
        const GapWidget(
          size: 20,
        ),
        Text(
          'Address',
          style: TextStyles.body1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const GapWidget(
          size: -10,
        ),
        PrimaryTextField(
          labelText: 'Address',
          initialValue: userModel.address,
          onChanged: (value) {
            userModel.address = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'City',
          initialValue: userModel.city,
          onChanged: (value) {
            userModel.city = value;
          },
        ),
        const GapWidget(),
        PrimaryTextField(
          labelText: 'State',
          initialValue: userModel.state,
          onChanged: (value) {
            userModel.state = value;
          },
        ),
        const GapWidget(),
        PrimaryButton(
          onPressed: () async {
            bool success =
                await BlocProvider.of<UserCubit>(context).updateUser(userModel);
            if (success) {
              Navigator.pop(context);
            }
          },
          text: 'Save',
        ),
      ],
    );
  }
}
