import { Component } from '@angular/core';
import { Admin } from '../admin.model';
import { AdminService } from '../admin-login/admin.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-admin',
  templateUrl: './add-admin.component.html',
  styleUrls: ['./add-admin.component.css']
})
export class AddAdminComponent {
  constructor(private router:Router,private adminservice:AdminService){}
  adduser: Admin = {} as Admin;
  username=""
  password=""
adminSignUp(username: string,password: string) {
  this.adduser.username=username;
  this.adduser.password=password;
  console.log(this.adduser)
  this.adminservice.signUp(this.adduser).subscribe(
    (response:String)=>{
      if (response == "Admin is added.") {
        this.router.navigate(['/admin']);
      }
      else {
        alert("username already taken.");
        this.router.navigate(['/add-admin']);
      }
    });
}

}
