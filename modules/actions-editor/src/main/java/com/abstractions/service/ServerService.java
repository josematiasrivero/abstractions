package com.abstractions.service;

import java.util.ArrayList;
import java.util.List;

import org.jsoup.helper.Validate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.abstractions.model.Server;
import com.abstractions.model.ServerGroup;
import com.abstractions.repository.GenericRepository;

@Service
public class ServerService {

	private GenericRepository repository;
	private ServerGroupService serverGroupService;

	public ServerService(GenericRepository repository, ServerGroupService serverGroupService) {
		Validate.notNull(repository);
		Validate.notNull(serverGroupService);
		
		this.repository = repository;
		this.serverGroupService = serverGroupService;
	}

	protected ServerService() {
	}

	@Transactional
	public void addServer(long serverGroupId, String name, String ipDNS) {
		ServerGroup serverGroup = this.serverGroupService.getServerGroup(serverGroupId);
		Server server = new Server(name, ipDNS);
		
		serverGroup.addServer(server);
		this.repository.save(server);
		this.repository.save(serverGroup);
	}

	@Transactional
	public List<Server> getServers(long teamId, long serverGroupId) {
		ServerGroup serverGroup = this.serverGroupService.getServerGroup(serverGroupId);

		List<Server> servers = new ArrayList<Server>();
		servers.addAll(serverGroup.getServers());
		return servers;
	}
	
	@Transactional
	public List<Server> getServers() {
		return this.repository.get(Server.class, "name");
	}

	public Server getServer(long serverId) {
		return this.repository.get(Server.class, serverId);
	}
}