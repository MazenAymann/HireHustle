class JobPost {
  late String jobCategory;
  late String jobTitle;
  late String jobLocation;
  late String jobDescription;
  late String expirationPeriod;
  late String workingHours;
  late String jobRequirements;
  late String salary;
  late String overtime;
  late String benefits;
  late String additionalRequirements;

  JobPost(
      this.jobCategory,
      this.jobTitle,
      this.jobLocation,
      this.jobDescription,
      this.expirationPeriod,
      this.workingHours,
      this.jobRequirements,
      this.salary,
      this.overtime,
      this.benefits,
      this.additionalRequirements,
      );

  Map<String, dynamic> toMap() {
    return {
      'jobCategory': this.jobCategory,
      'jobTitle': this.jobTitle,
      'jobLocation': this.jobLocation,
      'jobDescription': this.jobDescription,
      'expirationPeriod': this.expirationPeriod,
      'workingHours': this.workingHours,
      'jobRequirements': this.jobRequirements,
      'salary': this.salary,
      'overtime': this.overtime,
      'benefits': this.benefits,
      'additionalRequirements': this.additionalRequirements,
    };
  }
}
