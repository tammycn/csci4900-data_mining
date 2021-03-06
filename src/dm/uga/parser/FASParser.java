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

package dm.uga.parser;

/**
 * Parses file information
 * 
 * @author Vincent Lee
 * @since April 7, 2014
 * @version 1.0
 */

import java.util.Stack;
import dm.dao.GlobalDB;

public class FASParser {
	FileStream fileStream;
	String line;
	GlobalDB global;
	
	public FASParser(String filename) {
		fileStream = new FileStream();
		fileStream.openFile(filename);
		global = new GlobalDB();
	}
	
	public void parse() {
		global.openDBconnection();
		
		Stack<String> stack = new Stack<String>();
		String line = "";
		
		while (fileStream.next()) {
			line = fileStream.nextLine();
			
			if (line.startsWith(".")) {
				String firstname = stack.pop();
				String lastname = stack.pop();
				String extra = "";
				if (!lastname.contains(","))
					extra = stack.pop();
				
				
				if (!extra.equals("")) {
					//firstname
					String temp = lastname.trim() + " " + firstname.trim();
					firstname = temp;
					
					//lastname
					lastname = extra;
				}
				
				//all lastname
				lastname = lastname.replaceAll(",", "");
				lastname = lastname.trim();
				
				//clear the stack
				stack.clear();
				
				//commit to sql
				toSQL(firstname, lastname);
			} else
				stack.push(line);
		}
		
		global.closeDBconnection();
	}
	
	public void toSQL(String firstname, String lastname) {
		try {
			global.insert_student_listings.setString(1, firstname);
			global.insert_student_listings.setString(2, lastname);
			global.insert_student_listings.execute();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		new FASParser("sl_merged").parse();
	}
}
