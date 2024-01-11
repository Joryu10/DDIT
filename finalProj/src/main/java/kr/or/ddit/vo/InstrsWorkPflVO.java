package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

//강사 프로필
@Data
public class InstrsWorkPflVO {
	private String entRelorNo;
	private int seq;
	private String pfl;	//프로필구분 코드
	private String pflNm; //프로필구분 명(공통상세코드)
	
	//강사프로필 : 경력사항  = 1 : N
	private List<CrerQlfcVO> crerQlfcVOList;
	
	//강사프로필 : 보유자격  = 1 : N
	private List<CotnQuaVO> cotnQuaVOList;
}
