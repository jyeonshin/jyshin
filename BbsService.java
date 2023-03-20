package mul.cam.food.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import mul.cam.food.dto.BbsComment;
import mul.cam.food.dto.BbsDto;

public interface BbsService {
	// 게시판 목록
	List<BbsDto> getlist();		
	
	// 게시글 쓰기
	boolean bbswrite(BbsDto dto);
	
	// 썸머노트 이미지 파일
	JsonObject SummerNoteImageFile(MultipartFile file);	
	
	// 게시글 상세보기
	BbsDto detailBbs(int seq);	
	
	// 게시글 수정
	boolean updateBbs(BbsDto dto);			
	
	// 게시글 삭제
	boolean deleteBbs(int seq);			

	// 댓글 쓰기
	boolean commentWrite(BbsComment bbs);	
	
	// 댓글 목록
	List<BbsComment> commentList(int seq);	
	
	// 댓글 수정
	boolean updateComment(BbsComment bbs);
	
	// 댓글 삭제
	boolean deleteComment(BbsComment bbs);
}
