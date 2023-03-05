import { Injectable } from '@angular/core';
import { Resource } from '@app/model/resource';
import { Observable } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { Page } from '@app/model/page';

@Injectable({
  providedIn: 'root'
})
export class ResourceService {

  private readonly backendUrl = '/apis/resources';

  constructor(private httpClient: HttpClient) { }

  getResources(page: number, size: number = 5): Observable<Page<Resource>> {
    return this.httpClient.get<Page<Resource>>(this.backendUrl, { params: { page: page, size: size } });
  }

  getResource(<%primaryKey%>: <%primaryKeyType%>): Observable<Resource> {
    return this.httpClient.get<Resource>(this.backendUrl + "/" + <%primaryKey%>);
  }

  createResource(resource: Resource): Observable<Resource> {
    return this.httpClient.post<Resource>(this.backendUrl, resource);
  }

  updateResource(id: number, resource: Resource): Observable<Resource> {
    return this.httpClient.put<Resource>(this.backendUrl + "/" + id, resource);
  }

  deleteResource(<%primaryKey%>: <%primaryKeyType%>): Observable<any> {
    return this.httpClient.delete(this.backendUrl + "/" + <%primaryKey%>);
  }

  searchResources(query: string, page: number, size: number = 5): Observable<Page<Resource>> {
    return this.httpClient.get<Page<Resource>>(this.backendUrl + "/search", { params: { query: query, page: page, size: size } });
  }

}
