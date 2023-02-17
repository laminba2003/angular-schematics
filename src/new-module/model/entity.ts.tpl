export class Entity {
 <%primaryKey%>: <%primaryKeyType%>;
 <% for column in displayedColumns %><%column%>: string;
 <% end %>
}