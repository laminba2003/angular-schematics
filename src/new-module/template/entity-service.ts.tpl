import { Injectable } from '@angular/core';
import { Entity } from '../../model/entity';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Page } from '../../model/page';

@Injectable({
  providedIn: 'root'
})
export class EntityService {

  private readonly backendUrl = '/apis/entitys';

  constructor(private httpClient: HttpClient) { }

  getEntitys(page: number, size: number = 5): Observable<Page<Entity>> {
    return this.httpClient.get<Page<Entity>>(this.backendUrl, { params: { page: page, size: size } });
  }

  getEntity(<%primaryKey%>: <%primaryKeyType%>): Observable<Entity> {
    return this.httpClient.get<Entity>(this.backendUrl + "/" + <%primaryKey%>);
  }

  deleteEntity(<%primaryKey%>: <%primaryKeyType%>): Observable<any> {
    return this.httpClient.delete(this.backendUrl + "/" + <%primaryKey%>);
  }

  searchEntitys(query: string, page: number, size: number = 5): Observable<Page<Entity>> {
    return this.httpClient.get<Page<Entity>>(this.backendUrl + "/search", { params: { query: query, page: page, size: size } });
  }

}
