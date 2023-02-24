export class Resource {
 <%primaryKey%>: <%primaryKeyType%>;
 <% for column in displayedColumns %><%column%>: any;
 <% end %>
}