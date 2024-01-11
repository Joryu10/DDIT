package kr.or.ddit.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

//경력 사항
@Data
public class CrerQlfcVO {
	private String entRelorNo;
	private int seq;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date crerStDt;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date crerEdDt;
	private String crerCont;
	private String crer;	//경력구분 코드
	private String crerNm; //경력구분 명(공통상세코드 함수)
}
