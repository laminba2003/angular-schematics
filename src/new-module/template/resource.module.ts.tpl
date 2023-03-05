import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ResourceRoutingModule } from './resource-routing.module';
import { ResourceListViewComponent } from './resource-list-view/resource-list-view.component';
import { ComponentsModule } from '@components/components.module';
import { ResourceDetailsComponent } from './resource-details/resource-details.component';
import { ResourceEditComponent } from './resource-edit/resource-edit.component';
import { NgxsModule } from '@ngxs/store';
import { ResourceState } from './resource.state';
import { DirectivesModule } from '@directives/directives.module';

@NgModule({
  declarations: [
    ResourceListViewComponent,
    ResourceDetailsComponent,
    ResourceEditComponent
  ],
  imports: [
    CommonModule,
    ResourceRoutingModule,
    ComponentsModule,
    DirectivesModule,
    NgxsModule.forFeature([ResourceState])
  ]
})
export class ResourceModule { }