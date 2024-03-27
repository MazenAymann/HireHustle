import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AdminComponent } from './admin/admin.component';
import { HrCardComponent } from './hr-card/hr-card.component';
import { ApplicantCardComponent } from './applicant-card/applicant-card.component';
import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';
import { MatCardModule } from '@angular/material/card';
import { MatIconModule } from '@angular/material/icon';
import {MatSlideToggleModule} from '@angular/material/slide-toggle';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { JobPostsComponent } from './job-posts/job-posts.component';
import { AdminLoginComponent } from './admin/admin-login/admin-login.component';
import { AddAdminComponent } from './admin/add-admin/add-admin.component';
import { MatDialogModule } from '@angular/material/dialog';


@NgModule({
  declarations: [
    AppComponent,
    AdminComponent,
    HrCardComponent,
    ApplicantCardComponent,
    HeaderComponent,
    FooterComponent,
    JobPostsComponent,
    AdminLoginComponent,
    AddAdminComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatCardModule,
    MatIconModule,
    MatSlideToggleModule,
    FormsModule,
    HttpClientModule,
    MatDialogModule,
  ],
  providers: [],
  
  bootstrap: [AppComponent]
})
export class AppModule { }
export interface hr{
  id :number,
  username :string,
  firstname:string,
  email:string,
  enabled: boolean,
  activated: boolean,
  age:number
}
export interface applicant{
  id :number,
  username :string,
  firstname:string,
  email:string,
  enabled: boolean,
  activated: boolean,
  age:number
}
export interface admin{
  username:string,
  password:string
}
