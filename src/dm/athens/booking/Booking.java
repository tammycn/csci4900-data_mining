package dm.athens.booking;

import java.util.ArrayList;
import java.util.List;

/**
 * Jail Booking Recap Report
 * 
 * @author Vincent Lee
 * @since April 18, 2014
 * @version 1.0
 */

public class Booking {
	private int mid_number, height, weight;
	private String firstname, lastname, year_of_birth, race, sex;
	private boolean photo;
	
	private Booking_address address;
	private List<Booking_charge> charges;
	
	/**
	 * Constructor
	 * @param mid_number
	 * @param firstname
	 * @param lastname
	 * @param year_of_birth
	 * @param race
	 * @param sex
	 * @param height
	 * @param weight
	 * @param photo
	 */
	public Booking(int mid_number, String firstname, String lastname,
			String year_of_birth, String race, String sex, int height,
			int weight, boolean photo) {
		this.mid_number = mid_number;
		this.firstname = firstname;
		this.lastname = lastname;
		this.year_of_birth = year_of_birth;
		this.race = race;
		this.sex = sex;
		this.height = height;
		this.weight = weight;
		this.photo = photo;
		this.charges = new ArrayList<Booking_charge>();
	}
	
	/**
	 * @param address the address to set
	 */
	public void setAddress(Booking_address address) {
		this.address = address;
	}
	
	/**
	 * @param charge the charges to add
	 */
	public void addCharge(Booking_charge charge) {
		this.charges.add(charge);
	}
	
	/** @return the address */
	public Booking_address getAddress() {return address;}
	
	/** @return the charges */
	public List<Booking_charge> getCharges() {return charges;}
	
	/** @return the mid_number */
	public int getMid_number() {return mid_number;}
	
	/** @return the height */
	public int getHeight() {return height;}
	
	/** @return the weight */
	public int getWeight() {return weight;}
	
	/** @return the firstname */
	public String getFirstname() {return firstname;}
	
	/** @return the lastname */
	public String getLastname() {return lastname;}
	
	/** @return the year_of_birth */
	public String getYear_of_birth() {return year_of_birth;}
	
	/** @return the race */
	public String getRace() {return race;}
	
	/** @return the sex */
	public String getSex() {return sex;}
	
	/** @return the photo */
	public boolean isPhoto() {return photo;}
}