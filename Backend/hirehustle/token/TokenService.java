package com.example.hirehustle.token;

import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.hr.HR;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class TokenService {

    private final TokenRepository tokenRepository;

    public void saveToken(Token token) {
        tokenRepository.save(token);
    }

    public Token getToken(String token) {
        return tokenRepository.findByToken(token);
    }

    public void setConfirmedAt(String token) {
        Token confirmationToken = tokenRepository.findByToken(token);
        confirmationToken.setConfirmedAt(LocalDateTime.now());
    }

    public Token generateAuthorizationToken(Applicant applicant, HR hr){
        String token = UUID.randomUUID().toString();
        return new Token(
                token,
                LocalDateTime.now(),
                LocalDateTime.now().plusMinutes(15),
                TokenType.Authorization,
                applicant,
                hr);
    }

    public Token generateAccessToken(Applicant applicant, HR hr){
        String token = UUID.randomUUID().toString();
        Token accessToken = new Token(
                token,
                LocalDateTime.now(),
                LocalDateTime.now().plusHours(24),
                TokenType.Access,
                applicant,
                hr);
        accessToken.setConfirmedAt(LocalDateTime.now());
        return accessToken;
    }

    @Transactional
    public String confirmToken(String token) {

        Token confirmationToken = getToken(token);

        if (confirmationToken.getConfirmedAt() != null){
            return "email is already confirmed";
        }else {
            LocalDateTime expiredAt = confirmationToken.getExpiresAt();

            if (expiredAt.isBefore(LocalDateTime.now())){
                return "token expired";
            }else {
                setConfirmedAt(token);
                return "confirmed";
            }
        }
    }

}
