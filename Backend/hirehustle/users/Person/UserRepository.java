package com.example.hirehustle.users.Person;

import com.example.hirehustle.users.Person.Person;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<Person, Long> {

    @Query("SELECT s FROM Person s WHERE s.email=?1")
    Optional<Person> findByEmail(String email);

    @Query("SELECT s FROM Person s WHERE s.username=?1")
    Optional<Person> findByUsername(String username);

}
