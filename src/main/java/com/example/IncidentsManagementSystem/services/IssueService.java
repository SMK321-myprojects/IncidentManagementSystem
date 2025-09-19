package com.example.IncidentsManagementSystem.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.IncidentsManagementSystem.entities.Issue;
import com.example.IncidentsManagementSystem.repositories.IssueRepository;

@Service
public class IssueService {
	
	@Autowired
	private IssueRepository ir;
	
	
	public List<Issue> findAll(){
		return ir.findAll();
	}
	
	public List<Issue> findByUsername(String username){
		return ir.findByUsername(username);
	}
	
	public void deleteByid(int id) {
		ir.deleteById(id);
	}
	
	public void raiseIssue(Issue issue) {
		ir.save(issue);
	}
	
	public Issue findById(int id) {
		return ir.getById(id);
	}
	

}
