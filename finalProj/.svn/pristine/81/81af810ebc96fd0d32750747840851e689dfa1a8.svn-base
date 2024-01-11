package kr.or.ddit.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.mapper.ComDetCodeInfoMapper;
import kr.or.ddit.service.InstrsService;
import kr.or.ddit.vo.ComDetCodeInfoVO;
import kr.or.ddit.vo.CrerQlfcVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EntRelorStandVO;
import kr.or.ddit.vo.InstrsWorkPflVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/instrs")
@Controller
public class InstrsController {
	
	@Autowired
	InstrsService instrsService;
	
	//공통코드니까 특별하게
	@Autowired
	ComDetCodeInfoMapper comDetCodeInfoMapper;
	
	//공통코드 정보 미리 만들어놓기
	@ModelAttribute
	public void comDetCodeInfo(Model model) {
		List<ComDetCodeInfoVO> comDetCodeInfoVOList 
				= this.comDetCodeInfoMapper.comDetCodeInfo();
		model.addAttribute("comDetCodeInfoVOList", comDetCodeInfoVOList);
	}
	
	//요청URI : /instrs/list
	//요청방식 : get
	//강사 목록
	@GetMapping("/list")
	public String list(Model model) {
		
		List<EntRelorStandVO> data = this.instrsService.list();
		log.info("data : " + data);
		
		model.addAttribute("data", data);
		
		//forwarding
		return "instrs/list";
	}
	
	//요청URI : /instrs/create
	//요청방식 : get
	@GetMapping("/create")
	public String create() {
		//forwarding : jsp
		return "instrs/create";
	}
	
	/*
	요청URI : /instrs/createPost
	요청파라미터 : {name속성=값,..}
	요청방식 : post
	*/
	@PostMapping("/createPost")
	public String createPost(EntRelorStandVO entRelorStandVO) {
		/*
		EntRelorStandVO(entRelorNo=null, kornFlnm=개똥이, entRelorDiv=ENT01002, mbrNo=12345, 
			empVO=EmpVO(entRelorNo=null, empNo=0, curJobDiv=CUR01001, curWorkCtrNo=12, 
				instrsVO=InstrsVO(entRelorNo=null, memsDiv=사원)),uploadFile=파일객체들)
		 */
		log.info("createPost->entRelorStandVO : " + entRelorStandVO);
		
		int result = this.instrsService.createPost(entRelorStandVO);
		log.info("result : " + result);
		
		//강사 목록 URI로 이동
		return "redirect:/instrs/list";
	}
	
	//강사 상세 페이지(강사정보)
	//요청URI : /instrs/detail?entRelorNo=202311016
	//요청파라미터 : entRelorNo=202311016
	//요청방식 : get
	@GetMapping("/detail")
	public String detail(String entRelorNo, Model model) {
		log.info("detail->entRelorNo : " + entRelorNo);
		
		//강사 상세 페이지(강사정보)
		EntRelorStandVO entRelorStandVO 
				= this.instrsService.detail(entRelorNo);
		log.info("detail->entRelorStandVO : " + entRelorStandVO);
		
		//강사프로필 + 경력사항
		List<InstrsWorkPflVO> crerQlfcVOList 
				= this.instrsService.getCrerQlfc(entRelorNo);
		log.info("detail->crerQlfcVOList : " + crerQlfcVOList);
		
		//강사프로필 + 보유자격
		List<InstrsWorkPflVO> cotnQuaVOList 
				= this.instrsService.getCotnQua(entRelorNo);
		log.info("detail->cotnQuaVOList : " + cotnQuaVOList);
		
		//강사정보
		model.addAttribute("entRelorStandVO", entRelorStandVO);
		//강사프로필(경력사항)
		model.addAttribute("crerQlfcVOList", crerQlfcVOList);
		//강사프로필(보유자격)
		model.addAttribute("cotnQuaVOList", cotnQuaVOList);
		
		//forwarding
		return "instrs/detail";
	}
	
	/*
	요청URI : /instrs/updatePost
	요청파라미터 : {name속성=값,..}
	요청방식 : post
	*/
	@PostMapping("/updatePost")
	public String updatePost(EntRelorStandVO entRelorStandVO) {
		/*
		EntRelorStandVO(entRelorNo=202311016, kornFlnm=장원영5, entRelorDiv=ENT01002, mbrNo=11177, 
			empVO=EmpVO(entRelorNo=null, empNo=0, curJobDiv=CUR01001, curWorkCtrNo=11, 
				instrsVO=InstrsVO(entRelorNo=null, memsDiv=사원, 
					instrsWorkPflVOList=[
					InstrsWorkPflVO(entRelorNo=null, seq=0, pfl=null, pflNm=null, 
						crerQlfcVOList=[
						CrerVO(entRelorNo=null, seq=0, crerStDt=Wed Nov 01 00:00:00 KST 2023, crerEdDt=Sat Nov 04 00:00:00 KST 2023, crerCont=경력1, crer=CRE01002, crerNm=null), 
						CrerQlfQlfccVO(entRelorNo=null, seq=0, crerStDt=Mon Nov 06 00:00:00 KST 2023, crerEdDt=Fri Nov 10 00:00:00 KST 2023, crerCont=경력2, crer=CRE01002, crerNm=null)], 
						cotnQuaVOList=[
						CotnQuaVO(entRelorNo=null, seq=0, cotnLic=1112222), 
						CotnQuaVO(entRelorNo=null, seq=0, cotnLic=1113333), 
						CotnQuaVO(entRelorNo=null, seq=0, cotnLic=1115555)])])), 
		uploadFile=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@3c2801c4], atchFileDetailVOList=null)
		 */
		log.info("updatePost->entRelorStandVO : " + entRelorStandVO);
		
		//entRelorNo=null -> entRelorNo=202311016
		EmpVO empVO = entRelorStandVO.getEmpVO();
		empVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
		entRelorStandVO.setEmpVO(empVO);
		
		int result = this.instrsService.updatePost(entRelorStandVO);
		log.info("result : " + result);
		
		//강사 목록 URI로 이동
		return "redirect:/instrs/detail?entRelorNo="+entRelorStandVO.getEntRelorNo();
	}
}









