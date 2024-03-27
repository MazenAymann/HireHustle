package com.example.hirehustle.token;

import com.example.hirehustle.users.Applicant.Applicant;
import com.example.hirehustle.users.hr.HR;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
@Table(name = "tokens")
public class Token {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String token;
    @Column(nullable = false)
    private LocalDateTime startedAt;
    @Column(nullable = false)
    private LocalDateTime expiresAt;
    private LocalDateTime confirmedAt;
    private TokenType tokenType;

    @ManyToOne
    @JoinColumn(
            name = "ApplicantId"
    )
    @JsonIgnoreProperties("tokens")
    private Applicant applicant;

    @ManyToOne
    @JoinColumn(
            name = "HrId"
    )
    @JsonIgnoreProperties("tokens")
    private HR hr;

    public Token(String token,
                 LocalDateTime startedAt,
                 LocalDateTime expiresAt,
                 TokenType tokenType,
                 Applicant applicant,
                 HR hr) {
        this.token = token;
        this.startedAt = startedAt;
        this.expiresAt = expiresAt;
        this.tokenType = tokenType;
        this.hr = hr;
        this.applicant = applicant;
    }
}
