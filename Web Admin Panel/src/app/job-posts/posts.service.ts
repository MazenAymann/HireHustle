import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { environment } from 'src/environment';
@Injectable({
  providedIn: 'root'
})
export class PostsService {

  constructor(private jobposts:HttpClient) { }
  viewAllPosts(): Observable<any> {
    return this.jobposts.get<any>(`${environment.ApiUrl}` + "getAllJobPosts");
  }
}
