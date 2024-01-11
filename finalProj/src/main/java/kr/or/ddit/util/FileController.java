package kr.or.ddit.util;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.AtchFileDetailMapper;
import kr.or.ddit.vo.AtchFileDetailVO;
import lombok.extern.slf4j.Slf4j;

//파일관련 메소드들
@Slf4j
@Controller
public class FileController {
	@Autowired
	String uploadFolder;
	
	@Autowired
	AtchFileDetailMapper atchFileDetailMapper;
	
	//연/월/일 폴더 생성
	public String getFolder() {
		//2022-11-16 형식(format) 지정
		//간단한 날짜 형식
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		//날짜 객체 생성(java.util 패키지)
		Date date = new Date();
		//2022-11-16
		String str = sdf.format(date);
		
		return str.replace("-", File.separator);
	}
	
	//이미지인지 판단. 썸네일은 이미지만 가능하므로..
	public boolean checkImageType(File file) {
		//MIME 타입 알아냄. .jpeg / .jpg의 MIME타입 : image/jpeg
		String contentType;
		try {
			contentType = Files.probeContentType(file.toPath());
			log.info("contentType : " + contentType);
			//image/jpeg는 image로 시작함->true
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		//이 파일이 이미지가 아닐 경우
		return false;
	}
	
	//파일 업로드						파일객체들,				기본키 데이터					
	public int uploadFile(MultipartFile[] uploadFile, String atchFileId) {
//			String uploadFolder = "C:\\eGovFrameDev310\\workspace\\springProj\\src\\main\\webapp\\resources\\upload";
		//첨부파일 insert 성공건수
		int result = 0;
		
		//연월일
		File uploadPath = new File(uploadFolder, getFolder());
		if(uploadPath.exists()==false) {
			uploadPath.mkdirs();
		}
		
		for(MultipartFile multipartFile : uploadFile) {
			String uploadFileName = multipartFile.getOriginalFilename();
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			//uploadPath : upload + 연월일
			//uuid + "_" + 파일명
			File saveFile = new File(uploadPath, uploadFileName);
			
			try {
				multipartFile.transferTo(saveFile);
				
				//ATCH_FILE_DETAIL 테이블에 insert
				//ATCH_FILE_ID, FILE_SN, FILE_STRE_COURS, STRE_FILE_NM
				//, ORIGNL_FILE_NM, FILE_EXTSN, FILE_CN, FILE_SIZE
				AtchFileDetailVO atchFileDetailVO = new AtchFileDetailVO();
				atchFileDetailVO.setAtchFileId(atchFileId);	//P.K
				atchFileDetailVO.setFileSn(0);				//P.K
				atchFileDetailVO.setFileStreCours(
						uploadPath + "/" + uploadFileName);
				// 2023\\10\\31\\safdlkdsfj_개똥이2.jpg
				// getFolder() : 2023\\10\\31
				// uploadFileName : safdlkdsfj_개똥이2.jpg	
				// 2023/10/31/safdlkdsfj_개똥이2.jpg				
				atchFileDetailVO.setStreFileNm(
						getFolder().replaceAll("\\\\", "/") + "/" + uploadFileName);
				atchFileDetailVO.setOrignlFileNm(multipartFile.getOriginalFilename());
				atchFileDetailVO.setFileExtsn(
						uploadFileName.substring(uploadFileName.lastIndexOf(".")+1));
				atchFileDetailVO.setFileCn("");
				atchFileDetailVO.setFileSize(multipartFile.getSize());
				
				log.info("atchFileDetailVO : " + atchFileDetailVO);
				
				result += this.atchFileDetailMapper.insertAtchFileDetail(atchFileDetailVO);
			} catch (IllegalStateException | IOException e) {
				log.error(e.getMessage());
			}
		}
		return result;
	}
	
	//파일 다운로드
	//요청URI : /download?fileName=/2023/11/21/asdflksdfj_개똥이.jpg
	//요청파라미터 : /2023/11/21/asdflksdfj_개똥이.jpg
	//요청방식 : get
	@RequestMapping(value="/download",produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	public ResponseEntity<Resource> downloadFile(String fileName){
		log.info("downloadFile->fileName : " + fileName);
		//core.io
		//파일의 경로(.../upload) + 파일명
		Resource resource = new FileSystemResource(this.uploadFolder + fileName);
		log.info("downloadFile->path : " + (this.uploadFolder + fileName));
		
		String resourceName = resource.getFilename();
		log.info("resourceName : " + resourceName);
		
		//sprintframework.http
		//헤더를 통해서 파일을 보냄
		HttpHeaders headers = new HttpHeaders();
		
		try {
			//파일명이 한글일 때 한글처리
			headers.add("Content-Disposition",
					"attachment;filename="+new String(resourceName.getBytes("UTF-8"),"ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			log.error(e.getMessage());
		}
		//resource : 파일 / header : 파일명 등 정보 / HttpStatus.OK : 상태200(성공)
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}
}






