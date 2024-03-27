import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Admin } from '../admin.model';
import { Observable } from 'rxjs';
import { environment } from 'src/environment.prod';

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  constructor(private http:HttpClient, ) {}
  signIn(admin : Admin): Observable<String> {
    const body = { username: admin.username, password: admin.password};
    return this.http.post<String>(`${environment.ApiUrl}`+ "adminLogin", body, { responseType: 'text' as 'json' });
  }
  signUp(admin : Admin): Observable<String> {
    const body = { username: admin.username, password: admin.password};
    return this.http.post<String>(`${environment.ApiUrl}`+ "addAdmin", body, { responseType: 'text' as 'json' });
  }
  
}
