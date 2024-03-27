import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Helpers/CacheHelper.dart';
import '../../../ThemeData/app_theme.dart';
import '../../../ViewModel/StateManagement/JobList/job_list_cubit.dart';
import '../../../constants.dart';
import '../../Components/Job Posts/custom_job_card.dart';
import '../../Components/snack_bar.dart';
import 'package:provider/provider.dart';


class JobList extends StatelessWidget {
  const JobList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<JobListCubit>(
      create: (context) => JobListCubit()..fetchAllValidJobPosts(),
      child: BlocConsumer<JobListCubit, JobListState>(
        listener: (context, state) {
          if (state is ApiRequestFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                icon: Icons.mood_bad_outlined,
                text: state.apiRequestErrorMessage,
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is JobFetchFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              customSnackBar(
                icon: Icons.mood_bad_outlined,
                text: state.FailedMessage,
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          JobListCubit jobListCubit = JobListCubit.get(context);
          var validJobPosts = jobListCubit.jobList;
          return Container(
            color: Colors.transparent,
            child: validJobPosts == null
                ? Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(207, 97, 161, 1),
              ),
            )
                : ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 200,
                  color: Statics.isDarkMode
                      ? Color.fromARGB(255, 29, 27, 34)
                      : Color.fromARGB(
                      255, 201, 213, 254),
                );
              },
              itemBuilder: (BuildContext context, int index) {
                return JobListCard(
                  context: context,
                  jobTitle: validJobPosts[index]['jobTitle'],
                  jobCategory: validJobPosts[index]['jobCategory'],
                  jobLocation: validJobPosts[index]['jobLocation'],
                  jobCreationTime: jobListCubit.convertDateFormat(
                    validJobPosts[index]['creationTime'],
                  ),
                  jobPostIndex: index,
                  jobPostId: validJobPosts[index]['id'],
                  jobPost: validJobPosts[index],
                );
              },
              itemCount: validJobPosts.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}
