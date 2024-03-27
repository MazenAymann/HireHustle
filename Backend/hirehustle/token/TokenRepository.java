package com.example.hirehustle.token;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface TokenRepository extends JpaRepository<Token, Long> {

    @Query("SELECT token FROM Token token WHERE token.token=?1")
    Token findByToken(String token);
}
