import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environment.prod';
import { applicant } from '../app.module';

@Injectable({
  providedIn: 'root'
})
export class ApplicantService {

  constructor(private http:HttpClient) { }
  viewAllApplicantS(): Observable<any> {
    return this.http.get<any>(`${environment.ApiUrl}` + "getAllApplicants");
  }
  toggleapplicantAccount(applicant: applicant): Observable<boolean> {
    if(applicant.enabled == true){
      return this.http.post<boolean>(`${environment.ApiUrl}enableApplicant/${applicant.id}`, {});
    }
    return this.http.post<boolean>(`${environment.ApiUrl}disableApplicant/${applicant.id}`, {});
  }
  toggleapplicantActivation(applicant: applicant): Observable<boolean> {
    if(applicant.activated== true){
      return this.http.post<boolean>(`${environment.ApiUrl}inActiveApplicant/${applicant.id}`, {});
    }
    return this.http.post<boolean>(`${environment.ApiUrl}activeApplicant/${applicant.id}`, {});
  }
}
