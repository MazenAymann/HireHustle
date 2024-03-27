import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environment';
import { hr } from '../app.module';

@Injectable({
  providedIn: 'root'
})
export class hrService {

  constructor(private http:HttpClient) { }
  viewAllHrs(): Observable<any> {
    return this.http.get<any>(`${environment.ApiUrl}` + "getAllHrs");
  }
  toggleHrAccount(hr: hr): Observable<boolean> {
    if(hr.enabled == true){
      return this.http.post<boolean>(`${environment.ApiUrl}enableHr/${hr.id}`, {});
    }
    return this.http.post<boolean>(`${environment.ApiUrl}disableHr/${hr.id}`, {});
  }
  toggleHrActivation(hr: hr): Observable<boolean> {
    if(hr.activated== true){
      return this.http.post<boolean>(`${environment.ApiUrl}activeHr/${hr.id}`, {});
    }
    return this.http.post<boolean>(`${environment.ApiUrl}inActiveHr/${hr.id}`, {});
  }
}
