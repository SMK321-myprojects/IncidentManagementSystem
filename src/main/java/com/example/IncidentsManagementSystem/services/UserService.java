package com.example.IncidentsManagementSystem.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.IncidentsManagementSystem.entities.User;
import com.example.IncidentsManagementSystem.repositories.UserRepository;

@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	
	public User findByUsername(String username) {
		return userRepository.findByUsername(username);
	}

	public void addUser(User user) {
		userRepository.save(user);	
	}

}
