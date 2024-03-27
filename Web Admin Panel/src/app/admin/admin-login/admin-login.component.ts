import { animate, state, style, transition, trigger } from '@angular/animations';
import { Component, EventEmitter, OnInit, Output } from '@angular/core';
import { Router } from '@angular/router';
import { TweenMax, Sine } from 'gsap';
import * as $ from 'jquery';
import { admin } from 'src/app/app.module';
import { Admin } from '../admin.model';
import { AdminService } from './admin.service';

@Component({
  selector: 'app-admin-login',
  templateUrl: './admin-login.component.html',
  styleUrls: ['./admin-login.component.css'],
  animations: [
    trigger('fadeInOut', [
      state('void', style({
        opacity: 0
      })),
      transition('void <=> *', animate(500))
    ])
  ]

})
export class AdminLoginComponent implements OnInit{
  ngOnInit(): void {
    $('#login-button').click(function() {
      $('#login-button').fadeOut("slow", function() {
        $("#container").fadeIn();
        TweenMax.from("#container", .4, { scale: 0, ease: Sine.easeInOut });
        TweenMax.to("#container", .4, { scale: 1, ease: Sine.easeInOut });
      });
    });

    $(".close-btn").click(function() {
      TweenMax.from("#container", .4, { scale: 1, ease: Sine.easeInOut });
      TweenMax.to("#container", .4, { left: "0px", scale: 0, ease: Sine.easeInOut });
      $("#container, #forgotten-container").fadeOut(800, function() {
        $("#login-button").fadeIn(800);
      });
    });

    /* Forgotten Password */
    $('#forgotten').click(function() {
      $("#container").fadeOut(function() {
        $("#forgotten-container").fadeIn();
      });
    });
  }

  user: Admin = {} as Admin;
  username:string ="";
  password:string="";
  constructor(private router:Router,private adminservice:AdminService){}
  adminSigIn(username:string,password:string){
  this.user.username=username;
  this.user.password=password;
  this.adminservice.signIn(this.user).subscribe(
    (response:String)=>{
      if (response == "Done") {
        this.router.navigate(['/admin']);
      }
      else {
        alert("The password or username that you've entered is incorrect.");
        
      }
    });
  }


}
