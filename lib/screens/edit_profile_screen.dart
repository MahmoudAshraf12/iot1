import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot/cubit/app_cubit/states.dart';
import '../components/cons.dart';
import '../cubit/app_cubit/cubit.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = AppCubit.get(context).model;

        var profileImage = AppCubit.get(context).profileImage;
        var coverImage = AppCubit.get(context).coverImage;

        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;

        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios),
              color: Colors.black,
            ),
            title: Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 4.0),
                child: defaultButton(
                  function: () {
                    AppCubit.get(context).UpdateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'UPDATE',
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(children: [
                if (state is IotUserUpdateLoadingState)
                  LinearProgressIndicator(),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 190.0,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 140.0,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                                image: DecorationImage(
                                  image: coverImage == null
                                      ? NetworkImage(
                                          '${userModel.cover}',
                                        )
                                      : FileImage(coverImage) as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 20,
                              child: IconButton(
                                onPressed: () {
                                  AppCubit.get(context).getCoverImage();
                                },
                                icon: Icon(Icons.camera_alt_rounded),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          CircleAvatar(
                            radius: 63.0,
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: profileImage == null
                                  ? NetworkImage(
                                      '${userModel.image}',
                                    )
                                  : FileImage(profileImage) as ImageProvider,
                            ),
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: IconButton(
                              onPressed: () {
                                AppCubit.get(context).getProfileImage();
                              },
                              icon: Icon(Icons.camera_alt_rounded),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (AppCubit.get(context).profileImage != null ||
                    AppCubit.get(context).coverImage != null)
                  Row(
                    children: [
                      if (AppCubit.get(context).profileImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                function: () {
                                  AppCubit.get(context).uploadProfileImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'Upload Image ',
                              ),
                              if (state is IotUserUpdateLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is IotUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (AppCubit.get(context).coverImage != null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                function: () {
                                  AppCubit.get(context).uploadCoverImage(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                  );
                                },
                                text: 'Upload Cover ',
                              ),
                              if (state is IotUserUpdateLoadingState)
                                SizedBox(
                                  height: 5.0,
                                ),
                              if (state is IotUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                    ],
                  ),
                if (AppCubit.get(context).profileImage != null ||
                    AppCubit.get(context).coverImage != null)
                  SizedBox(
                    height: 15,
                  ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Name must not be empty';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: bioController,
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Bio must not be empty';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(Icons.info_sharp),
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone must not be empty';
                    }
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}