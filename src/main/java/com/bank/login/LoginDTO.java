package com.bank.login;


public class LoginDTO {


	public String getT_others_account_number() {
		return t_others_account_number;
	}
	public void setT_others_account_number(String t_others_account_number) {
		this.t_others_account_number = t_others_account_number;
	}
	private int m_no,m_grade,count ;
	private String m_id,m_pw,m_name,m_addr,m_personal_id_number,m_phone,m_gender,m_email,m_joindate,a_account_number,t_others_account_number;
	private long a_balance,t_amount;
	public long getA_balance() {
		return a_balance;
	}
	public long getT_amount() {
		return t_amount;
	}
	public void setT_amount(long t_amount) {
		this.t_amount = t_amount;
	}
	public void setA_balance(long a_balance) {
		this.a_balance = a_balance;
	}
	public String getA_account_number() {
		return a_account_number;
	}
	public void setA_account_number(String a_account_number) {
		this.a_account_number = a_account_number;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}

	
	public int getM_no() {
		return m_no;
	}
	public void setM_no(int m_no) {
		this.m_no = m_no;
	}
	public int getM_grade() {
		return m_grade;
	}
	public void setM_grade(int m_grade) {
		this.m_grade = m_grade;
	}
	public String getM_name() {
		return m_name;
	}
	public void setM_name(String m_name) {
		this.m_name = m_name;
	}
	public String getM_personal_id_number() {
		return m_personal_id_number;
	}
	public void setM_personal_id_number(String m_personal_id_number) {
		this.m_personal_id_number = m_personal_id_number;
	}
	public String getM_gender() {
		return m_gender;
	}
	public void setM_gender(String m_gender) {
		this.m_gender = m_gender;
	}
	public String getM_phone() {
		return m_phone;
	}
	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	public String getM_pw() {
		return m_pw;
	}
	public void setM_pw(String m_pw) {
		this.m_pw = m_pw;
	}
	public String getM_email() {
		return m_email;
	}
	public void setM_email(String m_email) {
		this.m_email = m_email;
	}
	public String getM_addr() {
		return m_addr;
	}
	public void setM_addr(String m_addr) {
		this.m_addr = m_addr;
	}
	public String getM_joindate() {
		return m_joindate;
	}
	public void setM_joindate(String m_joindate) {
		this.m_joindate = m_joindate;
	}

	
}
