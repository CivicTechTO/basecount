var ageSliderOptions = {
    range: true,
    min: 18,
    max: 66,
    values: [18, 34],
    slide: function(e, ui) {
        if (ui.handleIndex === 0) {
            filters.age.min = ui.value;
        } else {
            filters.age.max = ui.value;
        }

        updateAges();
    }
};

var incomeSliderOptions = {
    range: true,
    min: 0,
    max: 251,
    values: [75, 75],
    slide: function(e, ui) {
        if (ui.handleIndex === 0) {
            filters.income.min = ui.value;
        } else {
            filters.income.max = ui.value;
        }

        updateIncomes();
    }
};

var ownershipSliderOptions = {
    min: 0,
    max: 100,
    value: 50,
    slide: function(e, ui) {
        filters.ownership.value = ui.value;
        updateOwnership();
    }
};
$('.range[name="age"]').slider(ageSliderOptions);
$('.range[name="income"]').slider(incomeSliderOptions);
$('.range[name="ownership"]').slider(ownershipSliderOptions);


// Opening an Overlay //
$(document).on("click", ".open[data-overlay]", function(e) {
    var $target = $(e.target);
    var $overlay = $('.overlay[data-overlay="' + $target.attr("data-overlay") + '"]');

    $overlay.show();
});

// Closing an Overlay //
$(document).on("click", ".close", function(e) {
    var $target = $(e.target);
    var $overlay = $target.closest(".overlay");

    $overlay.hide();
});

// Switching Tabs //
$(document).on("click", ".tab-bar li", function(e) {
    var $target = $(e.target);
    var $tabList = $target.closest(".tab-wrapper").find(".tabs");
    var tabSelector = '[data-tab="' + $target.attr("data-tab") + '"]';

    $target.siblings("[data-active]").removeAttr("data-active");
    $tabList.find("[data-active]").removeAttr("data-active");

    $target.attr("data-active", true);
    $tabList.find(tabSelector).attr("data-active", true);
});

// Toggling Checkboxes //
$(document).on('change', 'input[type="checkbox"]', function(e) {
    var $target = $(e.target);

    filters[$target.attr("name")].include = $target.prop("checked");
});


var map = L.map('map').setView([43.653, -79.383], 13);
var icon = L.icon({
    iconUrl: 'img/shelter.svg',
    iconRetinaUrl: 'img/shelter.svg',
    iconSize: [20, 20],
    iconAnchor: [13.5, 17.5],
    popupAnchor: [0, -1],
});

var icong = L.icon({
    iconUrl: 'img/shelterg.svg',
    iconRetinaUrl: 'img/shelterg.svg',
    iconSize: [20, 20],
    iconAnchor: [13.5, 17.5],
    popupAnchor: [0, -1],
});

var icony = L.icon({
    iconUrl: 'img/sheltery.svg',
    iconRetinaUrl: 'img/sheltery.svg',
    iconSize: [20, 20],
    iconAnchor: [13.5, 17.5],
    popupAnchor: [0, -1],
});
var iconr = L.icon({
    iconUrl: 'img/shelterr.svg',
    iconRetinaUrl: 'img/shelterr.svg',
    iconSize: [20, 20],
    iconAnchor: [13.5, 17.5],
    popupAnchor: [0, -1],
});
L.esri.basemapLayer('Gray').addTo(map);
var fl = L.esri.featureLayer({
    url: '//gis.toronto.ca/arcgis/rest/services/secondary/cot_geospatial_webm/MapServer/122/',
    useCors: false,
    pointToLayer: function(feature, latlng) {
        feature.properties['Overflow'] = Math.round(feature.properties['CAPACITY'] * .20);
        if (feature.properties.CAPACITY < 50) {
            marker = L.marker(latlng, {
                icon: icong
            });
        } else if (feature.properties.CAPACITY <= 75) {
            marker = L.marker(latlng, {
                icon: iconr
            });
        } else if (feature.properties.ratings > 200) {
            marker = L.marker(latlng, {
                icon: icong
            });
        } else {
            marker = L.marker(latlng, {
                icon: icony
            });
        }
        return marker;
        return L.marker(latlng, {
            icon: icon
        });
    }
}).addTo(map);
fl.bindPopup(function(layer) {

    return L.Util.template(
        "<u><b>Name:</b></u> {NAME}<br>" +
        "<u><b>Address:</b></u>  {ADDRESS_FULL}<br>" +
        "<u><b>Ward:</b></u>  {WARD}<br>" +
        "<u><b>Place:</b></u>  {PLACE_NAME}<br> " +
        "<u><b>Motel:</b></u>  {MOTEL}<br> " +
        "<u><b>Community:</b></u>  {COMMUNITY_COUNCIL}<br>" +
        "<u><b>City Operated:</b></u>  {CITY_OP}<br> " +
        "<u><b>Motel:</b>  {MOTEL}<br></u> " +
        "<u><b>Confidential:</b></u>  {CONFIDENTIAL}<br>" +
        "<u><b>Service Type:</b></u>  {TYPE}<br> " +
        "<u><b>Service Type:</b></u>  {TYPE2}<br> " +
        "<u><b>Noraml Capacity:</b></u>  {CAPACITY}<br>" +
        "<u><b>Overflow Capacity:</b></u> {Overflow} <br>" +
        "<br><u><b>Serivce and Shelter Info:</b></u> </br>" +
        "<div id='info1-pane' style='width: 220px; height: 200px;'>" +
        "<br><i> If near CAPACITY please call shelter to confirm space. Data updated last: DATE" +
        "<div id='chart1' style='width:  220px; height: 200px;'> <div id='chart2' style='width:  220px; height: 200px;'></div><div id='chart3' style='width:  220px; height: 200px;'></div>", layer.feature.properties);
}, { maxWidth: 325, minWidth: 325, minHeight: 250, maxHeight: 550, keepInView: true, autoPan: true, closeButton: true });

