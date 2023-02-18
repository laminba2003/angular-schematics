import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EntityRoutingModule } from './entity-routing.module';
import { EntityListViewComponent } from './entity-list-view/entity-list-view.component';
import { ComponentsModule } from '@components/components.module';
import { EntityDetailsComponent } from './entity-details/entity-details.component';
import { NgxsModule } from '@ngxs/store';
import { EntityState } from './entity.state';
import { DirectivesModule } from '@directives/directives.module';

@NgModule({
  declarations: [
    EntityListViewComponent,
    EntityDetailsComponent
  ],
  imports: [
    CommonModule,
    EntityRoutingModule,
    ComponentsModule,
    DirectivesModule,
    NgxsModule.forFeature([EntityState])
  ]
})
export class EntityModule { }