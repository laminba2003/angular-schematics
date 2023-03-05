import { Component, Inject, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Resource } from '@app/model/resource';

@Component({
  selector: 'app-resource-edit',
  templateUrl: './resource-edit.component.html',
  styleUrls: ['./resource-edit.component.css']
})
export class ResourceEditComponent implements OnInit {

  form: FormGroup;
  
  constructor(private dialogRef: MatDialogRef<any>, private fb: FormBuilder, @Inject(MAT_DIALOG_DATA) private data: any) {
    this.form = this.fb.group({
      <% for column in displayedColumns %><%column%>: [data.resource.<%column%>, Validators.required],
      <% end %>
    });
  }

  ngOnInit(): void {
    const resource = this.data.resource;
    if (resource.<%primaryKey%>) {
      window.history.replaceState({}, '', `/resources/${resource.<%primaryKey%>}`);
    } else {
      window.history.replaceState({}, '', `/resources`)
    }
    this.dialogRef.afterClosed().subscribe(() => {
      window.history.replaceState({}, '', `/resources`);
    });
  }

  onSubmit(): void {
    this.data.callback(this.getData());
    this.dialogRef.close();
  }

  private getData(): Resource {
    const resource = new Resource();
    <% for column in displayedColumns %>resource.<%column%>= this.form.value.<%column%>;
    <% end %>
    return resource;
  }

}