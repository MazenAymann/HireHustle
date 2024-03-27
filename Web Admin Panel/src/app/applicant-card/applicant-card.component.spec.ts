import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ApplicantCardComponent } from './applicant-card.component';

describe('ApplicantCardComponent', () => {
  let component: ApplicantCardComponent;
  let fixture: ComponentFixture<ApplicantCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ApplicantCardComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(ApplicantCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
