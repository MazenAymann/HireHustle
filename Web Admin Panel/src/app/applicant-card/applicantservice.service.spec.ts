import { TestBed } from '@angular/core/testing';

import { ApplicantserviceService } from './applicantservice.service';

describe('ApplicantserviceService', () => {
  let service: ApplicantserviceService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ApplicantserviceService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
