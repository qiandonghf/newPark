package com.wiiy.core.action;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.sun.syndication.io.impl.Base64;

import org.apache.struts2.ServletActionContext;

import com.wiiy.commons.action.BaseAction;

public class TryAction extends BaseAction {
	//DBUrl
	String url = "jdbc:mysql://localhost:3306/sanlue_web?useUnicode=true&amp;characterEncoding=UTF-8&amp;zeroDateTimeBehavior=convertToNull" ;
	//用户名
	String userName = "wanlun" ;
	//密码
	String password = "zju123456" ;
	private String message ;
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Connection getConnections(){
		Connection connection = null ;
		try {
			//加载驱动类
			Class.forName("com.mysql.jdbc.Driver");
			//获取connection连接
			connection = DriverManager.getConnection(url,userName,password);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection ;
	}
	public String execute(){
		//获取请求路径中的email参数
				String base64Email = ServletActionContext.getRequest().getParameter("parameter");
				//将获取到的参数进行转码
				String emailStr =  base64ToString(base64Email);
				String[] str = emailStr.split(",");
				String email = str[0];
				Date date = stringToDate(str[1]);
				//判断email是否是注册用户
				boolean emailFalg = isExist(email);
				//判断注册时间是否过期
				boolean dateFalg = isDatePastDue(date);
				if (emailFalg) {
					System.out.println("邮箱验证正确");
					if (!dateFalg){
						message = "<span id='message-span' style='color:red'>您的试用帐号已过期</span>" ;
						return "error" ;
					}else {
						message = "" ;
					}

				}
				else
					 message = "邮箱不正确" ;
				return "success" ;
	}
	/**
	 * 试用系统入口
	 * @return
	 */
	/**public String isEmailAndDate(){
		//获取请求路径中的email参数
		String base64Email = ServletActionContext.getRequest().getParameter("email");
		//将获取到的参数进行转码
		String emailStr =  base64ToString(base64Email);
		//获取请求路径中的createDates参数
		String base64Date = ServletActionContext.getRequest().getParameter("createDates");
		//将获得的参数进行转码,先把base64的字符型转换为普通String,再将转换后的String转换为date型
		Date date = stringToDate(base64Date);
		//判断email是否是注册用户
		boolean emailFalg = isExist(emailStr);
		//判断注册时间是否过期
		boolean dateFalg = isDatePastDue(date);
		if (emailFalg) {
			System.out.println("邮箱验证正确");
			if (!dateFalg){
				message = "<span id='message-span' style='color:red'>你的试用时间已经过期</span>" ;
				return "error" ;
			}else {
				message = "" ;
			}

		}
		else
			 message = "邮箱不正确" ;
		return "success" ;
	}
	**/
	
	
	/**
	 * 将字符串进行转码,转两次
	 * @param object
	 * @return
	 */
	public String base64ToString(String object){
		return Base64.decode(Base64.decode(object));
	}
	/**
	 * 将传入的字符串转换为date类型
	 * @param objece
	 * @return
	 */
	public Date stringToDate(String object){
		//先将base64字符串转换为普通String
		SimpleDateFormat sd = new  SimpleDateFormat("yyyy-MM-dd");
		Date date = null ;
		try {
			//String转换Date
			 date = sd.parse(object);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date ;
	}
	/**
	 * 验证邮箱是否存在
	 * @param email
	 * @return
	 */
	public boolean isExist(String email){
		//获取connection连接
		Connection connection = getConnections();
		boolean falg = false ;
		try {
			//获取Statement对象
			Statement st = connection.createStatement();
			//执行sql
			 ResultSet rs = st.executeQuery("select * from sanlue_information");
			 while (rs.next()) {
				 //操作结果
				if (rs.getString(3).equals(email)) {
					falg = true ;
				}
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return falg;
		
	}
	/**
	 * 验证用户的注册日期是否过期
	 * @param date
	 * @return
	 */
	public boolean isDatePastDue(Date date){
		boolean falg = false ;
		Date currentDate = new Date();
		long diff = currentDate.getTime()-date.getTime();
		//把时间差转换为天数
		long days = diff/ (1000 * 60 * 60 * 24);
		//判断时间是否大于15天
        if(days>15)
        	falg = false ;
        else
            falg = true ;
        
		return falg ;
	}


}
