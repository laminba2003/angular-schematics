<app-header title="Resources" [template]="buttons"></app-header>

<ng-template #buttons>
    <button mat-icon-button *ngIf="auth.hasRoles([]) | async">
        <mat-icon>resource_add</mat-icon>
    </button>
    <button mat-icon-button (click)="refresh()">
        <mat-icon>refresh</mat-icon>
    </button>
</ng-template>

<div class="flex flex-nowrap">
    <table mat-table [dataSource]="dataSource" matSort>
        <% for column in displayedColumns %>
        <ng-container matColumnDef="<%column%>">
            <th mat-header-cell *matHeaderCellDef  mat-sort-header> <%column%> </th>
            <td mat-cell *matCellDef="let resource">
                <div>{{resource.<%column%>}}</div>     
            </td>
        </ng-container>
        <% end %>
       
        <ng-container matColumnDef="actions">
            <th mat-header-cell *matHeaderCellDef> </th>
            <td mat-cell *matCellDef="let resource">
                <div>
                    <div *ngIf="resource.<%primaryKey%>">
                        <button appDialog (click)="updateResource(resource.<%primaryKey%>)"
                            type="button">
                            <i class="fas fa-edit"></i>
                        </button>

                        <button appDialog (click)="deleteResource(resource.<%primaryKey%>)" *ngIf="auth.hasRoles([]) | async"
                            type="button">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            </td>
        </ng-container>

        <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
        <tr mat-row *matRowDef="let resource; columns: displayedColumns;"  (click)="getResource(resource.<%primaryKey%>)"
          [ngClass]="{'table-loading': isLoading$ | async, 'highlight': selected.<%primaryKey%> && selected.<%primaryKey%> == resource.<%primaryKey%>}"></tr>
        <tr class="mat-row" *matNoDataRow style="text-align:center">
            <td class="mat-cell" [attr.colspan]="displayedColumns.length">
              No records
            </td>
        </tr>
    </table>
</div>

<mat-paginator [length]="page.totalElements" [pageSizeOptions] = "[5, 10, 25]" [showFirstLastButtons]="true" [pageSize]="page.size" (page)="handlePagination($event)"></mat-paginator>