import 'package:flutter/material.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

class AddJobDone extends StatelessWidget {
  const AddJobDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppColorLight.darkModeImage),
                fit: BoxFit.cover
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 100,
              ),
              const SizedBox(height: 20,),
              const Text(
                'Job has been added successfully',
                style: TextStyle(
                  color: AppColorLight.textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              ElevatedButton(
                onPressed: (){
                  //TODO: Implement change password function with validation
                  //TODO: Check logic of the below lines
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Continue',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
