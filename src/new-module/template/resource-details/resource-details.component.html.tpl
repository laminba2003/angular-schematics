<div class="overflow-hidden bg-white shadow sm:rounded-lg">
    <div class="float-right mr-2 mt-2">
        <button mat-dialog-close>
            <mat-icon>close</mat-icon>
        </button>
    </div>
    <div class="px-4 py-5 sm:px-6">
        <h3 class="text-lg font-medium leading-6 text-gray-900">Resource Information</h3>
    </div>
    <div class="border-t border-gray-200">
        <dl>
          <% for column in displayedColumns %>
            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                <dt class="text-sm font-medium text-gray-500">Name</dt>
                <dd class="mt-1 text-sm text-gray-900 sm:col-span-2 sm:mt-0">{{resource.<%column%>}}</dd>
            </div>
          <% end %>  
        </dl>
    </div>
</div>