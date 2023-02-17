import { Injectable } from "@angular/core";
import { Action, State, StateContext } from "@ngxs/store";
import { tap } from "rxjs";
import { Page } from "../../model/page";
import { Entity } from "../../model/entity";
import { EntityService } from './entity-service';
import { DeleteEntity, GetEntity, GetEntitys, SearchEntitys } from './entity.actions';

export class EntityStateModel {
    page: Page<Entity>;
    entity: Entity
}

@State<EntityStateModel>({
    name: 'entitystate',
    defaults: {
        page: new Page<Entity>(),
        entity: new Entity()
    }
})
@Injectable()
export class EntityState {
    constructor(private entityService: EntityService) { }

    @Action(GetEntitys)
    getEntitys(ctx: StateContext<EntityStateModel>, { pageNumber, pageSize }: GetEntitys) {
        return this.entityService.getEntitys(pageNumber, pageSize).pipe(tap(page => {
            ctx.patchState({
                page: page
            });
        }))
    }

    @Action(GetEntity)
    getEntity(ctx: StateContext<EntityStateModel>, { <%primaryKey%> }: GetEntity) {
        return this.entityService.getEntity(<%primaryKey%>).pipe(tap(entity => {
            ctx.patchState({
                entity: entity
            });
        }))
    }

    @Action(DeleteEntity)
    deleteEntity(ctx: StateContext<EntityStateModel>, { <%primaryKey%> }: DeleteEntity) {
        return this.entityService.deleteEntity(<%primaryKey%>).pipe(tap(() => {
            const state = ctx.getState();
            const page = state.page;
            page.content = page.content.filter(entity => entity.<%primaryKey%> !== <%primaryKey%>);
            page.totalElements--;
            ctx.patchState({
                page: page
            });
        }))
    }

    @Action(SearchEntitys)
    searchEntitys(ctx: StateContext<EntityStateModel>, { query, pageNumber, pageSize }: SearchEntitys) {
        return this.entityService.searchEntitys(query, pageNumber, pageSize).pipe(tap(page => {
            ctx.patchState({
                page: page
            });
        }))
    }
}