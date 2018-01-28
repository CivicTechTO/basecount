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

var arrAddress = [];
arrAddress[0] = ["Adelaide Resource Centre for Women", "<!DOCTYPEhtml><html><head></head><body></body></html>", "67 ADELAIDE ST E", "Toronto", "M5C 1K6", "43.650840759277344", "-79.37538146972656"];
arrAddress[0][7] = "<div><div> 416 392-9243</div></div>";
arrAddress[0][8] = "<div></div>";
arrAddress[0][9] = "<p>The Adelaide Resource Centre for Women offers a safe, welcoming place for all women. The goal is to aid women who are homeless, socially alone and isolated, or in need of assistance. With the support of social and government agencies, the Adelaide Resource Centre for Women helps women access healthcare, housing, learn life skills, and join social activities. Women also have access to laundry, shower facilities and phones. Lunch is provided daily.</p><p>A Drop-In for women is operated by Fred Victor out of this location. Open 24 hours a day, seven days a week, staff welcome all women who come through the doors and provides them with:</p><ul><li>Peer support</li><li>Informal counselling</li><li>Information and referrals</li><li>Case management<br /><br /></li></ul><p>The space also makes available necessities such as food, rest,&nbsp;clothing, toiletries and hygiene products, and other items.</p><p></p><p></p><p></p><p></p><p><object id=\"__symantecPKIClientMessenger\" style=\"display: none;\" data-install-updates-user-configuration=\"true\" data-extension-version=\"0.4.0.129\"></object></p>";

arrAddress[1] = ["Annex Harm Reduction Program", "<!DOCTYPEhtml><html><head></head><body></body></html>", "339 GEORGE ST ", "Toronto", "M5A 2N2", "43.65989303588867", "-79.37446594238281"];
arrAddress[1][7] = "<div><div> 416 338-3190</div></div>";
arrAddress[1][8] = "<div></div>";
arrAddress[1][9] = "<p>As part of Seaton House, The Annex is home to 114 homeless men who have lived on the street for a very long time and need a lot of help because of alcohol addiction and other serious illnesses. The Annex helps homeless men get better through a harm reduction approach (reducing the harm they could do to themselves) that helps them with alcohol addictions and health problems. In some cases, their alcohol addictions are so severe they will drink mouthwash, hand sanitizer and rubbing alcohol. Therefore, at The Annex, the men and their alcohol intake are closely supervised to make sure they don't further harm themselves.</p><p>Get a look at <a href=\"/wps/portal/contentonly?vgnextoid=ac2baf2c85006410VgnVCM10000071d60f89RCRD&amp;vgnextchannel=bad1ab2cedfb0410VgnVCM10000071d60f89RCRD\">a day in the life of the Annex Program</a>.<br />&nbsp;</p>";

arrAddress[2] = ["Bellwoods House", "<!DOCTYPEhtml><html><head></head><body></body></html>", "63 BELLWOODS AVE ", "Toronto", "M6J 3N4", "43.647953033447266", "-79.41156768798828"];
arrAddress[2][7] = "<div><div> 416 392-5790</div></div>";
arrAddress[2][8] = "<div></div>";
arrAddress[2][9] = "<p>Bellwoods House is a flexible, respectful long-term shelter for women over the age of 50. Bellwoods clients are long-term shelter users, who have a history of mental illness and have been homeless for a long time. Bellwoods House has staff on-site 24-hours a day who work with each woman to help her set goals and deal with challenges. Clients are asked to help with household chores to the best of their ability.<br /> <br /> Clients come from Women's Residence.</p>";

