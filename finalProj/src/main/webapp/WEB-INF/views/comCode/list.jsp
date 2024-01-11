<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(function(){
	//공통상세코드 삭제
	$(document).on("click",".spnComDetDelete",function(){
		//data-com-det-code="PFL01001"
		let comDetCode = $(this).data("comDetCode");	//PFL01001
		console.log("comDetCode : " + comDetCode);
		/*
		요청URI : /comcodeinfo/comDetCodeDeletePost
		요청파라미터 : {"comDetCode":"PFL01001"}
		요청방식 : post
		success : text
		
		DELETE FROM COM_DET_CODE_INFO
		WHERE   COM_DET_CODE = 'PFL01001'
		 */
		 
		let data = {
			"comDetCode":comDetCode
		};
		console.log("data : ",data);
		
		//아작났어유..(피)씨다타써
		$.ajax({
			url:"/comcodeinfo/comDetCodeDeletePost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"text",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				//PFL01001
				console.log("result : " + result);
				
				let trCount = $("#detTbody").children("tr").length;
				
				for(let i=0;i<trCount;i++){
					let str1 = $("#detTbody tr:eq("+i+") td:eq(1)").html();
					
					//삭제할 tr을 찾음
					if(comDetCode==str1){
						$("#detTbody tr:eq("+i+")").remove();
					}
				}
			}
		});
		
	});
	
	//공통상세코드 수정 실행
	$(document).on("click","#btnComDetCodeEdit",function(){
		let comDetCode = $("#comDetCode").val();
		let comDetCodeNm = $("#comDetCodeNm").val();
		let descriptions = $("#descriptions").val();
		
		let data = {
			"comDetCode":comDetCode,
			"comDetCodeNm":comDetCodeNm,
			"descriptions":descriptions
		};
		console.log("data : ", data);
		
		/*
		요청URI : /comcodeinfo/comDetCodeUpdatePost
		요청파라미터 : {"comDetCode":"PRO01001","comCode":"PRO01","comDetCodeNm":"수강신청2"
					,"descriptions":"수강신청3"}
		요청방식 : post
		success : comDetCodeInfoVO
		
		UPDATE COM_DET_CODE_INFO
		SET        COM_DET_CODE_NM='프로젝트2', DESCRIPTIONS='프로젝트3'
		WHERE   COM_DET_CODE = 'CRE01001'
		 */
		//코드명, 설명 변경하는 방법
		let trArr = $("#detTbody").children("tr");
		
		for(let i=0;i<trArr.length;i++){
			//tr을 반복하면서 코드값을 str1변수에 저장
			let str1 = $("#detTbody tr:eq("+i+") td:eq(1)").html();//CRE01001
			console.log("i : " + i + ", str1 : " + str1);
			//str1변수와 클릭 시 가져온 코드값이 같으면 코드명, 설명을 변경함
			if(str1==comDetCode){
				$("#detTbody tr:eq("+i+") td:eq(2)").html(comDetCodeNm);
				$("#detTbody tr:eq("+i+") td:eq(3)").children("span").eq(0).html(descriptions);
			}//end if
		}//end for
		//모달창을 닫음
		$("#defaultModal").modal("hide");
	});
	
	//공통상세코드 수정
	$(document).on("click",".spnComDetEdit",function(){
		//data-com-det-code="CRE01001"
		let comDetCode = $(this).data("comDetCode");//CRE01001
		//comDetCode : CRE01001
		console.log("comDetCode : " + comDetCode);
		
		let data = {
			"comDetCode":comDetCode	
		};
		
		console.log("comDetCode : ",comDetCode);
		
		/*
		요청URI : /comcodeinfo/comDetCodeDetail
		요청파라미터 : {"comDetCode":"CRE01001"}
		요청방식 : post
		success : comDetCodeInfoVO
		*/
		//아작났어유..(피)씨다타써
		$.ajax({
			url:"/comcodeinfo/comDetCodeDetail",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
//				{"comDetCode":"PRO01001","comCode":"PRO01","comDetCodeNm":"수강신청"
//				,"descriptions":"수강신청"}
				console.log("result : ", result);
				//모달 보임
				$("#defaultModal").modal("show");
				
				$("#defaultModalLabel").html("공통상세코드 수정");	
				
				let str = "";
				
				str += "<div class='card-body'>";
				str += "<div class='form-group'>";
				str += "<label for='comCode'>공통상세코드</label>";
				str += "<input type='text' class='form-control' value='"+result.comDetCode+"' id='comDetCode' placeholder='공통상세코드' readonly />";
				str += "</div>";
				str += "<div class='form-group'>";
				str += "<label for='comCode'>공통코드</label>";
				str += "<input type='text' class='form-control' value='"+result.comCode+"' id='comCode' placeholder='공통코드' readonly />";
				str += "</div>";
				str += "<div class='form-group'>";
				str += "<label for='comCodeNm'>공통상세코드 명</label>";
				str += "<input type='text' class='form-control' value='"+result.comDetCodeNm+"' id='comDetCodeNm' placeholder='공통상세코드 명' />";
				str += "</div>";
				str += "<div class='form-group'>";
				str += "<label for='descriptions'>설명</label>";
				str += "<input type='text' class='form-control' value='"+result.descriptions+"' id='descriptions' placeholder='설명'>";
				str += "</div>";
				str += "</div>";
				
				
				$("#defaultModalBody").html(str);
				//id가 btnComDetCodeEdit인 요소를 찾아서 제거
				$("#btnComDetCodeEdit").remove();
				
				$("#defaultModalFooter").prepend(
					"<button class='btn btn-primary' type='button' id='btnComDetCodeEdit'>저장</button>"		
				);
			}
		});
	});
	
	/*
	- var로 함수내에서 선언시 선언된 함수 내에서만 유효합니다. 
	- let로 블럭내에서 선언시 선언된 블럭 내에서만 유효합니다. 
	- const로 선언하는 상수는 let과 동일한 변수 범위를 가집니다. 
	함수의 본문 내에서 지역 변수는 같은 이름을 가진 전역 변수보다 우선합니다. 
	전역 변수와 동일한 이름으로 지역 변수 또는 함수 매개변수를 선언하면 전역 변수가 숨겨집니다.
	*/
	//전역 변수
	//el태그의 정보를 J/S변수로 가져옴
	let globalComCode = "${param.comCode}";
	
	//공통상세코드 추가
	$("#btnAddComDetCode").on("click",function(){
		///comcodeinfo/list?comCode=CUR01
		
		console.log("globalComCode : " + globalComCode);//CUR01
		console.log("sessionStorage의 comCode : " + sessionStorage.getItem("comCode"));
		
		//공통코드가 선택안되었다면 
		if(jQuery.trim(globalComCode)==""){
			$("#defaultModalLabel").html("공통코드!");	
			$("#defaultModalBody").html("공통코드를 선택해주세요");
			
			//모달 보이기 : .modal("show")
			//모달닫기
			$("#defaultModal").modal("hide");
		
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'공통코드를 선택해주세요'
			});
			
			//함수 종료
			return;
		}
		
		//공통 상세 코드의 tr의 개수
		let count = $("#detTbody tr").length;//2
		count = (count+1) + 1000;//1003
		count = count + "";//문자로 변환
		
		//CRE01 + 003
		let result = globalComCode + count.substring(1);
		console.log("result : " + result);
		
		$("#defaultModalLabel").html("공통상세코드 추가");	
		
		let str = "";
		
		str += "<div class='card-body'>";
		str += "<div class='form-group'>";
		str += "<label for='comCode'>공통상세코드</label>";
		str += "<input type='text' class='form-control' value='"+result+"' id='comDetCode' placeholder='공통상세코드' />";
		str += "</div>";
		str += "<div class='form-group'>";
		str += "<label for='comCode'>공통코드</label>";
		str += "<input type='text' class='form-control' value='"+globalComCode+"' id='comCode' placeholder='공통코드' />";
		str += "</div>";
		str += "<div class='form-group'>";
		str += "<label for='comCodeNm'>공통상세코드 명</label>";
		str += "<input type='text' class='form-control' id='comDetCodeNm' placeholder='공통상세코드 명' />";
		str += "</div>";
		str += "<div class='form-group'>";
		str += "<label for='descriptions'>설명</label>";
		str += "<input type='text' class='form-control' id='descriptions' placeholder='설명'>";
		str += "</div>";
		str += "</div>";
		
		$("#defaultModalBody").html(str);
		//id가 btnComDetCodeSave인 요소를 찾아서 제거
		$("#btnComDetCodeSave").remove();
		
		$("#defaultModalFooter").prepend(
			"<button class='btn btn-primary' type='button' id='btnComDetCodeSave'>저장</button>"		
		);
	});
	
	//공통코드 추가
	$("#btnAddComCode").on("click",function(){
		$("#defaultModalLabel").html("공통코드 추가");
		
		let str = "";
		
		str += "<div class='card-body'>";
		str += "<div class='form-group'>";
		str += "<label for='comCode'>공통코드</label>";
		str += "<input type='text' class='form-control' id='comCode' placeholder='공통코드' />";
		str += "</div>";
		str += "<div class='form-group'>";
		str += "<label for='comCodeNm'>공통코드 명</label>";
		str += "<input type='text' class='form-control' id='comCodeNm' placeholder='공통코드 명' />";
		str += "</div>";
		str += "<div class='form-group'>";
		str += "<label for='descriptions'>설명</label>";
		str += "<input type='text' class='form-control' id='descriptions' placeholder='설명'>";
		str += "</div>";
		str += "</div>";
		
		$("#defaultModalBody").html(str);
		//id가 btnComCodeSave인 요소를 찾아서 제거
		$("#btnComCodeSave").remove();
		
		$("#defaultModalFooter").prepend(
			"<button class='btn btn-primary' type='button' id='btnComCodeSave'>저장</button>"		
		);
	});
	
	//동적 생성된 버튼 다루기(공통코드 등록)
	$(document).on("click","#btnComCodeSave",function(){
		let comCode = $("#comCode").val();
		let comCodeNm = $("#comCodeNm").val();
		let descriptions = $("#descriptions").val();
		
		//validation
		if(jQuery.trim(comCode)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'공통코드를 작성해주세요'
			});
			//함수 종료
			return;
		}
		if(jQuery.trim(comCodeNm)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'공통코드명을 작성해주세요'
			});
			//함수 종료
			return;
		}
		if(jQuery.trim(descriptions)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'설명을 작성해주세요'
			});
			//함수 종료
			return;
		}
		
		let data = {
			"comCode":comCode,
			"comCodeNm":comCodeNm,
			"descriptions":descriptions
		};
		
		console.log("data : ",data);
		
		/*
		요청URI : /comcodeinfo/comCodeCreatePost
		요청파라미터 : {"comCode":"PRO01","comCodeNm":"진행단계구분","descriptions":"진행단계구분"	}
		요청방식 : post
		success : comCodeInfoVO
		*/
		$.ajax({
			url:"/comcodeinfo/comCodeCreatePost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				//{"comCode":"PRO01","comCodeNm":"진행단계구분","descriptions":"진행단계구분"	}
				console.log("result : ",result);
				//모달 닫기
				$("#defaultModal").modal("hide");
				//tbody 요소의 자식 중 tr의 개수
				let count = $("#comCodeTbody tr").length;
				
				let str = "<tr><td>"+(count+1)+"</td><td><a href='/comcodeinfo/list?comCode="+result.comCode+"'>"+result.comCode+"</a></td>";
					str +="<td class='clsComCode' data-com-code='"+result.comCode+"'>"+result.comCodeNm+"</td>";
					str += "<td>"+result.descriptions+"</td></tr>";
					
				$("#comCodeTbody").append(str);
				
				var Toast = Swal.mixin({
				      toast: true,
				      position: 'top-end',
				      showConfirmButton: false,
				      timer: 3000
				    });
				
				Toast.fire({
					icon:'success',
					title:'공통코드가 등록되었습니다'
				});
			}
		});
	});
	
	//공통상세코드 등록(동적으로 생성된 버튼 사용)
	//$("#btnComDetCodeSave").on("click",function(){});
	$(document).on("click","#btnComDetCodeSave",function(){
		let comDetCode = $("#comDetCode").val();
		let comCode = $("#comCode").val();
		let comDetCodeNm = $("#comDetCodeNm").val();
		let descriptions = $("#descriptions").val();
		
		//validation
		if(jQuery.trim(comDetCode)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'공통상세코드를 작성해주세요'
			});
			//함수 종료
			return;
		}
		if(jQuery.trim(comCode)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'공통코드를 작성해주세요'
			});
			//함수 종료
			return;
		}
		if(jQuery.trim(comDetCodeNm)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'공통상세코드명을 작성해주세요'
			});
			//함수 종료
			return;
		}
		if(jQuery.trim(descriptions)==""){
			var Toast = Swal.mixin({
			      toast: true,
			      position: 'top-end',
			      showConfirmButton: false,
			      timer: 3000
			    });
			
			Toast.fire({
				icon:'error',
				title:'설명을 작성해주세요'
			});
			//함수 종료
			return;
		}
		
		let data = {
			"comDetCode":comDetCode,
			"comCode":comCode,
			"comDetCodeNm":comDetCodeNm,
			"descriptions":descriptions
		};
		
		console.log("data : ",data);
		
		/*
		요청URI : /comcodeinfo/comDetCodeCreatePost
		요청파라미터 : {"comDetCode":"PRO01001","comCode":"PRO01","comDetCodeNm":"수강신청"
					,"descriptions":"수강신청"}
		요청방식 : post
		success : comDetCodeInfoVO
		*/
		$.ajax({
			url:"/comcodeinfo/comDetCodeCreatePost",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				//{"comDetCode":"PRO01001","comCode":"PRO01","comDetCodeNm":"수강신청","descriptions":"수강신청"	}
				console.log("result : ",result);
				//모달 닫기
				$("#defaultModal").modal("hide");
				//tbody 요소의 자식 중 tr의 개수
				let count = $("#detTbody tr").length;
				
				let str = "<tr><td>"+(count+1)+"</td><td>"+result.comDetCode+"</td><td>"+result.comDetCodeNm+"</td><td>"+result.descriptions+"</td></tr>";
					
				$("#detTbody").append(str);
				
				var Toast = Swal.mixin({
				      toast: true,
				      position: 'top-end',
				      showConfirmButton: false,
				      timer: 3000
				    });
				
				Toast.fire({
					icon:'success',
					title:'공통상세코드가 등록되었습니다'
				});
			}
		});
	});
	
	//<td class="clsComCode" data-com-code="CRE01"
	//*<td class="clsComCode" data-com-code="PFL01"
	//...
	$(".clsComCode").on("click",function(){
		//모든 tr의 색상을 없애자 
		$("#comCodeTbody").children().removeAttr("style");
		//선택한 td의 부모인 tr의 색상을 넣어주자
		$(this).parent("tr").css({"background-color":"#F2F2F2"});
		
		//클릭한 그거!
		//com-code => comCode
		let comCode = $(this).data("comCode");
		
		//전역변수에 넣어줌
		globalComCode = comCode;
		//sessionStorage : 자바스크립트의 세션
		sessionStorage.setItem("comCode",comCode);
		
		console.log("comCode : " + comCode);
		//json오브젝트
		let data = {
			"comCode":comCode
		};
		console.log("data : ",data);
		
		//요청URI : /comcodeinfo/ajaxList
		//요청파라미터 : {"comCode":"CRE01"}
		//요청방식 : post
		//아작났어유..(피)씨다타써
		$.ajax({
			url:"/comcodeinfo/ajaxList",
			contentType:"application/json;charset=utf-8",
			data:JSON.stringify(data),
			type:"post",
			dataType:"json",
			beforeSend:function(xhr){
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success:function(result){
				//[{"comDetCode":"CRE01001","comCode":"CRE01","comDetCodeNm":"경력구분","descriptions":"경력구분"},
	 			//{"comDetCode":"PFL01001","comCode":"PFL01","comDetCodeNm":"프로필구분","descriptions":"프로필구분"}
				//]
				console.log("result",result);
				
				$("#detTbody").html("");
				
				let str = "";
				
				//result : List<ComDetCodeInfoVO>
				$.each(result, function(idx,comDetCodeInfoVO){
					console.log("comDetCode : " + comDetCodeInfoVO.comDetCode);
					console.log("comCode : " + comDetCodeInfoVO.comCode);
					console.log("comDetCodeNm : " + comDetCodeInfoVO.comDetCodeNm);
					console.log("descriptions : " + comDetCodeInfoVO.descriptions);
					str += "<tr><td>"+(idx+1)+"</td><td>"+comDetCodeInfoVO.comDetCode+"</td><td>"+comDetCodeInfoVO.comDetCodeNm+"</td><td><span>"+comDetCodeInfoVO.descriptions;
					str += "</span><span class='spnComDetEdit' data-com-det-code='"+comDetCodeInfoVO.comDetCode+"' style='cursor:pointer;'><ion-icon name='clipboard'></ion-icon></span>";
					str += "<span class='spnComDetDelete' data-com-det-code='"+comDetCodeInfoVO.comDetCode+"' style='cursor:pointer;'><ion-icon name='close'></ion-icon></span>";
					str += "</td></tr>";
				});
				
				$("#detTbody").html(str);
			}
		});
	});
});
</script>
<div class="row">
	<div class="col-md-6">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">공통 코드</h3>
			</div>

			<div class="card-body">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th style="width: 5%;">#</th>
							<th style="width: 15%;">코드</th>
							<th style="width: 20%;">코드명</th>
							<th style="width: 60%;">설명</th>
						</tr>
					</thead>
					<tbody id="comCodeTbody">
						<!-- data : List<ComCodeInfoVO> -->
						<c:forEach var="comCodeInfoVO" items="${data}" varStatus="stat">
						<tr 
							<c:if test="${comCode==comCodeInfoVO.comCode}">style="background-color:#F2F2F2;"</c:if>
						>
							<td>${stat.count}</td>
							<td><a href="/comcodeinfo/list?comCode=${comCodeInfoVO.comCode}">${comCodeInfoVO.comCode}</a></td>
							<td class="clsComCode" data-com-code="${comCodeInfoVO.comCode}">${comCodeInfoVO.comCodeNm}</td>
							<td><p>${comCodeInfoVO.descriptions}</p></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="card-footer">
				<button type="button" class="btn btn-primary" id="btnAddComCode"
					data-toggle="modal" data-target="#defaultModal">공통코드 추가</button>
			</div>
