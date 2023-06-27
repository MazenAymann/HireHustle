import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/settings_screen/setting_screen.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class JobDescriptionScreen extends StatelessWidget {
  const JobDescriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Job Description'
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppColorLight.darkModeImage),
              fit: BoxFit.cover),
        ),
        height: double.infinity,
        width: double.infinity,
        child: SafeArea(
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: 140,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: Theme.of(context).textTheme.displayMedium,
                            decoration: InputDecoration(
                              labelText: 'Title',
                              prefix: const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.title_outlined),
                              ),
                              labelStyle: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: SizedBox(
                          width: 140,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: Theme.of(context).textTheme.displayMedium,
                            decoration: InputDecoration(
                              labelText: 'Location',
                              prefix: const Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.location_on_outlined),
                              ),
                              labelStyle: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 25,
                      style: Theme.of(context).textTheme.displayMedium,
                      decoration: InputDecoration(
                        labelText: 'Full Description',
                        alignLabelWithHint: true,
                        prefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.description_outlined),
                        ),
                        labelStyle: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
