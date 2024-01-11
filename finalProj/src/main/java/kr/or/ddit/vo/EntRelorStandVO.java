package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

//전사 관계자 기본
@Data
public class EntRelorStandVO {
	//전사관계자번호(P.K)
	private String entRelorNo; //전사관계자번호(202311007)
	private String kornFlnm;	//한글성명
	private String entRelorDiv;	//전사관계자구분
	private int mbrNo;			//회원번호
	
	//전사 관계자 기본 : 직원 = 1 : 1
	private EmpVO empVO;
	//전사 관계자 기본 : 개인고객 = 1 : 1
//	private PriVO priVO;
	
	//<input type="file" class="custom-file-input" 
	//name="uploadFile" id="uploadFile" />
	private MultipartFile[] uploadFile;
	
	//전사 관계자 기본 : 첨부상세파일 = 1 : N
	private List<AtchFileDetailVO> atchFileDetailVOList;
	
	
}
