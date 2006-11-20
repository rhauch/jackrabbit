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
<h3>Node - Lock</h3>
<hr height="1"/>	
<form action="<c:url value="/command/node/locking/lock"/>" id="dialogForm" 
method="POST" onsubmit="return false;">
<table class="dialog">
<tr>
	<th>Node</th>
	<td>
	<input type="hidden" name="path" value="<c:out value="${node.path}"/>"/>
	<c:out value="${node.path}"/></td>
</tr>
<tr>
	<th>Deep</th>
	<td><input type="checkbox" name="deep" value="true"/></td>
</tr>
<tr>
	<th>Session scoped</th>
	<td><input type="checkbox" name="sessionScoped" value="true" checked="checked"/></td>
</tr>
<tr>
	<td colspan="2" align="center">
		<hr height="1"/>
		<input type="button" value="Submit" onClick="internalSubmitDialog();"/>
		<input type="button" value="Cancel" onClick="hideDialog();"/>
	</td>
</tr>
</table>
</form>
</div>
<script language="JavaScript" type="text/javascript">
function internalSubmitDialog() {
	// nodes to refresh 
	var node = dojo.widget.manager.getWidgetById(currentItem);
	var nodes = new Array(node);
	submitDialog(nodes);
}
</script>