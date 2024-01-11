package kr.or.ddit.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.InstrsMapper;
import kr.or.ddit.service.InstrsService;
import kr.or.ddit.util.FileController;
import kr.or.ddit.vo.CotnQuaVO;
import kr.or.ddit.vo.CrerQlfcVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EntRelorStandVO;
import kr.or.ddit.vo.InstrsVO;
import kr.or.ddit.vo.InstrsWorkPflVO;

@Service
public class InstrsServiceImpl implements InstrsService {

	@Autowired
	InstrsMapper instrsMapper;
	
	//root-context 첨부파일폴더 DI
	@Autowired
	String uploadFolder;
	
	@Autowired
	FileController fileController;
	
	@Override
	public List<EntRelorStandVO> list() {
		return this.instrsMapper.list();
	}

	@Transactional
	@Override
	public int createPost(EntRelorStandVO entRelorStandVO) {
		/*
		EntRelorStandVO(entRelorNo=null, kornFlnm=개똥이, entRelorDiv=ENT01002, mbrNo=12345, 
			empVO=EmpVO(entRelorNo=null, empNo=0, curJobDiv=CUR01001, curWorkCtrNo=12, 
				instrsVO=InstrsVO(entRelorNo=null, memsDiv=사원)))
		 */
		//1) 전사관계자기본 입력
		int result = this.instrsMapper.createPost(entRelorStandVO);
		//after : entRelorNo=202311011, kornFlnm=개똥이, entRelorDiv=ENT01002, mbrNo=12345
		
		//2) 직원 입력
		//EmpVO(entRelorNo=null, empNo=0, curJobDiv=CUR01001, curWorkCtrNo=12,...
		EmpVO empVO = entRelorStandVO.getEmpVO();
		//EmpVO(entRelorNo=202311011, empNo=0, curJobDiv=CUR01001, curWorkCtrNo=12,...
		empVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
		//EmpVO(entRelorNo=202311011, empNo=202311011, curJobDiv=CUR01001, curWorkCtrNo=12,...
		empVO.setEmpNo(Integer.parseInt(entRelorStandVO.getEntRelorNo()));
			result += this.instrsMapper.insertEmp(empVO);
			
		//3) 강사 등록
		//InstrsVO(entRelorNo=null, memsDiv=사원)
		InstrsVO instrsVO = empVO.getInstrsVO();
		//InstrsVO(entRelorNo=202311011, memsDiv=사원)
		instrsVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
			result += this.instrsMapper.insertInstrs(instrsVO);
		
		//Final) entRelorStandVO의 null값들을 채워보자
		empVO.setInstrsVO(instrsVO);
		entRelorStandVO.setEmpVO(empVO);
		
		//5) ATCH_FILE_DETAIL 테이블에 insert
		//파일업로드
		result += this.fileController.uploadFile(entRelorStandVO.getUploadFile(),
				entRelorStandVO.getEntRelorNo());
		
		//6) 경력사항 목록
		//강사프로필 들
		List<InstrsWorkPflVO> instrsWorkPflVOList 
			= entRelorStandVO.getEmpVO().getInstrsVO().getInstrsWorkPflVOList();
		for(InstrsWorkPflVO instrsWorkPflVO : instrsWorkPflVOList) {
			//경력사항 들
			List<CrerQlfcVO> crerQlfcVOList = instrsWorkPflVO.getCrerQlfcVOList();
			//경력사항 들 -> 경력사항
			int seq = 1;
			
			for(CrerQlfcVO crerQlfcVO : crerQlfcVOList) {
				//강사프로필VO
				InstrsWorkPflVO instrsWorkPflVOTemp = new InstrsWorkPflVO();
				instrsWorkPflVOTemp.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				instrsWorkPflVOTemp.setSeq(seq);
				instrsWorkPflVOTemp.setPfl("PFL01001");//경력사항
				//강사프로필(1)
				this.instrsMapper.insertInstrsWorkPfl(instrsWorkPflVOTemp);
				
				//경력사항VO
				crerQlfcVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				crerQlfcVO.setSeq(seq);
				
				//경력사항 insert(1)
				result += this.instrsMapper.insertCrerQlfc(crerQlfcVO);
				
				seq++;
			}
			//7) 보유자격 목록
			List<CotnQuaVO> cotnQuaVOList = instrsWorkPflVO.getCotnQuaVOList();
			for(CotnQuaVO cotnQuaVO : cotnQuaVOList) {
				//강사프로필VO
				InstrsWorkPflVO instrsWorkPflVOTemp = new InstrsWorkPflVO();
				instrsWorkPflVOTemp.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				instrsWorkPflVOTemp.setSeq(seq);
				instrsWorkPflVOTemp.setPfl("PFL01002");//보유자격
				//강사프로필(1)
				this.instrsMapper.insertInstrsWorkPfl(instrsWorkPflVOTemp);
				
				//보유자격VO
				cotnQuaVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				cotnQuaVO.setSeq(seq);
				//보유자격 insert(1)
				result += this.instrsMapper.insertCotnQua(cotnQuaVO);
				
				seq++;
			}
		}
		
		
		
		return result;
	}
	
