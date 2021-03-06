/*
 * Copyright (c) 2014, vincentclee <ssltunnelnet@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   - Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *
 *   - Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

package dm.athens.booking;

/**
 * CVS Tuple strut
 * 
 * @author Vincent Lee
 * @since April 18, 2014
 * @version 1.0
 */

import java.util.Date;

public class BookingCSV {
	private Date booking_date, release_date;
	private String firstname, lastname, year_of_birth, race, sex, arresting_agency, charge, crime_type, court_jurisdiction, 
					bonding_company, warrant_number, police_case_number;
	private double bonding_amount;
	private int mid_number;
	
	/**
	 * CSV Constructor
	 * @param mid_number
	 * @param booking_date
	 * @param firstname
	 * @param lastname
	 * @param year_of_birth
	 * @param race
	 * @param sex
	 * @param arresting_agency
	 * @param release_date
	 * @param charge
	 * @param crime_type
	 * @param court_jurisdiction
	 * @param bonding_company
	 * @param bonding_amount
	 * @param warrant_number
	 * @param police_case_number
	 */
	public BookingCSV(int mid_number, Date booking_date, String firstname,
			String lastname, String year_of_birth, String race, String sex,
			String arresting_agency, Date release_date, String charge,
			String crime_type, String court_jurisdiction,
			String bonding_company, double bonding_amount,
			String warrant_number, String police_case_number) {
		this.mid_number = mid_number;
		this.booking_date = booking_date;
		this.firstname = firstname;
		this.lastname = lastname;
		this.year_of_birth = year_of_birth;
		this.race = race;
		this.sex = sex;
		this.arresting_agency = arresting_agency;
		this.release_date = release_date;
		this.charge = charge;
		this.crime_type = crime_type;
		this.court_jurisdiction = court_jurisdiction;
		this.bonding_company = bonding_company;
		this.bonding_amount = bonding_amount;
		this.warrant_number = warrant_number;
		this.police_case_number = police_case_number;
	}

	/** @return the booking_date */
	public Date getBooking_date() {return booking_date;}

	/** @return the release_date */
	public Date getRelease_date() {return release_date;}

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

	/** @return the arresting_agency */
	public String getArresting_agency() {return arresting_agency;}

	/** @return the charge */
	public String getCharge() {return charge;}

	/** @return the crime_type */
	public String getCrime_type() {return crime_type;}

	/** @return the court_jurisdiction */
	public String getCourt_jurisdiction() {return court_jurisdiction;}

	/** @return the bonding_company */
	public String getBonding_company() {return bonding_company;}

	/** @return the warrant_number */
	public String getWarrant_number() {return warrant_number;}

	/** @return the police_case_number */
	public String getPolice_case_number() {return police_case_number;}

	/** @return the bonding_amount */
	public double getBonding_amount() {return bonding_amount;}

	/** @return the mid_number */
	public int getMid_number() {return mid_number;}
}