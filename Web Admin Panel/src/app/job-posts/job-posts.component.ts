import { Component, OnInit } from '@angular/core';
import { PostsService } from './posts.service';


@Component({
  selector: 'app-job-posts',
  templateUrl: './job-posts.component.html',
  styleUrls: ['./job-posts.component.css']
})
export class JobPostsComponent implements OnInit {
  p: any[] = [];

  constructor(private posts:PostsService) { }

  ngOnInit(): void{
    this.getAllPost();
    
  }
  getAllPost(){
    this.posts.viewAllPosts().subscribe((data:any[])=>{
      this.p=data;
      this.sortPostsById();
    });
  }
  sortPostsById() {
    this.p.sort((a, b) => a.id - b.id);
  }


}