var gpService = L.esri.GP.service({
    url: "https://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Network/ESRI_DriveTime_US/GPServer/CreateDriveTimePolygons",
    useCors: false
});
var gpTask = gpService.createTask();
gpTask.setParam("Drive_Times", "1 2");
var driveTimes = L.featureGroup();
map.addLayer(driveTimes);

fl.on('click', function(evt) {
    for (i = 0; i < arrAddress.length; i++) {
        var nm = {},
            stringA = 'Johnny Appleseed',
            stringB = 'John Apples',
            stringC = 'Jon Appleton',
            finalScore = 0;

        nm = new fuzziac(evt.layer.feature.properties.ADDRESS_FULL.toUpperCase());
        finalScore = nm.score(arrAddress[i][2]);
        if (finalScore > .8) {

            document.getElementById('info1-pane').innerHTML = arrAddress[i][9];

        }
    }
    var capacity = evt.layer.feature.properties.CAPACITY;
    var mens = (capacity * .96 / capacity) * 100;
    var womens = (capacity * .9 / capacity) * 100;
    var family = (capacity * .7 / capacity) * 100;

    var purple = '#6a329e';
    var blue = '#00a6dd';
    var green = '#659e32';
    var orange = '#b85d26';

    var progress_opts = {
        font_color: "#fff",
        fill_color: "#222",
        background_color: "#00aadd",
        text_shadow: "rgba(0,0,0,.1)"
    };



    var progress1 = new Charts.CircleProgress('chart1', 'Men Occupancy', mens, {
        radius: 45,
        font_color: "#fff",
        fill_color: "#222",
        label_color: "#333",
        text_shadow: "rgba(0,0,0,.1)",
        stroke_color: blue
    });
    progress1.draw();

    var progress2 = new Charts.CircleProgress('chart2', 'Women Occupancy', womens, {
        font_color: "#fff",
        radius: 45,
        fill_color: "#222",
        label_color: "#333",
        text_shadow: "rgba(0,0,0,.1)",
        stroke_color: orange
    });
    progress2.draw()

    var progress3 = new Charts.CircleProgress('chart3', 'Family Occupancy', family, {
        radius: 45,
        font_color: "#fff",
        fill_color: "#222",
        label_color: "#333",
        text_shadow: "rgba(0,0,0,.1)",
        stroke_color: green
    });
    progress3.draw()

    driveTimes.clearLayers();
    gpTask.setParam("Input_Location", evt.latlng)
    gpTask.run(driveTimeCallback);
});



function driveTimeCallback(error, response, raw) {

    driveTimes.clearLayers();
    driveTimes.addLayer(L.geoJSON(response.Output_Drive_Time_Polygons));
}


var currentElectionOptions = {
    recordsField: null,
    locationMode: L.LocationModes.LATLNG,
    codeField: 'state',
    chartOptions: {
        'estimates[choice=Romney].value': {
            color: 'hsl(0,100%,25%)',
            fillColor: 'hsl(0,70%,60%)',
            maxValue: 1,
            maxHeight: 20,
            displayName: 'Romney',
            displayText: function(value) {
                return value.toFixed(2);
            }
        },
        'estimates[choice=Obama].value': {
            color: 'hsl(240,100%,25%)',
            fillColor: 'hsl(240,70%,60%)',
            maxValue: 1,
            maxHeight: 20,
            displayName: 'Obama',
            displayText: function(value) {
                return value.toFixed(2);
            }
        },
        'estimates[choice=Other].value': {
            color: 'hsl(240,5%,75%)',
            fillColor: 'hsl(240,5%,75%)',
            maxValue: 1,
            maxHeight: 20,
            displayName: 'Other',
            displayText: function(value) {
                return value.toFixed(2);
            }
        }
    },
    layerOptions: {
        fillOpacity: 0.9,
        opacity: 1,
        weight: 0.5,
        radius: 10,
        width: 5,
        barThickness: 5
    },
    // Use displayOptions to dynamically size the radius and barThickness according to the number of
    // polling results
    displayOptions: {
        'poll_count': {
            radius: new L.LinearFunction(new L.Point(0, 10), new L.Point(1000, 100)),
            barThickness: new L.LinearFunction(new L.Point(0, 4), new L.Point(1000, 80))
        }
    },
    tooltipOptions: {
        iconSize: new L.Point(80, 55),
        iconAnchor: new L.Point(-5, 55)
    },
    onEachRecord: function(layer, record) {
        var $html = $(L.HTMLUtils.buildTable(record));

        layer.bindPopup($html.wrap('<div/>').parent().html(), {
            minWidth: 400,
            maxWidth: 400
        });
    }
};

// var pollingResultsLayer = new L.PieChartDataLayer(data, currentElectionOptions);

// map.addLayer(pollingResultsLayer);