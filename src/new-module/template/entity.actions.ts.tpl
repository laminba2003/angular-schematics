import { Entity } from '@app/model/entity';

export class GetEntitys {
    static readonly type = '[Entitys] Fetch';
    constructor(public pageNumber : number, public pageSize : number ) { }
}

export class GetEntity {
    static readonly type = '[Entity] Fetch';
    constructor(public <%primaryKey%>: <%primaryKeyType%>) { }
}

export class AddEntity {
    static readonly type = '[Entity] Add';
    constructor(public payload: Entity) { }
}

export class UpdateEntity {
    static readonly type = '[Entity] Update';
    constructor(public payload: Entity, public <%primaryKey%>: <%primaryKeyType%>) { }
}

export class DeleteEntity {
    static readonly type = '[Entity] Delete';
    constructor(public <%primaryKey%>: <%primaryKeyType%>) { }
}

export class SearchEntitys {
    static readonly type = '[Entitys] Search';
    constructor(public query: string, public pageNumber : number, public pageSize : number) { }
}