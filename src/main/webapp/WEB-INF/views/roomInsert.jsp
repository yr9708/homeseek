<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.mvc.homeseek.model.dto.MemberDto" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/roomInsert.css" type="text/css" />

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- include libraries(jQuery, bootstrap) -->
<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
<!-- include summernote css/js-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-bs4.js"></script>
<!-- include summernote-ko-KR -->
<script src="/resources/js/summernote-ko-KR.js"></script>

<script>
$(document).ready(function() {
	  $('#summernote').summernote({
			minHeight: 370,             // 최소 높이
			maxHeight: 370,             // 최대 높이
			focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
			lang: "ko-KR",					// 한글 설정
			placeholder: '내용을 입력해주세요.',	//placeholder 설정
			
			toolbar: [
	             // [groupName, [list of button]]
	             ['fontname', ['fontname']],
	             ['fontsize', ['fontsize']],
	             ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	             ['color', ['forecolor','color']],
	             ['table', ['table']],
	             ['para', ['ul', 'ol', 'paragraph']],
	             ['height', ['height']],
	             ['insert',['picture']],
	             ['view', ['fullscreen', 'help']]
	           ],
	         fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
	         fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],

	         callbacks: {	//여기 부분이 이미지를 첨부하는 부분
					onImageUpload : function(files) {
						uploadSummernoteImageFile(files[0],this);
					},
					onPaste: function (e) {
						var clipboardData = e.originalEvent.clipboardData;
						if (clipboardData && clipboardData.items && clipboardData.items.length) {
							var item = clipboardData.items[0];
							if (item.kind === 'file' && item.type.indexOf('image/') !== -1) {
								e.preventDefault();
							}
						}
					}
				}
		});
	});
     
     

	/**
	* 이미지 파일 업로드
	
	function uploadSummernoteImageFile(file, editor) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/uploadSummernoteImageFile",
			contentType : false,
			processData : false,
			success : function(data) {
         	//항상 업로드된 파일의 url이 있어야 한다.
				$(editor).summernote('insertImage', data.url);
			}
		});
	}
	*/
</script>


<body>
	<!-- header.jsp include -->
	<%@ include file="/WEB-INF/views/form/header.jsp" %>
	
	<%
		MemberDto memberDto = (MemberDto) (session.getAttribute("login"));
	%>
	
	<section>
	<h1> [insertRoom.do] 방올리기 페이지 </h1>	
	<form action="insertres.do" method="POST">
	<input type="hidden" name="room_id" value="${memberDto.getMember_id }">
		<table border="1">
	
			<tr>
				<th>매물이름</th>
				<td><input type="text" name="room_name"></td>
			</tr>
			<tr>
				<th>매물종류</th>
				<td>
					<select name="room_type">
						<option value="1">월세</option>
						<option value="2">전세</option>
						<option value="3">매매</option>
						<option value="4">반전세</option>
						<option value="5">단기임대</option>
					</select>				
				</td>
			</tr>
			<tr>
				<th>보증금</th>
				<td><input type="text" name="room_deposit"></td>
			</tr>
			<tr>
				<th>매물가격</th>
				<td><input type="text" name="room_price"></td>
			</tr>
			<tr>
				<th>매물면적</th>
				<td><input type="text" name="room_extent" placeholder="단위 : 제곱미터"></td>
			</tr>
			<tr>
				<th>매물주소</th>
				<td><input type="text" name="room_addr" placeholder="도로명주소로 입력해주세요"></td>
			</tr>
			<tr>
				<th>건물종류</th>
				<td>
					<select name="room_kind">
						<option value="1">아파트</option>
						<option value="2">빌라</option>
						<option value="3">주택</option>
						<option value="4">오피스텔</option>
						<option value="5">상가사무실</option>
					</select>
				</td>  
			</tr>
			<tr>
				<th>방 구조</th>
				<td>
					<select name="room_structure">
						<option value="1">방 1개</option>
						<option value="2">방 2개</option>
						<option value="3">방 3개이상</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>방 층수</th>
				<td><input type="text" name="room_floor"></td>
			</tr>
			<tr>
				<th>준공 날짜</th>
				<td><input type="date" name="room_cpdate"></td>
			</tr>
			<tr>
				<th>입주 가능일</th>
				<td><input type="date" name="room_avdate"></td>
			</tr>
			<tr>
				<th>방 상세설명</th>
				<td><textarea rows="10" cols="60" id="summernote" name="room_detail"></textarea></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="작성">
					<input type="button" value="취소" onclick="location.href='main.do'">
				</td>
			</tr>
		</table>
	</form>
	</section>
</body>
</html>