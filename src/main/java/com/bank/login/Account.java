package com.bank.login;



@Entity
public class Account {
	
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private String m_id; // 아이디 필드

    private String a_account_number; // 계좌번호 필드
    private long a_balance; // 잔액 필드
    
	public long getBalance() {
		// TODO Auto-generated method stub
		return 0;
	}
	public void setBalance(long l) {
		// TODO Auto-generated method stub
		
	}

    // 생성자, getter, setter 등의 메서드
}