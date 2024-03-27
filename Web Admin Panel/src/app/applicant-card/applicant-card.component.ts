import { Component, OnInit } from '@angular/core';
import { applicant } from '../app.module';
import { ApplicantService } from './applicant.service';

@Component({
  selector: 'app-applicant-card',
  templateUrl: './applicant-card.component.html',
  styleUrls: ['./applicant-card.component.css']
})
export class ApplicantCardComponent implements OnInit{

  applicants: any[] = [];
  selectedapplicant: applicant = {} as applicant;
  id = 0
  username = ""
  firstname = ""
  email= ""
  enabled= false
  activated= false
  age=0

  applicantlist: any[] = [];
  constructor(private applicantServices:ApplicantService) { }
  ngOnInit(): void {
    this.getAllApplicant();
  }
  getAllApplicant() {
    this.applicantServices.viewAllApplicantS().subscribe((data: any[]) => {
      this.applicants = data;
      this.sortApplicantsById();
    });
  }
  sortApplicantsById(): void {
    this.applicants.sort((a, b) => a.id - b.id);
  }
  toggleAccount(applicant: applicant) {
    this.selectedapplicant.id=applicant.id;
    this.selectedapplicant.enabled = applicant.enabled;
    console.log(applicant.id);
    this.applicantServices.toggleapplicantAccount(applicant).subscribe(() => {
    });
  }

  toggleActivationAccount(applicant: applicant) {
    this.selectedapplicant.id=applicant.id;
    this.selectedapplicant.enabled = applicant.enabled;
    console.log(applicant.id);
    this.applicantServices.toggleapplicantActivation(applicant).subscribe(() => {
    });
  }
}
