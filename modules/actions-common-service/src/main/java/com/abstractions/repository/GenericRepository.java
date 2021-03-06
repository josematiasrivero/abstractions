package com.abstractions.repository;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.jsoup.helper.Validate;
import org.springframework.stereotype.Repository;

import com.abstractions.model.Server;

@Repository
public class GenericRepository {

	private SessionFactory sessionFactory;

	protected GenericRepository() { }

	public GenericRepository(SessionFactory sessionFactory) {
		Validate.notNull(sessionFactory);
		
		this.sessionFactory = sessionFactory;
	}
        

	public void save(Object object) {
		this.sessionFactory.getCurrentSession().save(object);
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> get(Class<?> theClass, String orderBy) {
		return this.sessionFactory
			.getCurrentSession()
			.createCriteria(theClass)
			.addOrder(Order.asc(orderBy))
			.list();
	}
	
	public void delete(Class<?> theClass, long id) {
		String query = "delete from :class where id = :id".replace(":class", theClass.getCanonicalName());
	    Query q = this.sessionFactory.getCurrentSession().createQuery(query);
        q.setLong("id", id);
        q.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public <T> T get(Class<?> theClass, long id) {
		return (T) this.sessionFactory.getCurrentSession().get(theClass, id);
	}

	@SuppressWarnings("unchecked")
	public <T> List<T> get(Class<T> theClass, String assocProperty, long anID) {
		return (List<T>) this.sessionFactory.getCurrentSession()
			.createCriteria(theClass)
			.createAlias(assocProperty, "a")
			.add(Restrictions.eq("a.id", anID))
			.list();
	}

	@SuppressWarnings("unchecked")
	public <T> T findBy(Class<Server> theClass, String property, Object value) {
		return (T) this.sessionFactory.getCurrentSession()
			.createCriteria(theClass)
			.add(Restrictions.eq(property, value))
			.uniqueResult();
	}

	@SuppressWarnings("rawtypes")
	public List<Object[]> getPendingDeploymentIdsFor(long serverId) {
		List queryResults =  this.sessionFactory.getCurrentSession()
			.createSQLQuery("SELECT deployment_to_server.deployment_id as deploy_id, application_snapshot.application_id FROM deployment_to_server INNER JOIN deployment ON deployment_to_server.deployment_id = deployment.deployment_id INNER JOIN application_snapshot ON application_snapshot.application_snapshot_id = deployment.application_snapshot_id  WHERE deployment_to_server.server_id = ? AND deployment_to_server.deployment_state = ?")
			.setLong(0, serverId)
			.setString(1, "PENDING")
			.list();
		
		return queryResults;
	}      
        
        public void update(Object o) {
            this.sessionFactory.getCurrentSession().update(o);
        }
}
