class Applicant {
  late String profileImage;
  late String firstName;
  late String lastName;
  late String username;
  late String email;
  late String password;
  late String mobileNumber;
  late String nationalId;
  late String addressLine;
  late int age;
  late String cvPlaceholder;

  Applicant(
    this.profileImage,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.password,
    this.mobileNumber,
    this.nationalId,
    this.addressLine,
    this.age,
      this.cvPlaceholder,
  );

  Map<String, dynamic> toMap() {
    return {
      'profileImage': this.profileImage,
      'firstName': this.firstName,
      'lastName': this.lastName,
      'username': this.username,
      'email': this.email,
      'password': this.password,
      'mobileNumber': this.mobileNumber,
      'nationalId': this.nationalId,
      'addressLine': this.addressLine,
      'age': this.age,
      'cvPlaceholder': this.cvPlaceholder,
    };
  }
}
