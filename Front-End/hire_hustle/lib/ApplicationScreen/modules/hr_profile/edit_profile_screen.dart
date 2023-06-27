import 'package:flutter/material.dart';
import '../../../global/theme/app_color/app_color_light.dart';
import 'all_page.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HrProfileScreen()),
                );
              },
              icon: const Icon(
                Icons.cancel_outlined,
                size: 30,
              ))
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppColorLight.darkModeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 35),
                  child: CircleAvatar(
                    radius: 55,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your button press logic here
                  },
                  child: const Text('Upload New Photo'),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.displayMedium,
                    initialValue: 'Ahmed Mohamed',
                    decoration: InputDecoration(
                      labelText: 'Name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(Icons.edit,color: AppColorLight.iconColor,),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorLight.iconColor),
                      ),
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    style: Theme.of(context).textTheme.displayMedium,
                    initialValue: 'Software Engineering',
                    decoration: InputDecoration(
                      labelText: 'Role',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(Icons.edit,color: AppColorLight.iconColor,),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorLight.iconColor),
                      ),
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.displayMedium,
                    initialValue: '01140161798',
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(Icons.edit,color: AppColorLight.iconColor,),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorLight.iconColor),
                      ),
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: Theme.of(context).textTheme.displayMedium,
                    initialValue: 'ahmedmagition22@gmail.com',
                    decoration: InputDecoration(
                      labelText: 'Email',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(Icons.edit,color: AppColorLight.iconColor,),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorLight.iconColor),
                      ),
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    keyboardType: TextInputType.datetime,
                    style: Theme.of(context).textTheme.displayMedium,
                    initialValue: '5/7/2001',
                    decoration: InputDecoration(
                      labelText: 'Birthday Date',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      suffixIcon: const Icon(Icons.calendar_month_outlined,color: AppColorLight.iconColor,),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColorLight.iconColor),
                      ),
                      labelStyle: Theme.of(context).textTheme.displayMedium,
                      hintStyle: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your button press logic here
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
