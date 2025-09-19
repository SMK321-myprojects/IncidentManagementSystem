package com.example.IncidentsManagementSystem.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.IncidentsManagementSystem.entities.DefaultIncident;
import com.example.IncidentsManagementSystem.repositories.DefaultIncidentRepository;

@Service
public class DefaultIncidentService {
	
	@Autowired
	private DefaultIncidentRepository dir;
	
	public DefaultIncident findByTypeandSubType(String type,String subType) {
		return dir.findByTypeandSubType(type, subType);
	}
	
	public List<DefaultIncident> findAll(){
		return dir.findAll();
	}
	
	public void addDi(DefaultIncident di) {
		dir.save(di);
	}
	
	public List<String> findTypes(){
		return dir.findTypes();
	}

}
