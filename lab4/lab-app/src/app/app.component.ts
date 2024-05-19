import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent implements OnInit {
  title = 'lab-app';
  id : Number = 0;
  name : String = "";
  description : String = "";
  price : Number = 0;
  catigory : String = "";
  brand : String = "";
  stock :Number = 0;
  rating : Number = 0;

  constructor() {}

  ngOnInit(): void {
    
  }
}
