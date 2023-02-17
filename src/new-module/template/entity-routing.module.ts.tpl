import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { EntityListViewComponent } from './entity-list-view/entity-list-view.component';

const routes: Routes = [{
  path: '', component: EntityListViewComponent,
},
{
  path: ':<%primaryKey%>', component: EntityListViewComponent
}];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule]
})
export class EntityRoutingModule { }
