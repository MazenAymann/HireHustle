package com.example.hirehustle.users.admin;

import com.example.hirehustle.token.Token;
import com.example.hirehustle.token.TokenService;
import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.Applicant.ApplicantRepository;
import com.example.hirehustle.users.Applicant.ApplicantService;
import com.example.hirehustle.users.hr.HR;
import com.example.hirehustle.users.hr.HRRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final AdminRepository adminRepository;
    private final ApplicantRepository applicantRepository;
    private final HRRepository hrRepository;
    public String addAdmin(Admin admin){
        if (adminIsExist(admin.getUsername())){
            return "username is already taken.";
        }
        adminRepository.save(admin);
        return "Admin is added.";
    }

    public String adminLogin(Admin admin){
        if (!dataIsValid(admin.getUsername(),admin.getPassword())){
            return "The password or username that you've entered is incorrect.";
        }
        return "Done";
    }

    public boolean adminIsExist(String username){
        return adminRepository.adminIsExist(username).isPresent();
    }

    private boolean dataIsValid(String username, String password){
        return adminRepository.dataIsValid(username,password).isPresent();
    }






}
