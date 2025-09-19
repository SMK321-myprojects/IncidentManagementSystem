package com.example.IncidentsManagementSystem.controller;

import java.io.IOException;
import java.security.Principal;
import java.sql.Blob;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.IncidentsManagementSystem.entities.DefaultIncident;
import com.example.IncidentsManagementSystem.entities.Issue;
import com.example.IncidentsManagementSystem.entities.User;
import com.example.IncidentsManagementSystem.services.DefaultIncidentService;
import com.example.IncidentsManagementSystem.services.IssueService;
import com.example.IncidentsManagementSystem.services.UserService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AppController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private DefaultIncidentService defis;
	
	@Autowired
	private IssueService issueService;
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@GetMapping("/home")
	public String home(Principal principal,Model model) {
		User user=userService.findByUsername(principal.getName());
		model.addAttribute("user", user);
		return "home";
	}
	
	
	@PostMapping("/register")
	public String register(@ModelAttribute("user") User user) {
		user.setRole("USER");
		userService.addUser(user);
		return "redirect:/login";
	}
	
	
	@GetMapping("/defaultIncidents")
	public String dis(Model model,Principal principal) {
		model.addAttribute("dis",defis.findAll());
		model.addAttribute("types", defis.findTypes());
		User user=userService.findByUsername(principal.getName());
		model.addAttribute("user", user);
		return "defaultIncidents";
	}
	
	@PostMapping("/addDi")
	public String addDi(@ModelAttribute("di") DefaultIncident di,
			@RequestParam("otherType") String otherType) {
		if(di.getType().equals("newType")) di.setType(otherType);
		defis.addDi(di);
		return "redirect:/defaultIncidents";
	}
	
	@GetMapping("/issues")
	public String issues(Principal principal,Model model) {
		User user=userService.findByUsername(principal.getName());
		model.addAttribute("user", user);
		List<Issue> issues=user.getRole().equals("USER")?issueService.findByUsername(user.getUsername())
				:issueService.findAll();
		model.addAttribute("issues", issues);
		List<String> names=new ArrayList<String>();
		for(Issue i:issues) {
			names.add(userService.findByUsername(i.getUsername()).getName());
		}
		model.addAttribute("dis",defis.findAll());
		model.addAttribute("types", defis.findTypes());
		model.addAttribute("names", names);
		return "issues";
	}
	
	@PostMapping("/raiseIssue")
	public String raiseIssue(@ModelAttribute("issue") Issue issue,
			@RequestParam("otherType") String type,@RequestParam("otherSubType") String subType,
			@RequestParam("image") MultipartFile file,HttpServletRequest request,Principal principal)
			throws IOException, SerialException, SQLException{
		byte[] bytes = file.getBytes();
        Blob blob = new javax.sql.rowset.serial.SerialBlob(bytes);
        issue.setAttachment(blob);
        issue.setUsername(principal.getName());
        if(issue.getType().equals("newType")) issue.setType(type);
        if(issue.getSubType()!=null && issue.getSubType().equals("newSubType")) issue.setSubType(subType);
        issueService.raiseIssue(issue);
		return "redirect:/issues";	
	}
	
	@GetMapping("/image/{id}")
	public ResponseEntity<byte[]> displayImage(@PathVariable("id") int id)throws IOException, SQLException{
		Issue image=issueService.findById(id);
		byte[] imageBytes=null;
		imageBytes=image.getAttachment().getBytes(1,(int) image.getAttachment().length());
		return ResponseEntity.ok().contentType(MediaType.IMAGE_JPEG).body(imageBytes);
	}
	
	@GetMapping("/clear/{id}")
	public String clear(@PathVariable("id") int id) {
		issueService.deleteByid(id);
		return "redirect:/issues";
	}
	
	

}
