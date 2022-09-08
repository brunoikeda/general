package teste.domain;

import java.util.Comparator;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Customer implements Comparator<Customer>{
	
	private String name;
	private String lastName;
	private int age;
	private String job;
	
	
	@Override
	public int compare(Customer o1, Customer o2) {
		return o1.getAge() - o2.getAge();
	}

}
