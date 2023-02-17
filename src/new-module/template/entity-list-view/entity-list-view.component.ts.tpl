import { Component, OnInit } from '@angular/core';
import { Entity } from './../../../model/entity';
import { EntityDetailsComponent } from '../entity-details/entity-details.component';
import { DeleteEntity, GetEntity, GetEntitys, SearchEntitys } from './../entity.actions';
import { ListViewComponent } from '../../../components/ListViewComponent';

@Component({
  selector: 'app-entity-list-view',
  templateUrl: './entity-list-view.component.html',
  styleUrls: ['./entity-list-view.component.css']
})
export class EntityListViewComponent extends ListViewComponent<Entity> implements OnInit {

  constructor() {
    super({ page: (state) => state.entitystate.page, entity: (state) => state.entitystate.entity },
      () => { return this.getEntitys() }, [<% for column in displayedColumns %> '<%column%>', <%end%> 'actions']);
  }

  override ngOnInit(): void {
    super.ngOnInit();
    const <%primaryKey%> = Number(this.getParam('<%primaryKey%>'));
    if (<%primaryKey%>) {
      this.getEntity(<%primaryKey%>);
    }
  }

  getEntitys(): void {
    this.getEntities(new GetEntitys(this.page.number, this.page.size));
  }

  getEntity(<%primaryKey%>: <%primaryKeyType%>): void {
    this.getEntity(new GetEntity(<%primaryKey%>), EntityDetailsComponent);
  }

  editEntity(<%primaryKey%>: <%primaryKeyType%>, event: Event): void {
    this.editEntity(new GetEntity(<%primaryKey%>), EntityDetailsComponent, event);
  }

  deleteEntity(<%primaryKey%>: <%primaryKeyType%>, event: Event): void {
    this.deleteEntity(new DeleteEntity(<%primaryKey%>), event);
  }

  override handleSearch(query: string): void {
    this.getEntities(new SearchEntitys(query, this.page.number, this.page.size));
  }

}