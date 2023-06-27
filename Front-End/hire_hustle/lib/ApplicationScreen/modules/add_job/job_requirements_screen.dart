import 'package:flutter/material.dart';
import '../../../global/theme/app_color/app_color_light.dart';

class JobRequirementsScreen extends StatelessWidget {
  const JobRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Job Requirements'
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
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 30,
                      style: Theme.of(context).textTheme.displayMedium,
                      decoration: InputDecoration(
                        labelText: 'Job Requirements',
                        alignLabelWithHint: true,
                        prefix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.fact_check_outlined),
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
