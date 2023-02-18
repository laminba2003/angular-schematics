<app-header title="Entitys" [template]="buttons"></app-header>

<ng-template #buttons>
    <button mat-icon-button class="header-icon">
        <mat-icon>entity_add</mat-icon>
    </button>
    <button mat-icon-button (click)="refresh()" class="header-icon">
        <mat-icon>refresh</mat-icon>
    </button>
</ng-template>

<div class="flex flex-nowrap">
    <table mat-table [dataSource]="dataSource" matSort  class="w-full">
        <% for column in displayedColumns %>
        <ng-container matColumnDef="<%column%>">
            <th mat-header-cell *matHeaderCellDef class="text-sm" mat-sort-header> <%column%> </th>
            <td mat-cell *matCellDef="let entity" (click)="getEntity(entity.<%primaryKey%>)">
                <div>{{entity.<%column%>}}</div>     
            </td>
        </ng-container>
        <% end %>
       
        <ng-container matColumnDef="actions">
            <th mat-header-cell *matHeaderCellDef class="text-sm"> </th>
            <td mat-cell *matCellDef="let entity" class="text-sm  cursor-pointer" (click)="getEntity(entity.<%primaryKey%>)">
                <div>
                    <div class="float-right">
                        <button appDialog (click)="editEntity(entity.<%primaryKey%>);"
                            class="bg-white-500 text-black active:bg-pink-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                            type="button">
                            <i class="fas fa-edit"></i>
                        </button>

                        <button appDialog (click)="deleteEntity(entity.<%primaryKey%>)" *ngIf="auth.hasRoles([]) | async"
                            class="bg-white-500 text-black active:bg-pink-600 font-bold uppercase text-xs px-4 py-2 rounded shadow hover:shadow-md outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150"
                            type="button">
                            <i class="fas fa-trash"></i>
                        </button>
                    </div>
                </div>
            </td>
        </ng-container>

        <tr mat-header-row *matHeaderRowDef="displayedColumns"></tr>
        <tr mat-row *matRowDef="let row; columns: displayedColumns;" [ngClass]="{'table-loading': isLoading$ | async, 'text-sm':true, 'cursor-pointer':true}"></tr>
        <tr class="mat-row" *matNoDataRow style="text-align:center">
            <td class="mat-cell" [attr.colspan]="displayedColumns.length">
              No records
            </td>
        </tr>
    </table>
</div>
<div class="w-full">
    <mat-paginator [length]="page.totalElements" [pageSizeOptions] = "[5, 10, 25]" [showFirstLastButtons]="true" [pageSize]="page.size" (page)="handlePagination($event)"></mat-paginator>
</div>