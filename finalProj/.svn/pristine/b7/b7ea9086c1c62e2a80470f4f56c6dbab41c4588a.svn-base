package kr.or.ddit.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.service.ComCodeService;
import kr.or.ddit.vo.ComCodeInfoVO;
import kr.or.ddit.vo.ComDetCodeInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/comcodeinfo")
@Controller
public class ComCodeInfoController {
	@Autowired
	ComCodeService comCodeService;
	/*
	 요청URI : /comcodeinfo/list?comCode=CRE01
	 		 /comcodeinfo/list
	 요청파라미터 : comCode=CRE01
	 요청방식 :get
	 
	 http://localhost/comcodeinfo/list?comCode=CRE01
	 */
	@GetMapping("/list")
	public String list(Model model,
			@RequestParam(value="comCode",required=false,defaultValue="CRE01") String comCode
			) {
		log.info("comCode : " + comCode);
		/*
		SELECT COM_CODE, COM_CODE_NM, DESCRIPTIONS
		FROM  COM_CODE_INFO
		ORDER BY COM_CODE
		 */
		List<ComCodeInfoVO> data = this.comCodeService.list();//공통코드
		log.info("data : " + data);
		/*
		SELECT  COM_DET_CODE, COM_CODE, COM_DET_CODE_NM, DESCRIPTIONS
		FROM   COM_DET_CODE_INFO
		WHERE COM_CODE = 'CRE01'
		 */
		List<ComDetCodeInfoVO> detData = this.comCodeService.detList(comCode);	//공통상세코드
		log.info("detData : " + detData);
		
		model.addAttribute("data", data);
		model.addAttribute("detData", detData);
		model.addAttribute("comCode", comCode);
		
		//forwarding : jsp
		return "comCode/list";
	}
	
	//요청URI : /comcodeinfo/ajaxList
	//요청파라미터 : {"comCode":"CRE01"} <- JSON
	//요청방식 : post
	/*
	[{"comDetCode":"CRE01001","comCode":"CRE01","comDetCodeNm":"경력구분","descriptions":"경력구분"},
	 {"comDetCode":"PFL01001","comCode":"PFL01","comDetCodeNm":"프로필구분","descriptions":"프로필구분"}
	]
	 */
	@ResponseBody
	@PostMapping("/ajaxList")
	public List<ComDetCodeInfoVO> ajaxList(@RequestBody ComCodeInfoVO comcodeInfoVO) {
		//ComDetCodeInfoVO{comCode=CRE01,comCodeNm=null,descriptions=null}
		log.info("comcodeInfoVO : " + comcodeInfoVO);
		
		String comCode = comcodeInfoVO.getComCode();//CRE01
		log.info("comCode : " + comCode);
		
		/*
		SELECT  COM_DET_CODE, COM_CODE, COM_DET_CODE_NM, DESCRIPTIONS
		FROM   COM_DET_CODE_INFO
		WHERE COM_CODE = 'CRE01'
		 */
		List<ComDetCodeInfoVO> detData = this.comCodeService.detList(comCode);	//공통상세코드
		/*[
		 	ComDetCodeInfoVO{comDetCode=CRE01001,comCode=CRE01,comDetCodeNm=경력구분,descriptions=경력구분},
		 	ComDetCodeInfoVO{comDetCode=PFL01001,comCode=PFL01,comDetCodeNm=프로필구분,descriptions=프로필구분}
		 ]*/				
		log.info("detData : " + detData);
		
		return detData;
	}
	
	/*
	요청URI : /comcodeinfo/comCodeCreatePost
	요청파라미터 : {"comCode":"PRO01","comCodeNm":"진행단계구분","descriptions":"진행단계구분"	}
	요청방식 : post
	success : comCodeInfoVO
	*/
	@ResponseBody
	@PostMapping("/comCodeCreatePost")
	public ComCodeInfoVO comCodeCreatePost(@RequestBody ComCodeInfoVO comCodeInfoVO) {
		log.info("comCodeInfoVO : " + comCodeInfoVO);
		
		int result = this.comCodeService.comCodeCreatePost(comCodeInfoVO);
		log.info("result : " + result);
		
		if(result>0) {//등록 성공
			return comCodeInfoVO;
		}else {//실패
			return null;
		}
	}
	/*
	요청URI : /comcodeinfo/comDetCodeCreatePost
	요청파라미터 : {"comDetCode":"PRO01001","comCode":"PRO01","comDetCodeNm":"수강신청"
				,"descriptions":"수강신청"}
	요청방식 : post
	success : comDetCodeInfoVO
	 */
	@ResponseBody
	@PostMapping("/comDetCodeCreatePost")
	public ComDetCodeInfoVO comDetCodeCreatePost(@RequestBody ComDetCodeInfoVO comDetCodeInfoVO) {
		log.info("comDetCodeInfoVO : " + comDetCodeInfoVO);
		
		int result = this.comCodeService.comDetCodeCreatePost(comDetCodeInfoVO);
		log.info("result : " + result);
		
		if(result>0) {//등록 성공
			return comDetCodeInfoVO;
		}else {//실패
			return null;
		}
	}
	
	/*
	요청URI : /comcodeinfo/comDetCodeDetail
	요청파라미터 : {"comDetCode":"CRE01001"}
	요청방식 : post
	success : comDetCodeInfoVO
	*/
	@ResponseBody
	@PostMapping("/comDetCodeDetail")
	public ComDetCodeInfoVO comDetCodeDetail(@RequestBody ComDetCodeInfoVO comDetCodeInfoVO) {
//		{"comDetCode":"CRE01001","comCode":"","comDetCodeNm":""
//			,"descriptions":""}
		log.info("comDetCodeInfoVO : " + comDetCodeInfoVO);
		
		comDetCodeInfoVO = this.comCodeService.comDetCodeDetail(comDetCodeInfoVO);
//		{"comDetCode":"PRO01001","comCode":"PRO01","comDetCodeNm":"수강신청"
//			,"descriptions":"수강신청"}
		log.info("comDetCodeInfoVO : " + comDetCodeInfoVO);
		
		return comDetCodeInfoVO;
	}
	
	/*
	요청URI : /comcodeinfo/comDetCodeDeletePost
	요청파라미터 : {"comDetCode":"PFL01001"}
	요청방식 : post
	success : text
	
	DELETE FROM COM_DET_CODE_INFO
	WHERE   COM_DET_CODE = 'PFL01001'
	 */
	@ResponseBody
	@PostMapping("/comDetCodeDeletePost")
	public String comDetCodeDeletePost(@RequestBody Map<String,String> map) {
		//{"comDetCode":"PFL01001"}
		log.info("map : " + map);
		
		int result = this.comCodeService.comDetCodeDeletePost(map);
		log.info("result : " + result);
		
		//PFL01001
		return map.get("comDetCode");
	}
}