arrAddress[3] = ["Birchmount Residence", "<!DOCTYPEhtml><html><head></head><body></body></html>", "1673 KINGSTON RD ", "Toronto", "M1N 1S6", "43.69145965576172", "-79.26419067382812"];
arrAddress[3][7] = "<div><div> 416 392-5797</div></div>";
arrAddress[3][8] = "<div></div>";
arrAddress[3][9] = "<p>Birchmount Residence is a shelter for homeless men over the age of 55. With 23 bedrooms - most with two beds and a bathroom, it can house up to 60 men at a time. Residents have access to a shared laundry room and eat together in the main dining room. Each resident has 24-hour staff access for assistance.</p><p>Birchmount Residence operates using a Housing First approach that supports homeless senior men to transition back into the community, as quickly as possible. Independent Service Plans are established within seven days of admission. Plans are supported by:</p><ul><li>A case manager who assists with short-term goals and housing searches</li><li>Onsite life-skills (housing readiness: managing money, shopping, cooking, running a home and maintaining social networks) and social/recreational programming</li><li>Referrals and advocacy services</li><li>Partnerships with community agencies and a family health team &nbsp;(doctor is on-site bi-weekly)</li><li>Follow-up support once they leave the shelter<br /> </li></ul><p>Admission is by referral from other shelters for men. In certain cases, self-referrals will be reviewed and assessed.</p><p><br />&nbsp;</p><p></p><p><object id=\"__symantecPKIClientMessenger\" style=\"display: none;\" data-install-updates-user-configuration=\"true\" data-extension-version=\"0.4.0.129\"></object></p>";

arrAddress[4] = ["Birkdale Residence", "<!DOCTYPEhtml><html><head></head><body></body></html>", "1229 ELLESMERE RD ", "Toronto", "M1P 4V8", "43.768245697021484", "-79.26763153076172"];
arrAddress[4][7] = "<div><div> 416 392-5650</div></div>";
arrAddress[4][8] = "<div></div>";
arrAddress[4][9] = "<p>Birkdale is a safe, gender-inclusive program for all types of families in need of short term, emergency shelter. The shelter's main site is in Scarborough but it operates two other satellites programs within Toronto. Each family is provided with their own room with sleeping accommodations for their family size, a shared space for cooking, and laundry facilitates. Families are responsible for providing their own independent living needs. Each resident has 24-hour staff access for assistance.</p><p>Birkdale operates using a Housing First approach that supports families to transition back into the community as quickly as possible. Independent Service Plans are established within seven days of admission. Plans are supported by:</p><ul><li>a case manager who assists with short-term goals and housing searches</li><li>programming for families and their children</li><li>follow up support once they leave the shelter<br /><br /></li></ul><p><b>Pregnancy Program&nbsp;</b> <br /> Based on availability of space, single women requiring emergency shelter who are in the third trimester of their pregnancy may be admitted to this family shelter.</p><p><b>Family Reunification Program </b><br /> Single parents in need of emergency shelter in a family setting in order to be reunited with their children in foster care may be eligible for placement at Birkdale. To be eligible, there must be an active plan for the children to be returned to the parent's care and plans for overnight visits. Admission under this program is limited to the availability of space in the shelter.</p><p>Clients come from Central Intake only. For help please call 311 or Central Intake at 416-338-4766 or toll free in Toronto 1-877-338-3398.</p>";

arrAddress[5] = ["Downsview Dells", "<!DOCTYPEhtml><html><head></head><body></body></html>", "1651 SHEPPARD AVE W", "Toronto", "M3M 2X4", "43.74201583862305", "-79.49657440185547"];
arrAddress[5][7] = "<div><div> 416 392-5452</div></div>";
arrAddress[5][8] = "<div></div>";
arrAddress[5][9] = "<p>Downsview Dells is a 30-bed shelter for homeless men or men who are at risk of losing their housing, and who wish to abstain from the use of drugs and alcohol. Downsview works within a 12-step recovery model and offers a safe shelter alternative to support a client&rsquo;s treatment plan.</p><p  >While living at the shelter, clients are required to attend outpatient treatment services in the community and participate in in-house programs while exploring personal development. Housing is always the final outcome for the Downsview Dells program. Staff work from a housing first approach and in partnership with the clients to secure longer term housing solutions or transitional housing programs.</p><p  >Downsview Dells provides on-site programming that addresses self esteem and skill development. It also provides meals, emergency accommodations and recreational programs and has partnerships with the local health care team in the community. Staff are on-site 24 hours a day for support. The shelter also has partnerships with mental health specialists, a family health team and an available psychiatrist.</p><p  >Downsview Dells cannot accommodate clients who are on methadone or any new pill alternative due to the structure and close relationships that are fostered during the program. Clients are asked to attend detox for 72 hours prior to admission. Upon admission, clients are required to remain on-site for a minimum of seven days.</p><p  ><b>Eligibility Criteria</b></p><ul><li>Must contact Downsview Dells for pre-screening</li></ul><ul><li>Access detox for 72 hours prior to admission within the week</li></ul><ul><li>Must have or have access to health coverage<br /><br /></li></ul><p><b>Screening and admission<br /></b>As part of the pre-screening process, staff will ask each client&nbsp; to complete an eligibility form to determine if they are a right fit for the program. Forms are available for any agency staff to complete. Once completed, the form is submitted to the assessment team for consideration. Admission usually occurs within one week or, on an emergency basis, immediately.</p><p  >Referrals are received from hospitals, detox, detention centres, shelters and other community agencies. Self referrals are also accepted as long as the eligibility criteria is met.</p><p  ></p>";

