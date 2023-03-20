package mul.cam.food.dao;

import java.util.List;

import mul.cam.food.dto.BbsComment;
import mul.cam.food.dto.BbsDto;


public interface BbsDao {
	
	// 게시판 글쓰기
	int bbswrite(BbsDto dto);
	
	// 게시판 글목록
	List<BbsDto> getlist();
	
	// 상세보기
	BbsDto detailBbs(int seq);	
	
	// 게시판 수정
	int updateBbs(BbsDto dto);
	
	// 게시판 삭제
	int deleteBbs(int seq);
	
	// 댓글 쓰기
	int commentWrite(BbsComment bbs);	

	// 댓글 목록
	List<BbsComment> commentList(int seq);
	
	// 댓글 수정
	int updateComment(BbsComment bbs);
	
	// 댓글 삭제
	int deleteComment(BbsComment bbs);
}
