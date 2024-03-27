import { TestBed } from '@angular/core/testing';

import { hrService } from './hr.service';

describe('HrService', () => {
  let service: hrService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(hrService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
