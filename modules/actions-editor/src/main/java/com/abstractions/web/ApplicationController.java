package com.abstractions.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.abstractions.model.Application;
import com.abstractions.service.ApplicationService;
import com.abstractions.service.TeamService;

@Controller
public class ApplicationController {

	@Autowired
	ApplicationService service;

	@Autowired
	TeamService teamService;

	@RequestMapping(value = "/teams/{teamId}/applications", method = RequestMethod.GET)
	public ModelAndView home(@PathVariable("teamId") long teamId) {
		ModelAndView mv = new ModelAndView("applications");

		List<Application> apps = this.service.getApplicationsOf(teamId);
		mv.addObject("applications", apps);
                String teamName = this.teamService.getTeam(teamId).getName();
		mv.addObject("teamName", teamName);

		return mv; 
	}

	@RequestMapping(value = "/teams/{teamId}/applications/add", method = RequestMethod.GET)
	public ModelAndView addContact(@PathVariable("teamId") long teamId) {
                ModelAndView mv = new ModelAndView("addApplication");
                String teamName = this.teamService.getTeam(teamId).getName();
		mv.addObject("teamName", teamName);

		return mv;
	}

	@RequestMapping(value = "/teams/{teamId}/applications/add", method = RequestMethod.POST)
	public String addContact(@PathVariable("teamId") long teamId, @ModelAttribute("form") AddApplicationForm form) {
		this.service.addApplication(teamId, form.getName());
		return "redirect:/teams/" + teamId + "/applications/";
	}
	
	@RequestMapping(value = "/teams/{teamId}/applications/remove", method = RequestMethod.POST)
	public String removeApplication(@PathVariable("teamId") long teamId, @ModelAttribute("form") RemoveForm form) {
		for (long id : form.getIdsToRemove()) {
			this.service.removeApplicationById(id);
		}
		return "redirect:/teams/" + teamId + "/applications/";
	}
}
