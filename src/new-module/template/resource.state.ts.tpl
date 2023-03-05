import { Injectable } from "@angular/core";
import { Action, State, StateContext } from "@ngxs/store";
import { tap } from "rxjs";
import { Page } from "@app/model/page";
import { Resource } from "@app/model/resource";
import { ResourceService } from './resource-service';
import { DeleteResource, GetResource, GetResources, SearchResources } from './resource.actions';

export class ResourceStateModel {
    page: Page<Resource>;
    resource: Resource
}

@State<ResourceStateModel>({
    name: 'resourcestate',
    defaults: {
        page: new Page<Resource>(),
        resource: new Resource()
    }
})
@Injectable()
export class ResourceState {
    constructor(private resourceService: ResourceService) { }

    @Action(GetResources)
    getResources(ctx: StateContext<ResourceStateModel>, { pageNumber, pageSize }: GetResources) {
        return this.resourceService.getResources(pageNumber, pageSize).pipe(tap(page => {
            ctx.patchState({
                page: page
            });
        }))
    }

    @Action(GetResource)
    getResource(ctx: StateContext<ResourceStateModel>, { <%primaryKey%> }: GetResource) {
        return this.resourceService.getResource(<%primaryKey%>).pipe(tap(resource => {
            ctx.patchState({
                resource: resource
            });
        }))
    }

    @Action(DeleteResource)
    deleteResource(ctx: StateContext<ResourceStateModel>, { <%primaryKey%> }: DeleteResource) {
        return this.resourceService.deleteResource(<%primaryKey%>).pipe(tap(() => {
            const state = ctx.getState();
            const page = state.page;
            page.content = page.content.filter(resource => resource.<%primaryKey%> !== <%primaryKey%>);
            page.totalElements--;
            ctx.patchState({
                page: page
            });
        }))
    }

    @Action(SearchResources)
    searchResources(ctx: StateContext<ResourceStateModel>, { query, pageNumber, pageSize }: SearchResources) {
        return this.resourceService.searchResources(query, pageNumber, pageSize).pipe(tap(page => {
            ctx.patchState({
                page: page
            });
        }))
    }
}