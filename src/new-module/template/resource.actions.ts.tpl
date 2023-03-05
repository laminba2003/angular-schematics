import { Resource } from '@app/model/resource';

export class GetResources {
    static readonly type = '[Resources] Fetch';
    constructor(public pageNumber : number, public pageSize : number ) { }
}

export class GetResource {
    static readonly type = '[Resource] Fetch';
    constructor(public <%primaryKey%>: <%primaryKeyType%>) { }
}

export class CreateResource {
    static readonly type = '[Resource] Create';
    constructor(public resource: Resource) { }
}

export class UpdateResource {
    static readonly type = '[Resource] Update';
    constructor(public <%primaryKey%>: <%primaryKeyType%>, public resource: Resource) { }
}

export class DeleteResource {
    static readonly type = '[Resource] Delete';
    constructor(public <%primaryKey%>: <%primaryKeyType%>) { }
}

export class SearchResources {
    static readonly type = '[Resources] Search';
    constructor(public query: string, public pageNumber : number, public pageSize : number) { }
}