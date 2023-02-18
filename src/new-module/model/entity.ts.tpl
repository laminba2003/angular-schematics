export class Entity {
 <%primaryKey%>: <%primaryKeyType%>;
 <% for column in displayedColumns %><%column%>: any;
 <% end %>
}