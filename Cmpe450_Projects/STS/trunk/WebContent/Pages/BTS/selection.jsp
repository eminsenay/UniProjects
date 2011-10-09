	<form action="<%=selfPage %>" method="get">
		<table>
			<tr>
				<td>Kurumsal:</td>
				<td>
					<input type="text" name="<%=INST_CODE %>">
				</td>
			</tr>
			<tr>
				<td>Fonksiyonel:</td>
				<td>
					<input type="text" name="<%=FUNC_CODE %>">
				</td>
			</tr>
			<tr>
				<td>Ekonomik:</td>
				<td>
					<input type="text" name="<%=ECO_CODE %>">
				</td>
			</tr>
			<tr>
				<td></td>	
				<td>
					<input type="submit" value="Seç">
				</td>
			</tr>
		</table>
	</form>
<%
		return;
	