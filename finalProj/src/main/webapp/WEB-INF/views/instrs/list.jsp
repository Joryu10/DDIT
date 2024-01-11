<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec"   uri="http://www.springframework.org/security/tags"%>

<!-- jQuery -->
<script src="/resources/js/jquery-3.6.0.js"></script>

<div class="card">
   <div class="card-header">
      <h3 class="card-title">목록</h3>
   </div>

   <div class="card-body">
      <div id="example1_wrapper" class="dataTables_wrapper dt-bootstrap4">
         <div class="row">
            <div class="col-sm-12">
               <table id="example1" class="table table-bordered table-striped dataTable dtr-inline" aria-describedby="example1_info">
                  <thead>
                     <tr>
                        <th onclick="event.cancelBubble=true">순번</th>
                        <th onclick="event.cancelBubble=true">전사관계자번호</th>
                        <th onclick="event.cancelBubble=true">한글성명</th>
                        <th onclick="event.cancelBubble=true">전사관계자구분</th>
                        <th onclick="event.cancelBubble=true">현직무구분</th>
                     </tr>
                  </thead>
                  <tbody>
                  	<!-- List<EntRelorStandVO> data  -->
                     <c:forEach var="entRelorStandVO" items="${data}" varStatus="stat">
                        <tr>
                           <td>${stat.count}</td>
                           <td><a href="/instrs/detail?entRelorNo=${entRelorStandVO.entRelorNo}">${entRelorStandVO.entRelorNo}</a></td>
                           <td>${entRelorStandVO.kornFlnm}</td>
                           <td>${entRelorStandVO.entRelorDiv}</td>
                           <td>${entRelorStandVO.empVO.curJobDiv}</td>
                        </tr>
                     </c:forEach>
                  </tbody>
               </table>
            </div>
         </div>

      </div>
   </div>
   <div class="card-footer">
   		<!-- type : button / submit / reset -->
<!--    		<button type="button" class="btn btn-primary">강사등록</button> -->
   		<a href="/instrs/create" class="btn btn-primary">강사등록</a>
   </div>
</div>

<script>
  $(function () {
    $("#example1").DataTable({
      "responsive": true, "lengthChange": false, "autoWidth": false,
      "buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
    }).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');

  });
</script>