package com.abstractions.server.core;

import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.jsoup.helper.Validate;

import com.abstractions.instance.core.ConnectionType;
import com.abstractions.meta.CompositeDefinition;
import com.abstractions.service.core.ApplicationTransformation;
import com.abstractions.service.core.NamesMapping;
import com.abstractions.service.core.ServiceException;
import com.abstractions.template.CompositeTemplate;
import com.abstractions.template.ElementTemplate;
import com.modules.cache.MemcachedCache;

public class LazyComputedCacheTransformation implements ApplicationTransformation {

	private static Log log = LogFactory.getLog(LazyComputedCacheTransformation.class);

	private String objectId;
	private String memcachedURL;
	private String keyExpression;
	private String cacheExpressions;
	private int ttl;
	private NamesMapping mapping;
	
	public LazyComputedCacheTransformation(
			String objectId,
			String memcachedURL,
			String keyExpression,
			String cacheExpressions,
			int ttl,
			NamesMapping mapping) {
		
		Validate.notNull(objectId);
		Validate.notNull(memcachedURL);
		Validate.notNull(keyExpression);
		Validate.notNull(cacheExpressions);
		Validate.notNull(mapping);
		
		this.objectId = objectId;
		this.memcachedURL = memcachedURL;
		this.keyExpression = keyExpression;
		this.cacheExpressions = cacheExpressions;
		this.ttl = ttl;
		this.mapping = mapping;
	}
	
	@Override
	public void transform(CompositeTemplate application) {
		List<ElementTemplate> cacheAccess = new ArrayList<ElementTemplate>();

		//OBTAIN THE CONNECTION DEFINITION
		ElementTemplate connectionDefinition = application.getDefinition(objectId);
		
		//SAVE THE PREVIOUS TARGET ID
		String previousTargetId = connectionDefinition.getProperty("target");
		
		//CREATE CACHE, CHOICE AND CHAIN
		ElementTemplate getCacheDefinition = new ElementTemplate(this.mapping.getDefinition("GET_MEMCACHED"));
		cacheAccess.add(getCacheDefinition);
		ElementTemplate choiceDefinition = new ElementTemplate(this.mapping.getDefinition("CHOICE"));
		ElementTemplate chainDefinition = new ElementTemplate(this.mapping.getDefinition("CHAIN"));
		application.addDefinition(getCacheDefinition);
		application.addDefinition(choiceDefinition);
		application.addDefinition(chainDefinition);
		
		//SET THE EXPRESSION TO GET FROM MEMCACHED
		String adaptedKeyExpression = "'__CACHED_" + getCacheDefinition.getId() + "_' + " + keyExpression;
		getCacheDefinition.setProperty("expression", adaptedKeyExpression);
		
		//CACHE -> CHOICE
		application.addConnection(getCacheDefinition.getId(), choiceDefinition.getId(), ConnectionType.NEXT_IN_CHAIN_CONNECTION);

		//CHOICE -> CHAIN
		String choiceConnectionId = application.addConnection(choiceDefinition.getId(), chainDefinition.getId(), ConnectionType.CHOICE_CONNECTION).getId();
		//IF CACHE IS NULL
		ElementTemplate choiceConnectionDefinition = application.getDefinition(choiceConnectionId);
		choiceConnectionDefinition.setProperty("expression", "message.payload == null");

		//POINT TO THE PREVIOUS COMPUTATION
		application.addConnection(chainDefinition.getId(), previousTargetId.substring(4), ConnectionType.CHAIN_CONNECTION);
		
		//ADD PUT OPERATION
		String[] putExpressions = StringUtils.split(cacheExpressions, ';');
		if (putExpressions != null && putExpressions.length >= 1) {
			ElementTemplate nullProcessorDefinition = new ElementTemplate(this.mapping.getDefinition("NULL"));
			
			ElementTemplate putCacheDefinition = new ElementTemplate(this.mapping.getDefinition("PUT_MEMCACHED"));
			putCacheDefinition.setProperty("keyExpression", adaptedKeyExpression);
			putCacheDefinition.setProperty("valueExpression", putExpressions[0]);

			cacheAccess.add(putCacheDefinition);
			
			application.addDefinition(nullProcessorDefinition);
			application.addDefinition(putCacheDefinition);
			application.addConnection(chainDefinition.getId(), nullProcessorDefinition.getId(), ConnectionType.CHAIN_CONNECTION);
			application.addConnection(nullProcessorDefinition.getId(), putCacheDefinition.getId(), ConnectionType.NEXT_IN_CHAIN_CONNECTION);
		}
		
		//FINALLY CHANGE THE CONNECTION TO POINT TO THE GET FROM CACHE
		connectionDefinition.setProperty("target", "urn:" + getCacheDefinition.getId());
		
		//CREATE THE MEMCACHED CACHE
		MemcachedCache cache = new MemcachedCache();
		cache.setServerAddresses(this.memcachedURL);
		cache.setTtl(this.ttl);
		
		//INITIALIZE ALL OBJECTS THAT HAS ACCESS TO THE CACHE
		CompositeDefinition appDefinition = ((CompositeDefinition) application.getMeta());
		appDefinition.initializeTemplates(application, null, this.mapping, cacheAccess);
		
		for (ElementTemplate template : cacheAccess) {
			try {
				BeanUtils.setProperty(template.getInstance(), "cache", cache);
			} catch (IllegalAccessException e) {
				log.warn("Error setting the cache", e);
			} catch (InvocationTargetException e) {
				log.warn("Error setting the cache", e);
			}
		}
				
		try {
			application.sync(null, this.mapping);
		} catch (ServiceException e) {
			log.warn("Error syncing context", e);
		}
	}
}
