<!-- THIS IS A RIOT COMPONENT - ALL OF THIS CODE IS PLACED IN home.html USING <plotDetails></plotDetails> -->
<plantDirections>
   <!-- HTML SPECIFIC TO THIS COMPONENT -->
   <div class="container-fluid mainPlantDirectionsDiv">
        <div class="row">
            <div class="col-md-12 headerBackground">
                <h2 id="plantDirectionsHeader">Planting Directions</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <img src="../img/tomato.jpg" id="plantImage" class="pull-left"/>
                <h3 id = "plantName">Tomato</h3>
                <p id = "plantDirections">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.</p>
                <h4 id= "plantPopularity"></h4>
            </div>
        </div>
    </div>

    <!-- CSS SPECIFIC TO THIS COMPONENT -->
    <style>

        .mainPlantDirectionsDiv {
            height: 275px;
            border-top: 1px solid lightgrey;
        }
        #plantImage {
            width: 150px;
            height: 150px;
            object-fit: cover;
            margin: 4px 0px 0px 15px;
            padding-right: 15px;   
        }
        #plantDirectionsHeader {
            text-align: center;
            font-family: 'Bad Script', cursive;
            border-bottom: 1px solid lightgray;
            font-size: 36px;
            margin: 15px 15px 10px 15px;
        }
        #plantDirectionsItem {
            margin-top: 0;
        }
        h3 {
            margin-top: 0;
        }
        p {
            padding: 0px 15px 0px 15px;
        }
        #plantPopularity{
            padding-left: 15px;
        }
        /* img {
            object-fit: cover;
        } */

    </style>

    <!-- Javascript SPECIFIC TO THIS COMPONENT -->
    <script>

        //RIOT Mount
        this.on('mount', function() {

        //Change on trigger
            GARDEN.on("plantSelected", function(selectedPlantId){

                GARDEN.plants.forEach(function(plant){

                    if(plant.plantId == selectedPlantId){
                        $("#plantImage").attr("src", plant.imageLink);
                        $("#plantName").text(plant.commonName);
                        $("#plantDirections").text(plant.plantingDirections);
                        riot.update();
                    }
                });
                $.ajax({
                    url: GARDEN.root + "getPlantsByPopularity?plantId=" + selectedPlantId,
                    method: "GET",
                }).then(function(count){
                    if(count<2){
                        $("#plantPopularity").text("This plant is in " + count + " user's plots!");
                    }else{
                        $("#plantPopularity").text("This plant is in " + count + " users' plots!");
                    }
                    
                });
            });
            
            

        });

    </script>

</plantDirections>