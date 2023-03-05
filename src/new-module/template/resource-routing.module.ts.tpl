import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { ResourceListViewComponent } from './resource-list-view/resource-list-view.component';

const routes: Routes = [{
  path: '', component: ResourceListViewComponent,
},
{
  path: ':<%primaryKey%>', component: ResourceListViewComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class ResourceRoutingModule { }
