package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.vo.EntRelorStandVO;
import kr.or.ddit.vo.InstrsWorkPflVO;

public interface InstrsService {

	public List<EntRelorStandVO> list();

	//전사관계자기본 등록
	public int createPost(EntRelorStandVO entRelorStandVO);

	//강사 상세 페이지(강사정보)
	public EntRelorStandVO detail(String entRelorNo);

	//강사프로필 + 경력사항
	public List<InstrsWorkPflVO> getCrerQlfc(String entRelorNo);

	//강사프로필 + 보유자격
	public List<InstrsWorkPflVO> getCotnQua(String entRelorNo);

	//강사 수정
	public int updatePost(EntRelorStandVO entRelorStandVO);
	
}
