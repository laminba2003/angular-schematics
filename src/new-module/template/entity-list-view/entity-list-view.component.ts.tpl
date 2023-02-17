import { Component, OnInit } from '@angular/core';
import { Entity } from './../../../model/entity';
import { EntityDetailsComponent } from '../entity-details/entity-details.component';
import { DeleteEntity, GetEntity, GetEntitys, SearchEntitys } from './../entity.actions';
import { ListViewComponent, State } from '../../../components/ListViewComponent';

@Component({
  selector: 'app-entity-list-view',
  templateUrl: './entity-list-view.component.html',
  styleUrls: ['./entity-list-view.component.css']
})
export class EntityListViewComponent extends ListViewComponent<Entity> implements OnInit {

  constructor() {
    super(new State(state => state.entitystate.page, state => state.entitystate.entity),
     () => { return this.getEntitys() }, [<% for column in displayedColumns %> '<%column%>', <%end%> 'actions']);
  }

  override ngOnInit(): void {
    super.ngOnInit();
    <% if primaryKeyType == "number" %>const <%primaryKey%> = Number(this.getParam('<%primaryKey%>'));<% else %>const <%primaryKey%> = this.getParam('<%primaryKey%>');<% end %>
    if (<%primaryKey%>) {
      this.getEntity(<%primaryKey%>);
    }
  }

  getEntitys(): void {
    this.getResources(new GetEntitys(this.page.number, this.page.size));
  }

  getEntity(<%primaryKey%>: <%primaryKeyType%>): void {
    this.getResource(new GetEntity(<%primaryKey%>), EntityDetailsComponent);
  }

  editEntity(<%primaryKey%>: <%primaryKeyType%>, event: Event): void {
    this.editResource(new GetEntity(<%primaryKey%>), EntityDetailsComponent, event);
  }

  deleteEntity(<%primaryKey%>: <%primaryKeyType%>, event: Event): void {
    this.deleteResource(new DeleteEntity(<%primaryKey%>), event);
  }

  override handleSearch(query: string): void {
    this.getResources(new SearchEntitys(query, this.page.number, this.page.size));
  }

}