	//강사 상세 페이지(강사정보)
	@Override
	public EntRelorStandVO detail(String entRelorNo) {
		return this.instrsMapper.detail(entRelorNo);
	}

	//강사프로필 + 경력사항
	@Override
	public List<InstrsWorkPflVO> getCrerQlfc(String entRelorNo){
		return this.instrsMapper.getCrerQlfc(entRelorNo);
	}

	//강사프로필 + 보유자격
	@Override
	public List<InstrsWorkPflVO> getCotnQua(String entRelorNo) {
		return this.instrsMapper.getCotnQua(entRelorNo);
	}

	@Override
	public int updatePost(EntRelorStandVO entRelorStandVO) {
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
		//1) 전사관계자기본 수정
		int result = this.instrsMapper.updatePost(entRelorStandVO);
		//after : entRelorNo=202311011, kornFlnm=개똥이, entRelorDiv=ENT01002, mbrNo=12345
		
		//2) 직원 수정
		result += this.instrsMapper.updateEmpPost(entRelorStandVO);
			
		//3) 강사 수정
		//InstrsVO(entRelorNo=null, memsDiv=사원)
		InstrsVO instrsVO = entRelorStandVO.getEmpVO().getInstrsVO();
		//InstrsVO(entRelorNo=202311011, memsDiv=사원)
		instrsVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
		result += this.instrsMapper.updateInstrsPost(instrsVO);
		
		//Final) entRelorStandVO의 null값들을 채워보자
		entRelorStandVO.getEmpVO().setInstrsVO(instrsVO);
		
		//5) ATCH_FILE_DETAIL 테이블에 insert
		//파일업로드
		MultipartFile[] uploadFile = entRelorStandVO.getUploadFile();
		//정보 수정 시 첨부파일이 변경되었을 때만 실행!
		if(uploadFile[0].getOriginalFilename().length()>0) {
			//파일 삭제
			result += this.instrsMapper.deleteAtchFileDetail(entRelorStandVO.getEntRelorNo());
			result += this.fileController.uploadFile(uploadFile,
					entRelorStandVO.getEntRelorNo());
		}
		
		//6) 경력사항 목록
		//강사프로필 데이터를 삭제 -> 외래키를 보유한 경력사항 및 보유자격 행(row)도 함께 삭제(cascade)
		result += this.instrsMapper.deleteInstrsWorkPfl(entRelorStandVO.getEntRelorNo());
		//강사프로필 들
		List<InstrsWorkPflVO> instrsWorkPflVOList 
			= entRelorStandVO.getEmpVO().getInstrsVO().getInstrsWorkPflVOList();
		for(InstrsWorkPflVO instrsWorkPflVO : instrsWorkPflVOList) {
			//경력사항 들
			List<CrerQlfcVO> crerQlfcVOList = instrsWorkPflVO.getCrerQlfcVOList();
			//경력사항 들 -> 경력사항
			int seq = 1;
			
			for(CrerQlfcVO crerQlfcVO : crerQlfcVOList) {
				//강사프로필VO
				InstrsWorkPflVO instrsWorkPflVOTemp = new InstrsWorkPflVO();
				instrsWorkPflVOTemp.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				instrsWorkPflVOTemp.setSeq(seq);
				instrsWorkPflVOTemp.setPfl("PFL01001");//경력사항
				//강사프로필(1)
				this.instrsMapper.insertInstrsWorkPfl(instrsWorkPflVOTemp);
				
				//경력사항VO
				crerQlfcVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				crerQlfcVO.setSeq(seq);
				
				//경력사항 insert(1)
				result += this.instrsMapper.insertCrerQlfc(crerQlfcVO);
				
				seq++;
			}
			//7) 보유자격 목록
			List<CotnQuaVO> cotnQuaVOList = instrsWorkPflVO.getCotnQuaVOList();
			for(CotnQuaVO cotnQuaVO : cotnQuaVOList) {
				//강사프로필VO
				InstrsWorkPflVO instrsWorkPflVOTemp = new InstrsWorkPflVO();
				instrsWorkPflVOTemp.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				instrsWorkPflVOTemp.setSeq(seq);
				instrsWorkPflVOTemp.setPfl("PFL01002");//보유자격
				//강사프로필(1)
				this.instrsMapper.insertInstrsWorkPfl(instrsWorkPflVOTemp);
				
				//보유자격VO
				cotnQuaVO.setEntRelorNo(entRelorStandVO.getEntRelorNo());
				cotnQuaVO.setSeq(seq);
				//보유자격 insert(1)
				result += this.instrsMapper.insertCotnQua(cotnQuaVO);
				
				seq++;
			}
		}
		
		
		
		return result;
	}
}









