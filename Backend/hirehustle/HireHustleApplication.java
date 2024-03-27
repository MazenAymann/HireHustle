package com.example.hirehustle;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication

public class HireHustleApplication {

	public String PORT = System.getenv("PORT");

	public static void main(String[] args) {

		SpringApplication.run(HireHustleApplication.class, args);
	}

}
