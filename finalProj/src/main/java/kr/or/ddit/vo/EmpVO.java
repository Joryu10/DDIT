package kr.or.ddit.vo;

import lombok.Data;

//직원
@Data
public class EmpVO {
	//전사관계자번호(P.K, F.K)=>조인조건
	private String entRelorNo;
	private int empNo; //직원번호(=전사관계자번호)
	private String curJobDiv;	//현직무구분
	private int curWorkCtrNo;	//현근무센터번호
	
	//직원 : 강사 = 1 : 1
	private InstrsVO instrsVO;
	//직원 : 관리직원 = 1 : 1
//	private ManagersVO managersVO;
}
