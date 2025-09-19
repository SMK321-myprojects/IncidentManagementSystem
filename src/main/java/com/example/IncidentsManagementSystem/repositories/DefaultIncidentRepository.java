package com.example.IncidentsManagementSystem.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.IncidentsManagementSystem.entities.DefaultIncident;

@Repository
public interface DefaultIncidentRepository extends JpaRepository<DefaultIncident, Integer>{

	@Query("select i from DefaultIncident i where i.type=:type and i.subType=:subType")
	public DefaultIncident findByTypeandSubType(String type,String subType);
	
	@Query("select distinct i.type from DefaultIncident i")
	public List<String> findTypes();
}
