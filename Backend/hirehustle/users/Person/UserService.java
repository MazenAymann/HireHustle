package com.example.hirehustle.users.Person;

import com.example.hirehustle.users.Person.Person;
import com.example.hirehustle.users.Person.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;

    public void saveUser(Person user){
        userRepository.save(user);
    }

    public boolean isExist(String username, String email){
        boolean usernameIsExist = userRepository.findByUsername(username).isPresent();
        boolean emailIsExist = userRepository.findByEmail(email).isPresent();
        return usernameIsExist || emailIsExist;
    }

}
