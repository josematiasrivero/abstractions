package com.abstractions.web;

import com.abstractions.model.ElementDefinition;
import com.abstractions.service.ElementDefinitionService;
import com.abstractions.service.LibraryService;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 * @author Guido J. Celada
 */
@Controller
@RequestMapping("/libraries/{libraryId}/definitions")
public class ElementDefinitionController {
    
    @Autowired
    ElementDefinitionService service;
    
    @Autowired
    LibraryService libraryService;
    
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView home(@PathVariable("libraryId") long libraryId) {
        ModelAndView mv = new ModelAndView("definitions");
        List<ElementDefinition> definitions = service.getElementDefinitionsOf(libraryId);
        String libraryName = libraryService.get(libraryId).getDisplayName();
        mv.addObject("definitions",definitions);
        mv.addObject("libraryName",libraryName);
        return mv;
    }
    
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public ModelAndView add(@PathVariable("libraryId") long libraryId) {
        ModelAndView mv = new ModelAndView("addDefinition");
        List<String> addLinks = new ArrayList<String>();
        addLinks.add("addConnection");
        addLinks.add("addFlow");
        addLinks.add("addMessageSource");
        addLinks.add("addProcessor");
        addLinks.add("addRouter");
        mv.addObject("addLinks",addLinks);
        String libraryName = libraryService.get(libraryId).getDisplayName();
        mv.addObject("libraryName",libraryName);
        return mv;
    }
    
    @RequestMapping(value = "/remove", method = RequestMethod.POST)
    public String remove(@ModelAttribute("form") RemoveForm form) {
        for (long id : form.getIdsToRemove()) 
            this.service.remove(id);
        return "redirect:/libraries/{libraryId}/definitions/";
    }
    
    public static ElementDefinition createElementDefinition(AddElementDefinitionForm form, ElementDefinition elementDefinition){
        elementDefinition.setName(form.getName());
        elementDefinition.setDisplayName(form.getDisplayName());
        elementDefinition.setIcon("Resources/" + form.getIcon());
        
        
        return elementDefinition;
    }
}
