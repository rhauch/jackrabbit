<%@taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@taglib uri="http://jakarta.apache.org/taglib/string" prefix="str" %>
<%@taglib uri="http://jackrabbit.apache.org/jcr-taglib" prefix="jcr" %>
<%@page import="javax.jcr.NamespaceRegistry"%>
<%
pageContext.setAttribute("jcrsession",session.getAttribute("jcr.session"));
%>
<div class="dialog">
<h3>Session - Set Namespace prefix</h3>
<hr height="1"/>	
<form action="<c:url value="/command/session/setnamespaceprefix" />" id="dialogForm" 
method="POST" onsubmit="return false;">
<table class="dialog">
<tr>
	<th>Prefix: Uri</th>
	<td>
		<select name="uri">
			<c:set value="${jcrsession.workspace.namespaceRegistry}" var="namespaceRegistry"/>
			<c:forEach var="prefix" items="${namespaceRegistry.prefixes}">
<%String uri = ((NamespaceRegistry) pageContext.getAttribute("namespaceRegistry")).getURI(pageContext.getAttribute("prefix").toString()) ;%>			
				<option value="<%= uri %>"><c:out value="${prefix}"/>: <%= uri %></option>
			</c:forEach>			
		</select>
	</td>
</tr>
<tr>
	<th>New prefix</th>
	<td>
		<input type="text" name="prefix" />
	</td>
</tr>

<tr>
	<td align="center" colspan="2">
		<hr height="1"/>	
		<input type="button" value="Submit" onClick="submitDialog();"/>
		<input type="button" value="Cancel" onClick="hideDialog();"/>
	</td>
</tr>
</table>
</form>
</div>
