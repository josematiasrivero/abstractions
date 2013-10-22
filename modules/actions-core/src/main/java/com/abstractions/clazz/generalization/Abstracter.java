package com.abstractions.clazz.generalization;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.abstractions.clazz.core.ObjectClazz;
import com.abstractions.meta.ElementDefinitionType;
import com.service.core.ContextDefinition;

public class Abstracter {

	public AbstractionClazz abstractFrom(ContextDefinition context, ObjectClazz... definitions) throws UnconnectedDefinitionsException, MultipleEntryPointsException {
		Map<String, ObjectClazz> definitionsMap = new HashMap<String, ObjectClazz>();
		for (ObjectClazz definition : definitions) {
			definitionsMap.put(definition.getId(), definition);
		}

		return this.abstractFrom(context, definitionsMap);
	}

	public AbstractionClazz abstractFrom(ContextDefinition context, List<String> urns) throws UnconnectedDefinitionsException, MultipleEntryPointsException {
		Map<String, ObjectClazz> definitionsMap = new HashMap<String, ObjectClazz>();
		for (String urn : urns) {
			definitionsMap.put(urn, context.resolve(urn));
		}
	
		return this.abstractFrom(context, definitionsMap);
	}

	public AbstractionClazz abstractFrom(ContextDefinition context, Map<String, ObjectClazz> definitionsMap) throws UnconnectedDefinitionsException, MultipleEntryPointsException {
		Set<ObjectClazz> definitions = new HashSet<ObjectClazz>(definitionsMap.values());

		if (this.isConnected(definitions, context)) {
			List<Map.Entry<ObjectClazz, Long>> sortedDefinitions = this.topologicalSortByIncomingExternalConnections(definitions, context);
			if (this.hasOneEntry(sortedDefinitions)) {
				return this.createAbstraction(sortedDefinitions);
			} else {
				throw new MultipleEntryPointsException(definitionsMap.keySet());
			}
		} else {
			throw new UnconnectedDefinitionsException(definitionsMap.keySet());
		}
	}

	/**
	 * Creates the Abstractions from the definition list
	 */
	private AbstractionClazz createAbstraction(List<Map.Entry<ObjectClazz, Long>> definitions) {
		AbstractionClazz abstraction = new AbstractionClazz(definitions.get(definitions.size() - 1).getKey());
		
		for (Map.Entry<ObjectClazz, Long> definition : definitions) {
			abstraction.addDefinition(definition.getKey());
		}
		
		return abstraction;
	}

	/**
	 * Verifies that the subgraph has only one node that receives the incoming connections and this will be
	 * the starting node
	 */
	private boolean hasOneEntry(List<Map.Entry<ObjectClazz, Long>> definitions) {
		Entry<ObjectClazz, Long> entry = definitions.get(definitions.size() - 1);
		if (entry.getValue().longValue() == 0) {
			return true;
		} else {
			//verify that the previous one has 0 connections
			Entry<ObjectClazz, Long> beforeLast = definitions.get(definitions.size() - 2);
			return beforeLast.getValue().longValue() == 0;
		}
	}

	/**
	 * Runs a topological sort excluding incoming connections from external sources to the subgraph
	 */
	private List<Map.Entry<ObjectClazz, Long>> topologicalSortByIncomingExternalConnections(Set<ObjectClazz> definitions, ContextDefinition context) {
		final Map<ObjectClazz, Long> incomingConnections = new HashMap<ObjectClazz, Long>();
		
		for (ObjectClazz definition : definitions) {
			long counter = 0;
			
			for (String connectionUrn : definition.getIncomingConnections()) {
				ObjectClazz connection = context.resolve(connectionUrn);
				if (connection != null) {
					String sourceUrn = connection.getProperty("source");
					ObjectClazz source = context.resolve(sourceUrn);
					if (!definitions.contains(source)) {
						counter++;
					}
				}				
			}
			
			incomingConnections.put(definition, counter);
		}
		
		return entriesSortedByValues(incomingConnections);
	}
	
	private <K,V extends Comparable<V>> List<Map.Entry<K,V>> entriesSortedByValues(Map<K,V> map) {
		List<Map.Entry<K,V>> sortedEntries = new ArrayList<Map.Entry<K,V>>();
		sortedEntries.addAll(map.entrySet());
		
		Collections.sort(sortedEntries,
	        new Comparator<Map.Entry<K,V>>() {
	            @Override public int compare(Map.Entry<K,V> e1, Map.Entry<K,V> e2) {
	                return e1.getValue().compareTo(e2.getValue());
	            }
	        }
	    );

		return sortedEntries;
	}

	/**
	 * Verifies that the subgraph is a connected subgraph
	 */
	private boolean isConnected(Set<ObjectClazz> definitions, ContextDefinition context) {
		for (ObjectClazz definition : definitions) {
			if (definition.getMeta().getType().equals(ElementDefinitionType.CONNECTION)) {
				String sourceUrn = definition.getProperty("source");
				String targetUrn = definition.getProperty("target");
				
				ObjectClazz source = context.resolve(sourceUrn);
				ObjectClazz target = context.resolve(targetUrn);
				
				if (!definitions.contains(source) || !definitions.contains(target)) {
					return false;
				}
			} else {
				for (String connectionUrn : definition.getOutgoingConnections()) {
					ObjectClazz connection = context.resolve(connectionUrn);
					if (connection != null) {
						String targetUrn = connection.getProperty("target");
						ObjectClazz target = context.resolve(targetUrn);
						if (!definitions.contains(target)) {
							return false;
						}
					}
				}
			}
		}
		
		return true;
	}
}