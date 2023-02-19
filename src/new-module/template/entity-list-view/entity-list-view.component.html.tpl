<app-header title="Entitys" [template]="buttons"></app-header>

<ng-template #buttons>
    <button mat-icon-button *ngIf="auth.hasRoles([]) | async">
        <mat-icon>entity_add</mat-icon>
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
            <td mat-cell *matCellDef="let entity">
                <div>{{entity.<%column%>}}</div>     
            </td>
        </ng-container>
        <% end %>
       
        <ng-container matColumnDef="actions">
            <th mat-header-cell *matHeaderCellDef> </th>
            <td mat-cell *matCellDef="let entity" cursor-pointer">
                <div>
                    <div *ngIf="entity.<%primaryKey%>">
                        <button appDialog (click)="editEntity(entity.<%primaryKey%>);"
                            type="button">
                            <i class="fas fa-edit"></i>
                        </button>

                        <button appDialog (click)="deleteEntity(entity.<%primaryKey%>)" *ngIf="auth.hasRoles([]) | async"
                            type="button">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            </td>
        </ng-container>

        <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
        <tr mat-row *matRowDef="let entity; columns: displayedColumns;"  (click)="getEntity(entity.<%primaryKey%>)"
          [ngClass]="{'table-loading': isLoading$ | async}"></tr>
        <tr class="mat-row" *matNoDataRow style="text-align:center">
            <td class="mat-cell" [attr.colspan]="displayedColumns.length">
              No records
            </td>
        </tr>
    </table>
</div>

<mat-paginator [length]="page.totalElements" [pageSizeOptions] = "[5, 10, 25]" [showFirstLastButtons]="true" [pageSize]="page.size" (page)="handlePagination($event)"></mat-paginator>