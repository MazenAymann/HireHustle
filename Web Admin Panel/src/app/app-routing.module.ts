import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { AdminComponent } from './admin/admin.component';
import { HrCardComponent } from './hr-card/hr-card.component';
import { ApplicantCardComponent } from './applicant-card/applicant-card.component';
import { JobPostsComponent } from './job-posts/job-posts.component';
import { AdminLoginComponent } from './admin/admin-login/admin-login.component';
import { AddAdminComponent } from './admin/add-admin/add-admin.component';

const routes: Routes = [{ path: 'admin', component: AdminComponent },
  { path: 'hr', component: HrCardComponent },
  { path: 'applicant', component: ApplicantCardComponent },
  {path:'job-posts',component:JobPostsComponent},
  {path:'admin-login',component:AdminLoginComponent},
  {path:'add-admin',component:AddAdminComponent},
  { path: '**', redirectTo: '/admin-login', pathMatch: 'full' }
];


@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
