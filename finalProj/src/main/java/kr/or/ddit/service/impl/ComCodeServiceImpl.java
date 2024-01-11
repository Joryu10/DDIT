package kr.or.ddit.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.ComCodeMapper;
import kr.or.ddit.service.ComCodeService;
import kr.or.ddit.vo.ComCodeInfoVO;
import kr.or.ddit.vo.ComDetCodeInfoVO;

@Service
public class ComCodeServiceImpl implements ComCodeService {

	@Autowired
	ComCodeMapper comCodeMapper;
	
	@Override
	public List<ComCodeInfoVO> list() {
		return this.comCodeMapper.list();
	}

	@Override
	public List<ComDetCodeInfoVO> detList(String comCode) {
		return this.comCodeMapper.detList(comCode);
	}

	@Override
	public int comCodeCreatePost(ComCodeInfoVO comCodeInfoVO) {
		return this.comCodeMapper.comCodeCreatePost(comCodeInfoVO);
	}

	@Override
	public int comDetCodeCreatePost(ComDetCodeInfoVO comDetCodeInfoVO) {
		return this.comCodeMapper.comDetCodeCreatePost(comDetCodeInfoVO);
	}

	@Override
	public ComDetCodeInfoVO comDetCodeDetail(ComDetCodeInfoVO comDetCodeInfoVO) {
		return this.comCodeMapper.comDetCodeDetail(comDetCodeInfoVO);
	}

	@Override
	public int comDetCodeDeletePost(Map<String, String> map) {
		return this.comCodeMapper.comDetCodeDeletePost(map);
	}

}