arrAddress[6] = ["Family Residence", "<!DOCTYPEhtml><html><head></head><body></body></html>", "4222 KINGSTON RD ", "Toronto", "M1E 2M6", "43.76061248779297", "-79.19694519042969"];
arrAddress[6][7] = "<div><div> 416 397-1318</div></div>";
arrAddress[6][8] = "<div></div>";
arrAddress[6][9] = "<p>Family Residence gives shelter to 52 families in need. Two-parent or single parent families with children, couples and pregnant women with a partner can come to Family Residence when they have no where to go. Each family has their own room with beds, a fridge and a microwave. They share kitchens and laundry rooms. Families get money to buy food and take care of cooking and cleaning. Each residence has 24-hour help for families if they need it and residence workers try to help them to get into:</p><ul><li style=\"list-style: none;\"></li><li>counselling</li><li>children's programs</li><li>pregnancy support program</li><li>housing and help after they move in</li><li>workshops about housing readiness, life skills and getting a job<br /><br /></li></ul><p>Family Residence also runs several motel programs for families.</p><p>Clients come from Central Intake only. For help please call 311 or Central Intake at 416-338-4766 or toll free in Toronto 1-877-338-3398.</p>";

arrAddress[7] = ["Fort York Residence", "<!DOCTYPEhtml><html><head></head><body></body></html>", "38 BATHURST ST ", "Toronto", "M5V 3W3", "43.64105224609375", "-79.40287017822266"];
arrAddress[7][7] = "<div><div> 416 338-8800</div></div>";
arrAddress[7][8] = "<div></div>";
arrAddress[7][9] = "<p>Recognizing that many clients accessing the emergency shelter system are motivated to achieve some level of employability, Fort York Residence opened its doors in 2004 as a transition to work and housing facility for men. Within a single facility, clients can move from shelter to transitional housing at affordable rents while receiving the support needed to find employment and housing.</p><p>Fort York Residence is not an emergency shelter. Access is limited to clients who have been identified through a referring shelter or community agencies as good candidates to obtain and maintain long-term affordable housing and employment. Clients must save approximately 60 per cent of their income as part of their savings plan for a future payment of first and last month's rent for housing in the community.&nbsp;&nbsp;</p><p>Fort York Residence is three storeys and houses 74 shelter beds and 24 self-contained bachelor units. The shelter beds are dormitory-style with low level walls dividing the spaces into groups of two or eight. Each resident is provided a locker to store personal belongings and access to a shared laundry facility, lounge, dining hall and resource centre.</p><p>During their stay in the shelter, clients focus on finding and maintaining employment, educational development, community participation through volunteer work and long-term financial planning. Workshops are offered on topics such as computer literacy, resume writing, employment searches and life skills. Once employment is secured, clients work with staff to prepare for independent living with a focus on managing their money and searching for housing.</p><p>Clients who are working full-time and are making progress in their individualized program may have the opportunity to move from the shelter to one of the 24 transitional housing units on the third floor. Each unit is equipped with a kitchenette, bathroom and living area. Residents of these units must also save approximately 30 per cent of their income for future payment of first and last month's rent. The goal for those living in these units is to be able to move into permanent housing within nine months. Once they move out of Fort York Residence, follow-up support from a housing worker is provided based on the individual case plan.</p>";

