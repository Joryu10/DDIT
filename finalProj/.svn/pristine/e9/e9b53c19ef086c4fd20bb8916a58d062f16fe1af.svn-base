package kr.or.ddit.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.ComCodeInfoVO;
import kr.or.ddit.vo.ComDetCodeInfoVO;

public interface ComCodeService {
	//공통코드 목록
	public List<ComCodeInfoVO> list();

	//공통상세 목록
	public List<ComDetCodeInfoVO> detList(String comCode);

	//공통코드 등록
	public int comCodeCreatePost(ComCodeInfoVO comCodeInfoVO);

	//공통상세코드 등록
	public int comDetCodeCreatePost(ComDetCodeInfoVO comDetCodeInfoVO);

	//공통상세코드 상세
	public ComDetCodeInfoVO comDetCodeDetail(ComDetCodeInfoVO comDetCodeInfoVO);

	//공통상세코드 삭제
	public int comDetCodeDeletePost(Map<String, String> map);

	
}
