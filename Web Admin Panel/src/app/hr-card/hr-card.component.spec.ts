import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HrCardComponent } from './hr-card.component';

describe('HrCardComponent', () => {
  let component: HrCardComponent;
  let fixture: ComponentFixture<HrCardComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ HrCardComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(HrCardComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
