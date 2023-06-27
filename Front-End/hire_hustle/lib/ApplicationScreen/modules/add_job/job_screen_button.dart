import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/add_job/add_job_screen.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class JobScreenButton extends StatelessWidget {
  const JobScreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: Put image and some words
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage('images/logo.png'),
                    height: 60,
                    width: 60,
                  ),
                  Text(
                    'HireHustle',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
              Text(
                'App Version: 1.0.0',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              SizedBox(height: MediaQuery.of(context).size.height/40,),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AddJobScreen()),
                  );
                },
                child: const Text(
                  'Add Job'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
