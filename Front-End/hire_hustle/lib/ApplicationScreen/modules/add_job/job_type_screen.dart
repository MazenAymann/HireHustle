import 'package:flutter/material.dart';

import '../../../global/theme/app_color/app_color_light.dart';

class JobTypeSelectionScreen extends StatefulWidget {
  const JobTypeSelectionScreen({super.key});

  @override
  State<JobTypeSelectionScreen> createState() => _JobTypeSelectionScreenState();
}

class _JobTypeSelectionScreenState extends State<JobTypeSelectionScreen> {
  int _selectedIndex = -1;
  final List<String> _itemNames = ['Front-End', 'Back-End', 'Full-Stack', 'Artificial Intelligence'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
            'Department'
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppColorLight.darkModeImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              height: 500,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(_itemNames.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index ? AppColorLight.gridSelectedColor : AppColorLight.gridUnselectedColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                image: AssetImage(
                                    'images/${_itemNames[index]}.png'
                                ),
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 20,),
                            Text(
                                _itemNames[index],
                              style: Theme.of(context).textTheme.displayMedium
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}