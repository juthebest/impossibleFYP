package model;


import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.accProject;
import dao.catProject;
import dto.*;
public class AccountModel {


		public ArrayList<Account>  GetCategory(Connection connection, HttpServletRequest request,
				HttpServletResponse response) throws Exception {
			ArrayList<Account> account=null;
			try{
				accProject projectAcc = new accProject();
				account =projectAcc.AccountController(connection, request, response);
				
			}catch (Exception e){
				throw e;
			}
			return account;
		}

	
	}


