<div class="max-w-2xl mx-auto bg-white">
	<form [formGroup]="form" (ngSubmit)="onSubmit()">
        <div class="grid gap-6 mb-6 lg:grid-cols-2">
            <% for column in displayedColumns %>
                <div>
                    <label for="<%column%>" class="required block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300"><%column | pascal%></label>
                    <input type="text" id="<%column%>" formControlName="<%column%>"  class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="<%column%>">
                </div>
            <% end %>
        </div>
        <div class="float-right"> 
            <button type="submit" [disabled]="form.invalid" class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Submit</button>
            <button mat-dialog-close class="text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm w-full sm:w-auto px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Cancel</button>
        </div>
    </form>
</div>