arrAddress[8] = ["O'Neill House", "<!DOCTYPEhtml><html><head></head><body></body></html>", "339 GEORGE ST ", "Toronto", "M5A 2N2", "43.65989303588867", "-79.37446594238281"];
arrAddress[8][7] = "<div><div> 416 392-5436</div></div>";
arrAddress[8][8] = "<div></div>";
arrAddress[8][9] = "<p>O'Neill House, which is part of Seaton House in downtown Toronto, runs housing first programs on its first and second floors, helping homeless men find permanent housing and reestablish themselves in the community.<br />&nbsp;</p>";

arrAddress[9] = ["Robertson House", "<!DOCTYPEhtml><html><head></head><body></body></html>", "291 SHERBOURNE ST ", "Toronto", "M5A 2R9", "43.66054916381836", "-79.37167358398438"];
arrAddress[9][7] = "<div><div> 416 392-5662</div></div>";
arrAddress[9][8] = "<div></div>";
arrAddress[9][9] = "<p>Robertson House is a shelter for pregnant women and women with children in need of short-term emergency shelter. Each family is provided with their own room with sleeping accommodations for their family size. There are 37 rooms (some accessible) with shared bathrooms. Families have access to a shared laundry room and eat together in the main dining room. Each resident has 24-hour staff access for assistance.</p><p>Robertson House operates using a Housing First approach that supports families to transition back into the community, as quickly as possible. Independent Service Plans are established within seven days of admission. Plans are supported by:</p><ul><li>A case manager who assists with short-term goals and housing searches</li><li>Referrals to counselling and advocacy</li><li>Children and youth programs</li><li>Onsite life-skills (workshops on financial literacy, health, benefits, community services) and recreational programming (women and children)</li><li>Partnerships with community agencies and a family health team&nbsp; (doctor is on-site bi-weekly)</li><li>Follow-up support after they move to their own place<br /><br /></li></ul><p><b>Pregnancy Program</b></p><p>Based on availability of space, single women requiring short-term emergency shelter who are in the third trimester of their pregnancy may be admitted to Robertson House.</p><p><b>Family Reunification Program </b><br /> Women in need of emergency shelter in a family setting in order to be reunited with their children (who have been placed in foster care) may be eligible for placement at Robertson House. To be eligible, there must be an active plan for the children to be returned to the parent's care and plans for overnight visits. Admission under this program is limited to the availability of space in the shelter.</p><p>Clients are referred by Central Intake only. For help please call 311 or Central Intake at 416-338-4766 or toll-free in Toronto 1-877-338-3398.</p><p></p><p><object id=\"__symantecPKIClientMessenger\" style=\"display: none;\" data-install-updates-user-configuration=\"true\" data-extension-version=\"0.4.0.129\"></object></p>";

