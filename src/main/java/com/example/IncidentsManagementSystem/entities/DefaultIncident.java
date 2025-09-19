package com.example.IncidentsManagementSystem.entities;

import org.hibernate.annotations.BatchSize;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class DefaultIncident {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	int id;

	String type;
	String subType;
	String solution;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSubType() {
		return subType;
	}
	public void setSubType(String subType) {
		this.subType = subType;
	}
	public String getSolution() {
		return solution;
	}
	public void setSolution(String solution) {
		this.solution = solution;
	}
	public DefaultIncident(int id, String type, String subType, String solution) {
		super();
		this.id = id;
		this.type = type;
		this.subType = subType;
		this.solution = solution;
	}
	
	public DefaultIncident() {}

}
