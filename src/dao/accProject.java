package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.Account;


public class accProject {
public ArrayList<Account> AccountController(Connection connection,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		ArrayList<Account>accData = new ArrayList<Account>();
		try{
			PreparedStatement ps = connection.prepareStatement("SELECT `user_id`, `coach_id`, `client_id`, `parent_id`, `email`, `password`, `surname`, `given_name`, `mobile`, `role`, `create_update_datetime`, `salutation`, `address`, `userStatus_id` FROM `user` ");
			ResultSet rs = ps.executeQuery();
			while(rs.next()){
				Account accObject = new Account();
				accObject.setUsername(rs.getString("email"));
				accObject.setPassword(rs.getString("password"));
				accObject.setRole(rs.getString("role"));
				accData.add(accObject);
			}
			return accData;
		}
		catch(Exception e){
			throw e;
		}
	}
}
