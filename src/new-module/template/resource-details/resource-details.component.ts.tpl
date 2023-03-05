import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Resource } from '@app/model/resource';

@Component({
  selector: 'app-resource-details',
  templateUrl: './resource-details.component.html',
  styleUrls: ['./resource-details.component.css']
})
export class ResourceDetailsComponent implements OnInit {

  constructor(private dialogRef: MatDialogRef<any>, @Inject(MAT_DIALOG_DATA) public resource: Resource) {

  }

  ngOnInit(): void {
    window.history.replaceState({}, '', `/resources/${this.resource.<%primaryKey%>}`);
    this.dialogRef.afterClosed().subscribe(() => {
      window.history.replaceState({}, '', `/resources`);
    });
  }


}