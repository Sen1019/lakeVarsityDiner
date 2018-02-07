<!-- THIS IS A RIOT COMPONENT - ALL OF THIS CODE IS PLACED IN home.html USING <plotDetails></plotDetails> -->
<plotDetails>
    <!-- HTML SPECIFIC TO THIS COMPONENT -->
    <div class="container-fluid">
        <div class="row plotDetailsRow">
            <div class="col-md-12">
                <table id="plotsTable" class="table table-fixed">
                    <thead>
                        <tr>
                            <th class="col-md-1">Color</th>
                            <th class="col-md-3">Plot Name</th>
                            <th class="col-md-3" style="padding-left: 0px">Plant Type</th>
                            <th class="col-md-2" style="padding-left: 25px">Width</th>
                            <th class="col-md-2">Height</th>
                            <th class="col-md-1">Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr each={ plots } id="row{plotId}">
                            <td class="col-md-1" id="colorBox"><input type="color" value={ fill } data-plotId={plotId} onchange={colorSelector}></td>
                            <td class="col-md-3">{plotName}</td>
                            <td class="col-md-3" id="plantDropDown">
                                <select id="selectedPlant" class="form-control" onchange="{plantSelected}" data-plotId="{plotId}">
                                    <option each={ plants } value={plantId} data-ppa = {pricePerPlant / areaPerPlant}>{commonName}</option>
                                </select>
                            </td>
                            <td class="col-md-2" style="padding-left: 25px" id="width{plotId}">{ width }ft</td>
                            <td class="col-md-2" id="height{plotId}">{ height }ft</td>
                            <td class="col-md-1" id = "price{plotId}"> $Cash </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!-- CSS SPECIFIC TO THIS COMPONENT -->
    <style>
        .plotDetailsRow {
            padding-left: 15px;
            border-top: 1px solid lightgrey;
            border-right: 1px solid lightgrey;
        }
        .table-fixed {
            margin-bottom: 0;
        }
        .table-fixed thead {
            width: 100%;
        }
        .table-fixed tbody {
            height: 275px;
            overflow-y: auto;
            width: 100%;
        }
        .table-fixed thead, .table-fixed tbody, .table-fixed tr, .table-fixed td, .table-fixed th {
            display: block;
        }
        .table-fixed tbody td, .table-fixed thead > tr> th {
            float: left;
            border-bottom-width: 0;
        }
        #colorBox {
            padding-bottom: 5px;
        }
        #plantDropDown {
            padding: 0px;
            height: 37px;
        }
        
        #selectedPlant {
            width: 75%;
			height: 37px;
			border-radius: 0px;
			-webkit-appearance: none;
				-webkit-border-radius: 0px;
				background-image: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#444' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
				background-position: 100% 50%;
				background-repeat: no-repeat;
			text-align: left;
			padding-left: 5px;
        }
    
    </style>

    <!-- Javascript SPECIFIC TO THIS COMPONENT -->
    <script>
        var self = this;
		self.plants = [];
        self.plots = [];

	//RIOT Mount
		this.on('mount', function() {

            getAllPlants()

    //Get all plants
			function getAllPlants() {
				$.ajax({
					url: GARDEN.root + "getAllPlants",
					type: "GET",
					dataType: "json"
				}).done(function(data) {
					GARDEN.plants = data;
					self.plants = data;
                    self.update();
				});
			}

    //Load plots when a garden is selected
            GARDEN.on('gardenSelectionUpdated', function() {

                self.plants = [];
                GARDEN.plants.forEach(function(plant){
                    if(plant.region == GARDEN.currentGarden.region){
                        self.plants.push(plant);
                    }
                });

                $.ajax({
                    url: GARDEN.root + "getPlotsByGarden?gardenId=" + GARDEN.currentGarden.gardenId,
                    type: "GET",
                }).then(function(data){
                    GARDEN.currentGarden.plotInfo = data;
                    self.plots = data;

                    if(data.length != 0){
                        var plotObjects = JSON.parse(GARDEN.currentGarden.plotsJson).objects;
                        
                        GARDEN.currentGarden.plotInfo.forEach(function(e1) {
                            plotObjects.forEach(function(e2){
                                if(e1.plotId == e2.id){
                                    e1.height = e2.height * e2.scaleY / 20;
                                    e1.width = e2.width * e2.scaleX / 20;
                                    e1.fill = e2.fill;
                                }
                            },this)
                        }, this);

                        self.plots = GARDEN.currentGarden.plotInfo;
                    }else{
                        self.plot = [];
                    }
                    self.update();

                    GARDEN.currentGarden.plotInfo.forEach(function(event){
                        $("#row" + event.plotId + " #selectedPlant option[value='" + event.plantId +"']").attr("selected","selected");
                        GARDEN.plants.forEach(function(plant){
                            if(plant.plantId == event.plantId){
                                $("#price" + event.plotId).text("$" + (event.height*event.width*plant.pricePerPlant/plant.areaPerPlant).toFixed(2));
                            }
                        }, this)
                    },this);


                })
                self.update();
            });

    //Color selection trigger
            this.colorSelector = function(e){
                GARDEN.trigger("colorUpdate",{"plotId":$(e.target).attr("data-plotId"),"fill":$(e.target).val()});
                GARDEN.trigger("plotRectangleSelected", $(e.target).attr("data-plotId"));
            };

    //New plot created handler
            GARDEN.on("newPlotCreated", function(data){
                $.ajax({
                    url: GARDEN.root + "getPlotById?plotId=" + data.id,
                    method: "GET",
                }).then(function(result){
                    result.height = data.height * data.scaleY / 20;
                    result.width = data.width * data.scaleX / 20;
                    result.fill = data.fill;
                    result.gardenId = GARDEN.currentGarden.gardenId;
                    GARDEN.currentGarden.plotInfo.push(result);

                    self.plots = GARDEN.currentGarden.plotInfo;
                    self.update();

                    $("#row" + result.plotId + " #selectedPlant option[value='" + result.plantId +"']").attr("selected","selected");
                    GARDEN.plants.forEach(function(plant){
                            if(plant.plantId == result.plantId){
                                $("#price" + result.plotId).text("$" + (result.height*result.width*plant.pricePerPlant/plant.areaPerPlant).toFixed(2));
                            }
                    }, this)
                });
            });

    //When the garden save button is clicked
            GARDEN.on('saveButtonClicked', function(){
                var plotUpdateArray = [];
                GARDEN.currentGarden.plotInfo.forEach(function(plot){

                    $.ajax({
                        url: GARDEN.root + "savePlot",
                        method: "POST",
                        data: {
                            'plotId': plot.plotId,
                            'plantId': plot.plantId,
                            'gardenId': plot.gardenId,
                        }
                    });
                });
            });

    //The plant is changed in a plot row
            this.plantSelected = function(e){
                GARDEN.currentGarden.plotInfo.forEach(function(plot){
                    if(plot.plotId == $(e.target).attr("data-plotId")){
                        plot.plantId = $(e.target).find(":selected").val();
                        $("#price" + plot.plotId).text("$" + (plot.height*plot.width*$(e.target).find(":selected").attr("data-ppa")).toFixed(2));
                        GARDEN.trigger("plantSelected", plot.plantId);
                    }

                });

                self.plots = GARDEN.currentGarden.plotInfo;
                self.update();
               
            }

    //When one of the plot rectangles are selected
            GARDEN.on("plotRectangleSelected", function(selectedPlotId){
                var table = document.getElementById("plotsTable");
                for (var i = 0, row; row = table.rows[i]; i++) {
                    if($(row).attr("id") == "row"+selectedPlotId){
                        for(var j = 0, child; child = $(row).children()[j]; j++){
                            var rgb = hexToRgb($("input[data-plotId='" + selectedPlotId + "']").val());
                            $(child).attr("style","background: rgba(" + rgb.r + "," + rgb.g + "," + rgb.b + "," + rgb.a + ")");
                        }
                        //$(row).addClass("active");
                    }else{
                        for(var j = 0, child; child = $(row).children()[j]; j++){
                            $(child).attr("style","background: rgba(255,255,255)");
                        }
                        //$(row).removeClass("active");
                    }
                }
                self.update();
            });
            
            function hexToRgb(hex) {
                var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
                return result ? {
                    r: parseInt(result[1], 16),
                    g: parseInt(result[2], 16),
                    b: parseInt(result[3], 16),
                    a: 0.1,
                } : null;
            }
		})

    //When a garden is deleted
        GARDEN.on("gardenDeleted", function(){
            $("tbody tr").empty();
            self.update();
        });

    </script>
</plotDetails>