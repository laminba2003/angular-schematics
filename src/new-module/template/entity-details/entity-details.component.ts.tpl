import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Entity } from '../../../model/entity';
import { EntityListViewComponent } from './../entity-list-view/entity-list-view.component';

@Component({
  selector: 'app-entity-details',
  templateUrl: './entity-details.component.html',
  styleUrls: ['./entity-details.component.css']
})
export class EntityDetailsComponent implements OnInit {

  constructor(private dialogRef: MatDialogRef<EntityListViewComponent>, @Inject(MAT_DIALOG_DATA) public entity: Entity) {

  }

  ngOnInit(): void {
    window.history.replaceState({}, '', `/entitys/${this.entity.<%primaryKey%>}`);
    this.dialogRef.afterClosed().subscribe(() => {
      window.history.replaceState({}, '', `/entitys`);
    });
  }


}