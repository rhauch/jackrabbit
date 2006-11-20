<%@taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@taglib uri="http://jakarta.apache.org/taglib/string" prefix="str" %>
<%@taglib uri="http://jackrabbit.apache.org/jcr-taglib" prefix="jcr" %>
<% 
pageContext.setAttribute("path", request.getParameter("path")); 
pageContext.setAttribute("jcrsession",session.getAttribute("jcr.session"));
%>
<jcr:set var="node" item="${path}"/>
<c:if test="${!node.node}">
	<jcr:set var="node" item="${node.parent}"/>
</c:if>
<div class="dialog">
<h3>Node - Order before</h3>
<hr height="1"/>	
<form action="response.txt" id="dialogForm" 
method="POST" onsubmit="return false;">
<table class="dialog">
<tr>
	<th width="100">Node</th>
	<td><c:out value="${node.path}"/></td>
</tr>
<tr>
	<th>Target node</th>
	<td >
	<select name="target">
<c:forEach var="child" items="${node.parent.nodes}">
<c:if test="${child.path ne node.path}">
		<option><c:out value="${child.name}"/></option>
</c:if>
</c:forEach>
	</select>
	</td>
</tr>
<tr>
	<td colspan="2" align="center">
		<hr height="1"/>	
		<input type="button" value="Submit" onClick="submitDialog();"/>
		<input type="button" value="Cancel" onClick="hideDialog();"/>
	</td>
</tr>
</table>
</form>
</div>
