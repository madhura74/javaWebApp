package com.example.sample_webapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;



@SpringBootApplication
@RestController
public class SampleWebappApplication {

	public static void main(String[] args) {
		SpringApplication.run(SampleWebappApplication.class, args);
	}
	@GetMapping("/")
	public String hello() {
		return String.format("Hello! Welcome...v1.5");
	}
	

}
