package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.vo.CotnQuaVO;
import kr.or.ddit.vo.CrerQlfcVO;
import kr.or.ddit.vo.EmpVO;
import kr.or.ddit.vo.EntRelorStandVO;
import kr.or.ddit.vo.InstrsVO;
import kr.or.ddit.vo.InstrsWorkPflVO;

public interface InstrsMapper {

	//전사관계자기본 목록
	public List<EntRelorStandVO> list();

	//전사관계자기본 등록
	public int createPost(EntRelorStandVO entRelorStandVO);

	//직원 등록
	public int insertEmp(EmpVO empVO);

	//강사 등록
	public int insertInstrs(InstrsVO instrsVO);
	
	//강사프로필 등록
	public void insertInstrsWorkPfl(InstrsWorkPflVO instrsWorkPflVO);

	//경력 사항 등록
	public int insertCrerQlfc(CrerQlfcVO crerQlfcVO);
	
	//보유자격 등록
	public int insertCotnQua(CotnQuaVO cotnQuaVO);

	//강사 상세 페이지(강사정보)
	public EntRelorStandVO detail(String entRelorNo);
	
	//강사프로필 + 경력사항
	//<select id="getCrerQlfc" parameterType="String" resultMap="instrsWorkPflMap">
	public List<InstrsWorkPflVO> getCrerQlfc(String entRelorNo);

	//강사프로필 + 보유자격
	public List<InstrsWorkPflVO> getCotnQua(String entRelorNo);

	//전사관계자기본 수정
	public int updatePost(EntRelorStandVO entRelorStandVO);
	
	//직원 수정
	//<update id="updateEmpPost" parameterType="entRelorStandVO">
	public int updateEmpPost(EntRelorStandVO entRelorStandVO);

	//강사 수정
	public int updateInstrsPost(InstrsVO instrsVO);

	//강사프로필 데이터를 삭제 -> 외래키를 보유한 경력사항 및 보유자격 행(row)도 함께 삭제(cascade)
	public int deleteInstrsWorkPfl(String entRelorNo);

	//파일 삭제
	public int deleteAtchFileDetail(String entRelorNo);
}







