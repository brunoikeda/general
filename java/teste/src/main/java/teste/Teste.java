package teste;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.Map.Entry;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;

import teste.domain.CustomException;
import teste.domain.Customer;

public class Teste {

	public static void main(String[] args) throws CustomException {
//		testStream();
		
//		testMap();
		
//		testNullOptional();
		
//		testOptional();
		
//		testStreamObject();
		
//		try {
//			testException();
//		} catch (CustomException e) {
//			System.out.println("Catch");
//			System.out.println("Message: " + e.getMessage());
//			throw e;
//		}finally {
//			System.out.println("Finally");
//		}

	}
	
	static void testStream() {
		printHeader("testeStream");
		
		List<String> listStream = Arrays.asList("teste5", "teste1", "teste2", "teste3", "teste4", "abab");
		System.out.println("### All items");
		listStream.forEach(item -> System.out.println(item));
		
		System.out.println();
		
		System.out.println("### Map with filter startsWith \"teste\"");
		Map<String, String> mapFilterStartsWith = listStream.stream().filter(teste -> teste.startsWith("teste")).collect(Collectors.toMap(key -> "key"+key, value -> "value" + value));
		mapFilterStartsWith.forEach((key, value) -> System.out.println("Key: " + key + " - Value: " + value));
		
		System.out.println();
		
		System.out.println("### Set from Map");
		Set<String> set = mapFilterStartsWith.keySet();
		set.forEach(item -> System.out.println(item));
				
		System.out.println();
		
		System.out.println("### List");
		List<String> listFilterStartsWith = listStream.stream().filter(teste -> teste.startsWith("teste")).collect(Collectors.toList());
		listFilterStartsWith.forEach(item -> System.out.println(item));
		
		System.out.println();
		
		System.out.println("### Comparator asc");
		listStream.sort((String s1, String s2) -> s1.compareTo(s2));
		listStream.forEach(item -> System.out.println(item));
		
		System.out.println("### Comparator desc");
		listStream.sort((String s1, String s2) -> s2.compareTo(s1));
		listStream.forEach(item -> System.out.println(item));
						
	}
	
	static void testStreamObject() {
		printHeader("testStreamObject");
		
		List<Customer> listStream = Arrays.asList(new Customer("Ateste", "AlastName", 10, "Ajob"), new Customer("Bteste", "BlastName", 11, "Bjob"), new Customer("Cteste", "ClastName", 9, "Cjob"), new Customer("Dteste", "DlastName", 15, null));
		System.out.println("### All items");
		listStream.forEach(item -> System.out.println(item));
		
		System.out.println();
		
		System.out.println("### Comparator asc");
		listStream.sort((Customer s1, Customer s2) -> s1.compare(s1, s2));
		listStream.forEach(item -> System.out.println(item));
		
		System.out.println();
		
		System.out.println("### Check field null");
		listStream.stream().filter(c -> Optional.of(c).map(Customer::getJob).isPresent()).forEach(c1 -> System.out.println(c1));
						
	}
	
	static void testMap() {
		printHeader("testMap");
		
		List<String> listStream = Arrays.asList("teste1", " teste2", "teste3", "teste4");
		
		System.out.println("###### Map #######");
		Map<String, String> map = listStream.stream().collect(Collectors.toMap(key -> "key"+key, value -> "value" + value));
		
		map.put(null, "null value");
		map.put("key null", null);
		
		map.forEach((key, value) -> System.out.println("Key: " + key + " - Value: " + value));
		
	}
	
	static void testNullOptional() {
		printHeader("testNullOptional");
		
		Customer customer = new Customer("Name", "LastName", 10, null);
		
		System.out.println("### Print null value");
		Optional.ofNullable(customer)
			.map(Customer::getJob)
			.map(String::toString)
			.ifPresent(item -> System.out.println(item));
		
		System.out.println("### Print not null value");
		Optional.ofNullable(customer)
		.map(Customer::getName)
		.map(String::toString)
		.ifPresent(item -> System.out.println(item));
		
	}
	
	static void testOptional() {
		printHeader("testOptional");
		
		Customer customer = new Customer("Name", "LastName", 10, "job");
		Customer customer1 = null;
		Customer customer2 = new Customer("Name", "LastName", 10, null);
		
		System.out.println("### ifPresentOrElse");
		Optional.ofNullable(customer)
			.map(Customer::getJob)
			.map(String::toString)
			.ifPresentOrElse(c1 -> System.out.println(c1), () -> System.out.println("empty object"));
		
		System.out.println("### isPresentOrElse with customer null");
		Optional.ofNullable(customer1)
			.ifPresentOrElse(c1 -> System.out.println(c1), () -> System.out.println("empty object"));
		
		System.out.println("### isPresentOrElse with job null");
		Optional.ofNullable(customer2)
			.map(Customer::getJob)
			.map(String::toString)
			.ifPresentOrElse(c1 -> System.out.println(c1), () -> System.out.println("empty object"));
		
		System.out.println("### Optional filter test");
		Optional.ofNullable(customer)
			.filter(c -> ObjectUtils.isNotEmpty(c.getJob()))
			.ifPresentOrElse(c1 -> System.out.println(c1), () -> System.out.println("empty object"));
		
		System.out.println("### Optional filter test 2 - defaultexception ");
		try {
			Optional.ofNullable(customer1)
			.filter(c -> ObjectUtils.isNotEmpty(c))
			.orElseThrow();
		} catch (NoSuchElementException e) {
			System.out.println("catch NoSuchElementException");
		}
		
		System.out.println("### Optional filter test 3 - custom exception");
		try {
			Optional.ofNullable(customer1)
			.filter(c -> ObjectUtils.isNotEmpty(c))
			.orElseThrow(CustomException::new);
		} catch (CustomException e) {
			System.out.println("catch CustomException");
			if (e instanceof Exception) {
				System.out.println(e.getClass() + " is instance of Exception");
			}
		}
	}
	
	static void testException() throws CustomException {
		printHeader("testException");
		
		throw new CustomException("Teste exception");
		
	}
	
	
	static void printHeader(String methodName) {
		System.out.println(StringUtils.leftPad("", 60, "#"));
		System.out.println(StringUtils.center(StringUtils.center(methodName, methodName.length() + 2, " "), 60, "#"));
		System.out.println(StringUtils.leftPad("", 60, "#"));
		System.out.println();
	}

}
