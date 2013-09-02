package com.core.meta;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.ClassUtils;

import com.core.interpreter.Evaluator;
import com.service.core.NamesMapping;

public class Library {

	private String name;
	private String displayName;

	private List<ElementDefinition> definitions;
	private Map<String, ElementDefinition> definitionsByName;

	public Library(String name) {
		this.name = name;
		this.definitions = new ArrayList<ElementDefinition>();
		this.definitionsByName = new HashMap<String, ElementDefinition>();
	}

	public void addDefinition(ElementDefinition definition) {
		this.definitions.add(definition);
		this.definitionsByName.put(definition.getName(), definition);
	}
	
	public void addBasicDefinitionForClass(String name, Class<?> aClass) {
		ElementDefinition definition = new ProcessorDefinition(name);
		definition.setClassName(aClass.getCanonicalName());
		
		this.addDefinition(definition);
	}

	public void addBasicDefinitionForClass(String name, String script) {
		ElementDefinition definition = new ProcessorDefinition(name);
		definition.setScript(script);
		
		this.addDefinition(definition);
	}

	public List<ElementDefinition> getDefinitions() {
		return Collections.unmodifiableList(this.definitions);
	}
	
	public ElementDefinition getDefinition(String name) {
		return this.definitionsByName.get(name);
	}
	
	public void createMappings(final NamesMapping mapping) {
		for (ElementDefinition element : this.getDefinitions()) {
			element.accept(new ElementDefinitionVisitor() {
				@Override
				public Object visitRouterDefinition(RouterDefinition routerDefinition) {
					try {
						Class<?> theClass = ClassUtils.getClass(routerDefinition.getRouterEvaluatorImplementation());
						Evaluator evaluator = (Evaluator) theClass.newInstance();
						mapping.addEvaluator(routerDefinition.getName(), evaluator);
					} catch (ClassNotFoundException e) {
					} catch (InstantiationException e) {
					} catch (IllegalAccessException e) {
					}
					return null;
				}
				
				@Override
				public Object visitProcessorDefinition(ProcessorDefinition processorDefinition) {
					return null;
				}
				
				@Override
				public Object visitMessageSourceDefinition(MessageSourceDefinition messageSourceDefinition) {
					return null;
				}
				
				@Override
				public Object visitConnectionDefinition(ConnectionDefinition connectionDefinition) {
					return null;
				}

				@Override
				public Object visitFlowDefinition(FlowDefinition flowDefinition) {
					return null;
				}
			});
			
			mapping.addMapping(element.getName(), element);
		}		
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}
}