arrAddress[10] = ["Seaton House", "<!DOCTYPEhtml><html><head></head><body></body></html>", "339 GEORGE ST ", "Toronto", "M5A 2N2", "43.65989303588867", "-79.37446594238281"];
arrAddress[10][7] = "<div><div> 416 392-5522</div><div> 416 392-5527</div></div>";
arrAddress[10][8] = "<div></div>";
arrAddress[10][9] = "<p>Seaton House is operated by City of Toronto staff with four programs to help up to 543 homeless men in downtown Toronto. The men staying at Seaton House have a range of needs, such as those with very poor health, drug and alcohol problems, and mental illness. Men come to Seaton House for temporary emergency shelter and through referrals from hospitals, jails, and other institutions, as well as from other shelters. The Emergency Hostel Program has 240 beds; the Long Term Program has 134 bed; the Annex/Infirmary Program has 114 beds. The O'Neill Program helps first-time homeless men, many of whom are newcomers. City staff and those from community partner agencies provide extensive services to the men on site.</p><p>Like other shelters in Toronto, the goal at Seaton House is to provide temporary shelter and supports to find permanent housing. However, some of the programs are designed to allow longer stays. In fact, many of the residents have come to consider Seaton House their home and stay for months or years. This is especially true with residents in both the Long Term and Annex/Infirmary Programs. So although Seaton House itself is aging (built in 1959), and inadequate (in fact, it is part of the redevelopment plan for George Street, called <a href=\"http://homer-1.inet.toronto.ca/wps/portal/contentonly?vgnextoid=a5dfd9f9849b2410VgnVCM10000071d60f89RCRD&amp;vgnextchannel=c0aeab2cedfb0410VgnVCM10000071d60f89RCRD\">George Street Revitalization</a>), it has become de facto long term and/or supportive housing or long-term care for many. Long-term residents may have been referred to and evicted from other housing or long-term care homes because these facilities are often not able to serve those with complex combinations of health, mental health, behavioural and/or addictions.</p><p>Learn more about the <a href=\"http://homer-1.inet.toronto.ca/wps/portal/contentonly?vgnextoid=ac2baf2c85006410VgnVCM10000071d60f89RCRD&amp;vgnextchannel=c0aeab2cedfb0410VgnVCM10000071d60f89RCRD&amp;appInstanceName=default&amp;vgnextrefresh=1#\">Annex Program</a></p><p>.</p>";

arrAddress[11] = ["Streets to Homes Assessment & Referral Centre (SHARC)", "<!DOCTYPEhtml><html><head></head><body></body></html>", "129 PETER ST ", "Toronto", "M5V 2H3", "43.648685455322266", "-79.3934326171875"];
arrAddress[11][7] = "<div><div> 416 392-0090</div></div>";
arrAddress[11][8] = "<div></div>";
arrAddress[11][9] = "<p>This facility at 129 Peter Street in the Entertainment District is the anchor for all downtown street outreach work. Since it opened in November 2010, almost 300 people have moved into permanent housing after working with Streets to Homes staff and staying in one of the 40 transition-to-housing bed programs at the SHARC. These beds are reserved for those actively working on a housing plan.</p><p>Housing workers at the SHARC are available without appointment to those looking for help to get off the streets and into housing. The walk-in housing service has been used by 1,700 different people in the SHARC's first five years.</p><p>There are two ways to access Toronto's emergency shelters: a 24-hour phone line to Central Intake (available through 311 as well) and a 24-hour walk-in service at the SHARC for those in the downtown core. SHARC staff referr people to emergency shelters and other services in the city, including meal programs, drop-ins and Out-of-the-Cold sites. There have been more than 142,000 visits to the SHARC over the years.</p><p>Contact the Streets to Homes Assessment and Referral Centre 24 hours a day at 416-392-0090.</p>";

arrAddress[12] = ["Women's Residence", "<!DOCTYPEhtml><html><head></head><body></body></html>", "674 DUNDAS ST W", "Toronto", "M5T 1H9", "43.65191650390625", "-79.40388488769531"];
arrAddress[12][7] = "<div><div> 416 392-5500</div></div>";
arrAddress[12][8] = "<div></div>";
arrAddress[12][9] = "<p>Women's Residence is a place for homeless, single women in downtown Toronto. The shelter offers many services to help homeless women from all backgrounds. Residence staff can speak more than 15 different languages. Women's Residence has 34 bedrooms with two to five beds. Women share the washrooms and laundry facilities on each floor. There is a large, main-floor dining room where everyone eats their meals.<br /> <br /> Women's Residence works with local social agencies and hospitals such as:</p><ul><li>the Sherbourne Health Centre,</li><li>University Health Network (Toronto Western Hospital),</li><li>the Centre for Addiction and Mental Health,</li><li>Women's Own Withdrawal Management Centre,</li><li>St. Clare's Multifaith Housing Society,</li><li>the Hostel Outreach Program and</li><li>St. Michael's Hospital<br /><br /></li></ul><p>If you are a homeless woman over age 16 call 311 or Central Intake at 416-338-4766, toll-free in Toronto 1-877-338-3398, or go directly to the Women's Residence for help, 24 hours a day, seven days a week.<br />&nbsp;</p>";








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