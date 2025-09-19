package com.example.IncidentsManagementSystem.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.IncidentsManagementSystem.entities.Issue;

import jakarta.transaction.Transactional;

@Repository
public interface IssueRepository extends JpaRepository<Issue, Integer>{
 
	@Modifying
	@Transactional
	@Query("delete from Issue i where i.id=:id")
	public void deleteById(int id);
	
	public List<Issue> findByUsername(String username);
}
