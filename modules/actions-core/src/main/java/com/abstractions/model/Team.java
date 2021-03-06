package com.abstractions.model;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.jsoup.helper.Validate;

public class Team {

	long id;

	private String name;
	private User owner;
	private List<ServerGroup> serverGroups;
	private List<Application> applications;
	private List<User> users;
	
	protected Team() {}
	
	public Team(String name, User owner) {
		Validate.notNull(owner);
		this.name = name;
		this.serverGroups = new ArrayList<ServerGroup>();
		this.applications = new ArrayList<Application>();
		this.users = new ArrayList<User>();
		this.owner = owner;
		this.addUser(owner);
	}

	public String getName() {
		return name;
	}

	public void addServerGroup(ServerGroup group) {
		Validate.notNull(group);
		
		this.serverGroups.add(group);
	}
	
	public void addApplication(Application application) {
		Validate.notNull(application);
		
		this.applications.add(application);
	}
	
	public void addUser(User user) {
		Validate.notNull(user);
		
		this.users.add(user);
		user.addTeam(this);
	}
	
	public List<ServerGroup> getServerGroups() {
		return Collections.unmodifiableList(serverGroups);
	}

	public List<Application> getApplications() {
		return Collections.unmodifiableList(applications);
	}
	
	public List<User> getUsers() {
		return Collections.unmodifiableList(users);
	}

	public long getId() {
		return id;
	}

	public User getOwner() {
		return owner;
	}
}
