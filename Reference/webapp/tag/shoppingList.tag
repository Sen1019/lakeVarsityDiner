<!-- THIS IS A RIOT COMPONENT - ALL OF THIS CODE IS PLACED IN home.html USING <gardenCanvas></gardenCanvas> -->

<shoppingList>

    <div class="modal fade" id="shoppingListModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">Your Shopping List</h4>
                </div>
                <div class="modal-body" id="shoppingListModalBody">

                    <div each={ gardens }>
                            <h4>{gardenName}</h4>
                        <table id="gardenTable{gardenId}"  class = "gardenTable table">
                            <tr class = "gardenTableHead">
                                <th>Plot</th>
                                <th>Plant</th>
                                <th>Price Per Plant</th>
                                <th>Plants Needed</th>
                                <th>Cost</th>
                            </tr>
                        </table>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="newPlotCancelButton">Close</button>
                </div>
            </div>
        </div>
    </div>

    <style>
        #shoppingListModal{
            margin-top: 3%;
        }
        #shoppingListModalBody{
            max-height: 600px;
            overflow-y: auto;
        }

    </style>

    <script>
        var self = this;

		this.on("mount", function(){
			
	        GARDEN.on("shoppingListButtonClicked", function(){

                $(".gardenTable tr[class!='gardenTableHead']").remove();

                self.gardens = GARDEN.gardens;
                self.update();
                
                GARDEN.gardens.forEach(function(garden){

                    var gardenTable = document.getElementById("gardenTable" + garden.gardenId);
                	
                	$.ajax({
                        url: GARDEN.root + "getPlotsByGarden?gardenId=" + garden.gardenId,
                        method: "GET"
                    }).then(function(plots){

                        if(plots.length != 0){
                            var plotsJsonObject = JSON.parse(garden.plotsJson).objects;
                            
                            plotsJsonObject.forEach(function(plot){

                                plots.forEach(function(plotDb){

                                    if(plot.id == plotDb.plotId){
                                        GARDEN.plants.forEach(function(plant){

                                            if(plant.plantId == plotDb.plantId){
                                                var row = gardenTable.insertRow();
                                                row.insertCell(0).innerHTML = plotDb.plotName;
                                                row.insertCell(1).innerHTML = plant.commonName;
                                                row.insertCell(2).innerHTML = plant.pricePerPlant;
                                                row.insertCell(3).innerHTML = Math.ceil(plot.height*plot.scaleY*plot.scaleX*plot.width/400/plant.areaPerPlant);
                                                row.insertCell(4).innerHTML = (plot.height*plot.scaleY*plot.scaleX*plot.width/400*plant.pricePerPlant/plant.areaPerPlant).toFixed(2);
                                            }
                                        });
                                    }
                                })
                            })
                        }
                        var row = gardenTable.insertRow();
                        row.insertCell(0).innerHTML = "-------";
                        row.insertCell(1).innerHTML = "-------";
                        row.insertCell(2).innerHTML = "-------";
                        row.insertCell(2).innerHTML = "-------";
                        row.insertCell(4).innerHTML = "-------";
                    });
                });

                $("#shoppingListModal").modal();
	
            });
            

		});

    </script>
</shoppingList>