import 'package:flutter/material.dart';
import 'package:hire_hustle/global/theme/app_color/app_color_light.dart';

class ApplicantProfileScreen extends StatelessWidget {
  const ApplicantProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Mazen Ayman'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppColorLight.darkModeImage)
          )
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 15),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: AppColorLight.borderImageColor,
                      radius: 50.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 49.0,
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mazen Ayman',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        const SizedBox(height: 5,),
                        const Text(
                          'Rate: 90%',
                          style: TextStyle(
                              color: AppColorLight.subTextColor,
                              fontSize: 13
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(AppColorLight.textFormFieldFilledColor),
                      ),
                      onPressed: (){
                        //TODO: Open CV
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 80,
                        child: Center(
                            child: Text('CV')
                        ),
                      )
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(AppColorLight.textFormFieldFilledColor),
                      ),
                      onPressed: (){
                        //TODO: Open Technical Information
                      },
                      child: SizedBox(
                        height: 60,
                        width: 80,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Technical'),
                            Text('Information'),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColorLight.jobViewContainerColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                     Text(
                                      'First Name',
                                      style: TextStyle(
                                        color: AppColorLight.textColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Mazen',
                                      style: TextStyle(
                                          color: AppColorLight.subTextColor,
                                          fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Last Name',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Ayman',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Mobile Number',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      '01022936472',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'E-Mail',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'mazenaymanmo22@gmail.com',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'National ID',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      '30007100100893',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Address',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      '10 Ahmed El-Lithy',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Location',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Manial, Cairo',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Nationality',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Egypt',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Military Statue',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Exempted',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 170,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const[
                                    Text(
                                      'Marital Statue',
                                      style: TextStyle(
                                          color: AppColorLight.textColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    Text(
                                      'Single',
                                      style: TextStyle(
                                        color: AppColorLight.subTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(
                                      side: BorderSide(width: 0)
                                  ),
                                  backgroundColor: Colors.green
                              ),
                              onPressed: (){
                                //TODO: Implement applicant accepted
                              },
                              child: const SizedBox(
                                  height: 50,
                                  width: 80,
                                  child: Center(child: Text('Accept'))
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(
                                      side: BorderSide(width: 0)
                                  ),
                                  backgroundColor: Colors.red
                              ),
                              onPressed: (){
                                //TODO: Implement applicant accepted
                              },
                              child: const SizedBox(
                                  height: 50,
                                  width: 80,
                                  child: Center(
                                      child: Text('Reject')
                                  )
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
