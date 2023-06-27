import 'package:flutter/material.dart';
import 'package:hire_hustle/ApplicationScreen/modules/applicant_list_screen/applicant_list_screen.dart';
import '../../../global/theme/app_color/app_color_light.dart';

class JobViewScreen extends StatefulWidget {
  const JobViewScreen({Key? key}) : super(key: key);

  @override
  _JobViewScreenState createState() => _JobViewScreenState();
}

class _JobViewScreenState extends State<JobViewScreen> {
  bool _isEditing = false;

  // Store the current text values in variables
  String _jobTitle = 'Node.js';
  String _company = 'Google';
  String _location = 'Cairo, Egypt';
  String _jobType = 'Permanent Work';
  String _salary = '7000LE/month';
  String _department = 'Software Engineering';
  String _workingHours = '8 hrs/day';
  String _jobDescription =
      'Software EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware Engineering';
  String _jobRequirements =
      'Software EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware Engineering';
  String _benefits =
      'Software EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware Engineering';
  String _additionalRequirements =
      'Software EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware Engineering';
  String _overTime =
      'Software EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware EngineeringSoftware Engineering';

  @override
  Widget build(BuildContext context) {

    //TODO: Save any change to database

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(_jobTitle),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: PopupMenuButton(
              color: AppColorLight.contactUsTextFieldColor,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  onTap: (){
                    //TODO: implement update job
                    setState(() {
                      _isEditing = true;
                    });
                  },
                  value: 'update',
                  child: Text(
                    'Update Job Description',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
                PopupMenuItem<String>(
                  onTap: (){
                    //TODO: implement delete job
                  },
                  value: 'end',
                  child: Text(
                    'End Job Request',
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ],
              child: const Icon(
                Icons.more_horiz,
                color: AppColorLight.trailIconColor,
              ),
            ),
          ),
        ],
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 170.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColorLight.jobViewContainerColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              _isEditing ? TextFormField(
                                textAlign: TextAlign.center,
                                initialValue: _jobTitle,
                                style: Theme.of(context).textTheme.displayLarge,
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: Theme.of(context).textTheme.displayMedium,
                                ),
                              ) :
                              Text(
                                'Node.js',
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children:  [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.business,
                                        ),
                                        const SizedBox(width: 5,),
                                        _isEditing ? SizedBox(
                                          width: 100,
                                          height: 40,
                                          child: TextFormField(
                                            textAlign: TextAlign.center,
                                            initialValue: _company,
                                            style: Theme.of(context).textTheme.displaySmall,
                                            decoration: InputDecoration(
                                              labelText: 'Company',
                                              labelStyle: Theme.of(context).textTheme.displayMedium,
                                            ),
                                          ),
                                        ) :
                                        Text(
                                          _company,
                                          style: Theme.of(context).textTheme.displaySmall,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 15,),
                                  const Icon(
                                    Icons.location_on_outlined,
                                  ),
                                  const SizedBox(width: 5,),
                                  _isEditing ? SizedBox(
                                    width: 100,
                                    height: 40,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      initialValue: _location,
                                      style: Theme.of(context).textTheme.displaySmall,
                                      decoration: InputDecoration(
                                        labelText: 'Location',
                                        labelStyle: Theme.of(context).textTheme.displayMedium,
                                      ),
                                    ),
                                  ) :
                                  Text(
                                    _location,
                                    style: Theme.of(context).textTheme.displaySmall,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(width: 1, color: AppColorLight.separationLineColor)
                                ),
                                width: 300,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.laptop_chromebook_outlined
                                              ),
                                              const SizedBox(width: 5,),
                                              Text(
                                                'Job Type',
                                                style: Theme.of(context).textTheme.displaySmall,
                                              ),
                                              const SizedBox(width: 5,),
                                              _isEditing ? SizedBox(
                                                height: 100,
                                                width: 120,
                                                child: TextFormField(
                                                  maxLines: 2,
                                                  textAlign: TextAlign.center,
                                                  initialValue: _jobType,
                                                  style: Theme.of(context).textTheme.displayMedium,
                                                ),
                                              ) :
                                              Text(
                                                _jobType,
                                                style: Theme.of(context).textTheme.displayMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          color: AppColorLight.separationLineColor,
                                          width: 1,
                                          height: 70,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                                Icons.monetization_on_outlined
                                            ),
                                            const SizedBox(width: 5,),
                                            Text(
                                              'Salary',
                                              style: Theme.of(context).textTheme.displaySmall,
                                            ),
                                            const SizedBox(width: 5,),
                                            _isEditing ? SizedBox(
                                              height: 100,
                                              width: 120,
                                              child: TextFormField(
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                initialValue: _salary,
                                                style: Theme.of(context).textTheme.displayMedium,
                                              ),
                                            ) :
                                            Text(
                                              _salary,
                                              style: Theme.of(context).textTheme.displayMedium,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Department',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        initialValue: _department,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _department,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Working Hours',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 40,
                                      child: TextFormField(
                                        initialValue: _workingHours,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _workingHours,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Job Description',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 240,
                                      child: TextFormField(
                                        maxLines: 16,
                                        initialValue: _jobDescription,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _jobDescription,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Job Requirements',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 240,
                                      child: TextFormField(
                                        maxLines: 16,
                                        initialValue: _jobRequirements,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _jobRequirements,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Additional Requirements',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 240,
                                      child: TextFormField(
                                        maxLines: 16,
                                        initialValue: _additionalRequirements,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _additionalRequirements,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Benefits',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 240,
                                      child: TextFormField(
                                        maxLines: 16,
                                        initialValue: _benefits,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _benefits,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Overtime',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  const SizedBox(height: 5,),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: _isEditing ? SizedBox(
                                      width: 300,
                                      height: 240,
                                      child: TextFormField(
                                        maxLines: 16,
                                        initialValue: _overTime,
                                        style: Theme.of(context).textTheme.displaySmall,
                                      ),
                                    ) :
                                    Text(
                                      _overTime,
                                      style: Theme.of(context).textTheme.displaySmall,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20,),
                          Center(
                            child: _isEditing? ElevatedButton(
                                onPressed: (){
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                child: const Text('Save')
                            ) :
                            ElevatedButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const ApplicantListScreen()),
                                  );
                                },
                                child: const Text('View Applicants')
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
