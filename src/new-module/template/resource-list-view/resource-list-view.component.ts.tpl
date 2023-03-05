import { Component, OnInit } from '@angular/core';
import { Resource } from '@app/model/resource';
import { ResourceDetailsComponent } from '../resource-details/resource-details.component';
import { CreateResource, DeleteResource, GetResource, GetResources, SearchResources, UpdateResource } from './../resource.actions';
import { ListViewComponent, State } from '@components/ListViewComponent';
import { ResourceEditComponent } from '../resource-edit/resource-edit.component';


@Component({
  selector: 'app-resource-list-view',
  templateUrl: './resource-list-view.component.html',
  styleUrls: ['./resource-list-view.component.css']
})
export class ResourceListViewComponent extends ListViewComponent<Resource> implements OnInit {

  constructor() {
    super(new State(state => state.resourcestate.page, state => state.resourcestate.resource),
     () => { return this.getResources() }, [<% for column in displayedColumns %> '<%column%>', <%end%> 'actions']);
  }

  ngOnInit(): void {
     this.getParam('<%primaryKey%>').subscribe(<%primaryKey%> => this.getResource(<%primaryKey%>));
  }

  getResources(): void {
    this.getEntities(new GetResources(this.page.number, this.page.size));
  }

  getResource(<%primaryKey%>: <%primaryKeyType%>): void {
    this.getEntity(new GetResource(<%primaryKey%>), ResourceDetailsComponent);
  }

  createResource(): void {
    this.createEntity(ResourceEditComponent, (resource: Resource) => new CreateResource(resource));
  }

  updateResource(<%primaryKey%>: <%primaryKeyType%>): void {
    this.editEntity(new GetResource(<%primaryKey%>), ResourceEditComponent, (resource: Resource) => new UpdateResource(<%primaryKey%>, resource));
  }

  deleteResource(<%primaryKey%>: <%primaryKeyType%>): void {
    this.deleteEntity(new DeleteResource(<%primaryKey%>));
  }

  override handleSearch(query: string): void {
    this.getEntities(new SearchResources(query, this.page.number, this.page.size));
  }

}