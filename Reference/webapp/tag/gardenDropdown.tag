<!-- THIS IS A RIOT COMPONENT - ALL OF THIS CODE IS PLACED IN home.html USING <gardenDropdown></gardenDropdown> -->
<gardenDropdown>

	<!-- HTML SPECIFIC TO THIS COMPONENT -->
	<div class="container-fluid">
	  <div class="row no-gutters">
	  	<div class="col-md-1">
	  		<button id="gardensButton" type="button" class="btn btn-default btn-static">Gardens</button>
	  	</div>
	  	<div class="col-md-6 dropdown">
			<select id="gardenDropDownItems" class="form-control">
			  <option>Please select a garden</option>	
			  <option each={ gardens } onchange={getGardenById} value={gardenId}>{gardenName}</option>
			</select>
	  	</div>
	  	<div class="col-md-1">
	  		<button id="plusButton" type="button" class="btn btn-default" data-toggle="modal" data-target="#newGardenModal" onclick="{createNewGarden}"><span class="glyphicon glyphicon-plus" aria-hidden="true"></span></button>
	  	</div>
	  	<div class="col-md-1">
	  		<button id="minusButton" type="button" class="btn btn-default" data-toggle="modal" data-target="#deleteGardenModal"><span class="glyphicon glyphicon-minus" aria-hidden="true"></span></button>
	  	</div>
	  	<div class="col-md-1">
	  		<button id="saveButton" type="button" class="btn btn-default">Save</button>
	  	</div>
	  	<div class="col-md-1">
				<a id="downloadLink">
					<button id="shareButton" type="button" class="btn btn-default" onclick={download}>Download</button>
				</a>
	  	</div>
	  	<div class="col-md-1">
	  		<button id="shoppingListButton" type="button" class="btn btn-default" onclick ={shoppingList}>Shopping List</button>
	  	</div>
	  </div>
	</div>

	<!-- CREATE NEW GARDEN -->
	<div class="modal fade" id="newGardenModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">Enter new garden name:</h4>
	      </div>
	      <div class="modal-body">
	        <input type="text" name="new-garden-input" id="new-garden-input" class="form-control" placeholder="Grandpa's Potato Patch">
	      </div>
	      <div class="dropdown">
		  	<select id="regionDropdownMenuItems" class="form-control">
					<option style="display:none;" selected>Please select a region</option>
					<option value="1">Cold</option>
					<option value="2">Cool</option>
					<option value="3">Moderate</option>
					<option value="4">Warm</option>
					<option value="5">Hot</option>
				</select>
		</div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="newGardenCancelButton">Cancel</button>
	        <button type="button" class="btn btn-primary" id="newGardenSaveButton">Save</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

	<!-- DELETE GARDEN -->
	<div class="modal fade" id="deleteGardenModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title">Are you sure you want to delete your garden?</h4>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal" id="deleteGardenCancelButton">Cancel</button>
	        <button type="button" class="btn btn-primary" id="deleteGardenDeleteButton">Delete</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->

	<!-- CSS SPECIFIC TO THIS COMPONENT -->
	<style>
		#dropdownMenu1 {
			width: 35%;
			border-radius: 0px;
			text-align: left;
			padding-left: 25px;
			background-color: white;
		}

		#gardenDropDownItems {
			width: 100%;
			height: 42px;
			border-radius: 0px;
			-webkit-appearance: none;
				-webkit-border-radius: 0px;
				background-image: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
				background-position: 100% 50%;
				background-repeat: no-repeat;
			text-align: left;
			padding-left: 5px;
		}

		.caret {
			float: right;
			margin-top: 7px;
		}

		.input-group-addon {
			border-radius: 0px;
		}

		#userDropDown {
			padding-right: 50px;
		}

		.dropdown {
			display: inline;
			padding-right: 0px;
			border-right: 0px;
		}

		#dropdownMenu1, #gardensButton, #minusButton, #plusButton, #saveButton, #shareButton, #shoppingListButton {
			padding: 10px 0px 10px 0px;
			border-radius: 0px;
			width: 100%;
		}

		#newGardenCancelButton {
			border-radius: 0;
		}

		#newGardenSaveButton {
			background-color: #2E7F39;
			border-radius: 0;
		}

		#deleteGardenCancelButton {
			border-radius: 0;
		}

		#deleteGardenDeleteButton {
			background-color: #D9534F;
			border-color: #D43F3A;
			border-radius: 0;
		}

		#regionDropdownMenuItems {
			text-align: left;
			width: 95%;
			margin: 0px 15px 0px 15px;
			border-radius: 0;
			-webkit-appearance: none;
				-webkit-border-radius: 0px;
				background-image: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
				background-position: 100% 50%;
				background-repeat: no-repeat;}

		#new-garden-input {
			border-radius: 0;
		}
	</style>

	<!-- Javascript SPECIFIC TO THIS COMPONENT -->
	<script>
		var self = this;
		self.gardens = [];

		//RIOT Mount
		this.on('mount', function() {

			//Ran on login to get all gardens by user ID
			getCurrentGardens();

			//Get all gardens by currentUserId and store in self.gardens array above
			function getCurrentGardens(callback) {
				$.ajax({
					url: GARDEN.root + "user/currentUser",
					type: "GET",
					dataType: "json",
				}).then(function(data) {
					GARDEN.gardens = data.gardens;
					self.gardens = data.gardens;
					$("#usersEmailAddress").text(data.email);
					self.update();
				}).then(callback);
			}

			//Create new garden
			$("#newGardenSaveButton").on("click", function() {
				var newGardenName = $("#new-garden-input").val();
				var newGardenRegion = $("#regionDropdownMenuItems").val();
				event.stopPropagation();
				event.preventDefault();
				$.ajax({
					url: GARDEN.root + "newGarden",
					type: "POST",
					data: {
						gardenName: newGardenName,
						region: newGardenRegion
					},
					dataType: "json"
				}).done(function(data) {
					$('#newGardenModal').modal('hide');
					$("#new-garden-input").val("");
					$("#regionDropdownMenuItems").val("Please select a region");
					getCurrentGardens(function() {
						$('#gardenDropDownItems option').last().attr('selected', 'selected');
					GARDEN.selectedGardenIndex = $("#gardenDropDownItems option:selected").index() - 1;
					GARDEN.currentGarden = self.gardens[GARDEN.selectedGardenIndex];
					GARDEN.trigger('gardenSelectionUpdated');
					});
				});
			});

			//Delete current garden
			$("#deleteGardenDeleteButton").on("click", function() {
				var selectedGardenId = GARDEN.currentGarden.gardenId;
				$.ajax({
					url: GARDEN.root + "deleteGarden",
					type: "POST",
					data: {
						gardenId: selectedGardenId
					}
				}).done(function(data) {
					getCurrentGardens();
					GARDEN.trigger("gardenDeleted");
					$('#deleteGardenModal').modal('hide');
				});
			});

			//Capture selected garden object and place in GARDEN.currentGarden for global access
			$("select").on("change", function() {
				GARDEN.selectedGardenIndex = $("#gardenDropDownItems option:selected").index() - 1;
				GARDEN.currentGarden = self.gardens[GARDEN.selectedGardenIndex];
				GARDEN.trigger('gardenSelectionUpdated');
			});

			//Save button clicked
			$("#saveButton").on("click", function() {
				GARDEN.gardenBeforeSave = $("#gardenDropDownItems").find(":selected").val();
				if(GARDEN.gardenBeforeSave != "Please select a garden"){
					GARDEN.trigger('saveButtonClicked');
				}
			});
			//Run when updated garden is saved
			GARDEN.on('updatedGardenPull', function() {
				getCurrentGardens(function() {
						$("#gardenDropDownItems option[value='" + GARDEN.gardenBeforeSave + "']").attr('selected', 'selected');
						alert("Garden was saved successfully!")
				});
			});

		//Shopping list button clicked

		this.shoppingList = function(e){
			//Temporary
			GARDEN.trigger("shoppingListButtonClicked");
		}

		//Download Button Clicked
		this.download = function(e){
			GARDEN.trigger("downloadButtonClicked", e);
		}
		GARDEN.on("canvasPng", function(e, png){
			if('currentGarden' in GARDEN){
				$("#downloadLink").attr("href",png);
				$("#downloadLink").attr("download", GARDEN.currentGarden.gardenName +".png");
			}
		})

	})
	</script>

</gardenDropdown>