<!-- 			<div class="card-footer clearfix"> -->
<!-- 				<ul class="pagination pagination-sm m-0 float-right"> -->
<!-- 					<li class="page-item"><a class="page-link" href="#">«</a></li> -->
<!-- 					<li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!-- 					<li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!-- 					<li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!-- 					<li class="page-item"><a class="page-link" href="#">»</a></li> -->
<!-- 				</ul> -->
<!-- 			</div> -->
		</div>
	</div>

	<div class="col-md-6">
		<div class="card">
			<div class="card-header">
				<h3 class="card-title">공통 상세 코드</h3>
<!-- 				<div class="card-tools"> -->
<!-- 					<ul class="pagination pagination-sm float-right"> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">«</a></li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">1</a></li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">2</a></li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">3</a></li> -->
<!-- 						<li class="page-item"><a class="page-link" href="#">»</a></li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
			</div>

			<div class="card-body p-0">
				<table class="table">
					<thead>
						<tr>
							<th style="width: 5%;">#</th>
							<th style="width: 15%;">코드</th>
							<th style="width: 20%;">코드명</th>
							<th style="width: 60%;">설명</th>
						</tr>
					</thead>
					<tbody id="detTbody">
						<!-- detData : List<ComDetCodeInfoVO> -->
						<c:forEach var="comDetCodeInfoVO" items="${detData}" varStatus="detStat">
							<tr>
								<td>${detStat.count}</td>
								<td>${comDetCodeInfoVO.comDetCode}</td>
								<td>${comDetCodeInfoVO.comDetCodeNm}</td>
								<td><span>${comDetCodeInfoVO.descriptions}</span>
									<span class="spnComDetEdit" data-com-det-code="${comDetCodeInfoVO.comDetCode}" style="cursor:pointer;"><ion-icon name="clipboard"></ion-icon></span>
									<span class="spnComDetDelete" data-com-det-code="${comDetCodeInfoVO.comDetCode}" style="cursor:pointer;"><ion-icon name="close"></ion-icon></span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="card-footer">
				<button type="button" class="btn btn-primary" id="btnAddComDetCode"
					data-toggle="modal" data-target="#defaultModal">공통상세코드 추가</button>
			</div>
		</div>
	</div>
</div>