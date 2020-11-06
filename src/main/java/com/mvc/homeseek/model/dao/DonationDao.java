package com.mvc.homeseek.model.dao;

import java.util.List;

import com.mvc.homeseek.model.dto.DonationDto;

public interface DonationDao {
	
	String NAMESPACE = "donationInsert.";
	
	public int donationInsert(DonationDto dto);
	
	// 내가 후원한 내역들 조회
	public List<DonationDto> mypageMyDonaList(String dona_id);

}
