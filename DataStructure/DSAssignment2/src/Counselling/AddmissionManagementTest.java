package Counselling;

import static org.junit.Assert.*;

import java.io.IOException;

import org.junit.Test;

/**
 * This test class test methods of AddmissionManagement Class
 * 
 * @author Jyoti
 */
public class AddmissionManagementTest {
	/**
	 * This test method test allocateCourses method of AddmissionManagement
	 * Class
	 * 
	 * @throws IOException
	 */
	@Test
	public void allocateCoursesPositiveCasesTest() throws IOException {

		Counselling addmissionManagement = new Counselling();
		addmissionManagement.addProgram();
		addmissionManagement.addStudent();
		boolean allocate = addmissionManagement.allocate();
		addmissionManagement.writeBook();
		assertTrue(allocate);
	}
}
