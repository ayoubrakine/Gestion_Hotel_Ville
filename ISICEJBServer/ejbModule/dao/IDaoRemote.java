package dao;

import java.util.List;

import jakarta.ejb.Remote;

@Remote
public interface IDaoRemote <T> {
	
	
	// destin� � �tre utilis� pour des appels � distance
	
	
	public T create(T o);
	public boolean delete(T o);
	public T update(T o);
	public T findById(int id);
	public List<T> findAll();

	
	public List<T> findHolelByVilleId(int villeId);
}
