import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { hr } from '../app.module';
import { hrService } from './hr.service';

@Component({
  selector: 'app-hr-card',
  templateUrl: './hr-card.component.html',
  styleUrls: ['./hr-card.component.css']
})
export class HrCardComponent  implements OnInit{
  selectedHr: hr = {} as hr;
  id = 0
  username = ""
  firstname = ""
  email= ""
  enabled= false
  activated= false
  age=0

navigateToJobPosts(id:Number) {
  this.router.navigate(['/job-posts']);
}
  hrs: any[] = [];
  constructor (private hrservices:hrService,private router: Router){}
  ngOnInit(): void{
    this.getAllHRS();
  }
  getAllHRS(){
    this.hrservices.viewAllHrs().subscribe((data:any[])=>{
      this.hrs=data;
      this.sortHrsById();
    });
  }
  sortHrsById(): void {
    this.hrs.sort((a, b) => a.id - b.id);
  }
  toggleAccount(hr: hr) {
    this.selectedHr.id=hr.id;
    this.selectedHr.enabled = hr.enabled;
    console.log(hr.id);
    this.hrservices.toggleHrAccount(hr).subscribe(() => {
    });
  }

  toggleActivationAccount(hr: hr) {
    this.selectedHr.id=hr.id;
    this.selectedHr.enabled = hr.enabled;
    console.log(hr.id);
    this.hrservices.toggleHrActivation(hr).subscribe(() => {

    });
  }
}
