$fn = 20;
renderSwitches = false;

outWidth = 19;
inWidth = 14;
angle = 8;
thickness = 3;
height = 11;

numColumns = 13;
numRows = 5;

switchPlateToKeyCapDist = 7.41;
switchBottomToKeyCapDist = 14.1;
switchBottomToPlateDist = switchBottomToKeyCapDist - switchPlateToKeyCapDist;
//switchPlateTo
verticalWallOffset = 0.12;
thumbOffset = 0;

//middlePlateHeight = 10;
middlePlateHeight = 9;
proMicroCaddyX = outWidth * (numColumns - 2.5);
proMicroCaddyWidth = 30;
proMicroPortHoleWidth = 3;
proMicroPortHoleLength = 21;
proMicroPortHoleHeight = 8;
proMicroPortOffset = 1.5;

bottomPlateHeight = 1;

bottomRowAngleMult = 1.5;

bottomWallOffset = 0.53;

//height + middle + bottom = 22(?)


keyRow3Trans = identityMatrix();

keyRow2Trans = translationMatrix(0, outWidth, 0) * xRotMatrix(angle);
keyRow1Trans = keyRow2Trans * translationMatrix(0, outWidth, 0) * xRotMatrix(angle);
    
keyRow4Trans = xRotMatrix(-angle) * translationMatrix(0, -outWidth, 0);
keyRow5Trans = keyRow4Trans * xRotMatrix(angle * bottomRowAngleMult) * translationMatrix(0, -outWidth, 0);

keyRowTransformations = [keyRow1Trans, keyRow2Trans, keyRow3Trans, keyRow4Trans, keyRow5Trans];


topCornerPos = keyRow1Trans * [0, outWidth + thickness, -switchPlateToKeyCapDist - verticalWallOffset, 1];
topCornerY = topCornerPos[1];
bottomCornerPos = keyRow5Trans * [0, 0, 0, 1];
bottomCornerY = bottomCornerPos[1];

innerKeyboardWidth = numColumns * outWidth;
innerKeyboardHeight = numRows * outWidth;

resetButtonOffset = 171;
resetButtonRadius = 3;
resetButtonHeight = 1;

screwHoleWidth = 1.3;
screwHoleBottomPlateWidth = 2.1;
screwHolePadding = 1;
topScrewHeight = thickness;

//translate([0, topCornerPos[1], topCornerPos[2]])
//cube(1);

//slicedKeyboard(-10, thickness + outWidth * 6 - 2.5 + 10);
//slicedKeyboard(thickness + outWidth * 6 - 2.5, 1000);


//proMicro();
//proMicroCaddy();
//


difference() {
    fullKeyboard();
    keyboardFloorCutter();
}


//resetButton();



//allSwitches("model");


//cuttableBottomFloor();

//keyboardWalls();



module cuttableBottomFloor() {
    projection(cut = true)
    translate([0, 0, height + middlePlateHeight + bottomPlateHeight / 2])
    keyboardFloor();
}


module resetButton() {
    translate([resetButtonOffset, topCornerY - thickness, -height - middlePlateHeight - resetButtonHeight + 0])
    rotate([0, 0, -90])
    import("button.stl", convexity=10);
}

module slicedKeyboard(offsetX, sliceWidth) {
    difference() {
        fullKeyboard();
        translate([offsetX, -500, -500])
        cube([sliceWidth, 1000, 1000]);
    }
    
    
}

module fullKeyboard() {
    union() {
    keyboardBase();
    keyboardWalls();
    //middleWalls();
    //screwHoles(screwHoleWidth, screwHolePadding, topScrewHeight, -height, 1, true);

    }
}

module keyboardFloor() {
    difference () {
        keyboardFloorBase();
        
        screwHoles(screwHoleBottomPlateWidth, screwHolePadding, 10, -height - middlePlateHeight - bottomPlateHeight - 5, 1, false, true);
        
        resetButton();

    }
}

module keyboardFloorBase() {
    topPos = keyRow1Trans * [0, outWidth + thickness, -switchPlateToKeyCapDist, 1];
    topY = topPos[1];
    echo(topY);
    bottomPos = keyRow5Trans * [0, 0, 0, 1];
    bottomY = bottomPos[1];
    echo(bottomY);
    
    width = numColumns * outWidth + thickness * 2;
    length = (topY - bottomY) + thickness;
    
    translate([-thickness, bottomY - thickness, - (height + middlePlateHeight + bottomPlateHeight)])
    cube([width, length, bottomPlateHeight]);
    
    //

}

module keyboardFloorCutter() {
    topPos = keyRow1Trans * [0, outWidth + thickness, -switchPlateToKeyCapDist, 1];
    topY = topPos[1];
    echo(topY);
    bottomPos = keyRow5Trans * [0, 0, 0, 1];
    bottomY = bottomPos[1];
    echo(bottomY);
    
    width = numColumns * outWidth + thickness * 20;
    length = (topY - bottomY) + thickness * 10;
    
    cutHeight = bottomPlateHeight + 100;
    translate([-thickness - 5, bottomY - thickness, - (height + middlePlateHeight + cutHeight)])
    cube([width, length, cutHeight]);
    
    //

}





module middleWalls() {
    tol = 0.3;
    union() {
        difference() {
            middleWallsBase();
            
            translate([proMicroCaddyX - proMicroPortHoleLength / 2, topCornerY - thickness - tol / 2, -height - middlePlateHeight - tol])
                cube([proMicroPortHoleLength, proMicroPortHoleWidth + tol, proMicroPortHoleHeight + tol]);
        } 
        
    translate([proMicroCaddyX, topCornerY - thickness, -height - middlePlateHeight])
        import("promicro-port-hole.stl", convexity=10);
        
        screwHoles(screwHoleWidth, screwHolePadding,, middlePlateHeight, -height - middlePlateHeight, 1);
    }
    
}

module middleWallsBase() {
    translate([0, 0, -height - middlePlateHeight])
    linear_extrude(height=middlePlateHeight)
    projection(cut=true)
    translate([0, 0, height-0.01])
    keyboardWalls();
}

function screwHoleXYpositions(halfWidth, middleScrewOffsetY) = [
        [halfWidth, bottomCornerY + halfWidth],
        [halfWidth, topCornerY - thickness - halfWidth],
        [innerKeyboardWidth - halfWidth, bottomCornerY + halfWidth],
        [innerKeyboardWidth - halfWidth, topCornerY - thickness - halfWidth],
        [4 * outWidth, - middleScrewOffsetY],
        [9 * outWidth, - middleScrewOffsetY],
        [4 * outWidth, outWidth + middleScrewOffsetY],
        [9 * outWidth, outWidth + middleScrewOffsetY],
        [innerKeyboardWidth / 2, bottomCornerY + halfWidth],
        [innerKeyboardWidth / 2, topCornerY - thickness - halfWidth]
];

module screwHoles(radius, padding, screwHeight, screwZ, middleScrewOffsetY, middleScrewsOnly, cylindersOnly) {
    holeWidth = (screwHoleWidth + screwHolePadding) * 2;
    halfWidth = holeWidth / 2;
    
    realZ = screwZ + screwHeight / 2;
    
    screwXYpositions = screwHoleXYpositions(halfWidth, middleScrewOffsetY);
    
    //TODO: clean code!!!!
    if (cylindersOnly) {
        screwHolesHelper(screwXYpositions, 0, 9, radius, padding, screwHeight, realZ, "cylinder", holeWidth / 2);
    } else {
    
        if (middleScrewsOnly) {
            screwHolesHelper(screwXYpositions, 4, 7, radius, padding, screwHeight, realZ, "cube", 0);
        } else {
            screwHolesHelper(screwXYpositions, 0, 9, radius, padding, screwHeight, realZ, "hole", 0);
        }
    }
}

module screwHolesBak(radius, padding, screwHeight, screwZ, middleScrewOffsetY, middleScrewsOnly, cylindersOnly) {
    holeWidth = (radius + padding) * 2;
    
    screwXYpositions = [
        [0, bottomCornerY],
        [0, topCornerY - thickness - holeWidth],
        [innerKeyboardWidth - holeWidth, bottomCornerY],
        [innerKeyboardWidth - holeWidth, topCornerY - thickness - holeWidth],
        [4 * outWidth - holeWidth / 2, -holeWidth / 2 - middleScrewOffsetY],
        [9 * outWidth - holeWidth / 2, -holeWidth / 2 - middleScrewOffsetY],
        [4 * outWidth - holeWidth / 2, outWidth + -holeWidth / 2 + middleScrewOffsetY],
        [9 * outWidth - holeWidth / 2, outWidth + -holeWidth / 2 + middleScrewOffsetY],
        [innerKeyboardWidth / 2 - holeWidth / 2, bottomCornerY],
        [innerKeyboardWidth / 2 - holeWidth / 2, topCornerY - thickness - holeWidth],
    ];
    
    if (cylindersOnly) {
        screwHolesHelper(screwXYpositions, 0, 9, radius, padding, screwHeight, screwZ, "cylinder", holeWidth / 2);
    } else {
    
        if (middleScrewsOnly) {
            screwHolesHelper(screwXYpositions, 4, 7, radius, padding, screwHeight, screwZ, "cube", 0);
        } else {
            screwHolesHelper(screwXYpositions, 0, 9, radius, padding, screwHeight, screwZ, "hole", 0);
        }
    }
}

module screwHolesHelper(screwXYpositions, start, end, radius, padding, screwHeight, screwZ, type, offsetXY) {
    for ( i = [start : end] ) {
        x = screwXYpositions[i][0];
        y = screwXYpositions[i][1];
        //z = -height - middlePlateHeight;
        translate([x + 0, y + 0, screwZ])
        if (type == "hole") {
            screwHole(radius, padding, screwHeight);
        } else if (type == "cube") {
            cubeWidth = (radius + padding) * 2;
            cube([cubeWidth, cubeWidth, screwHeight], center = true);
        } else if (type == "cylinder") {
            cylinder(h = screwHeight, r = radius, center = true);
        }
    }
}

module screwHole(innerRadius, padding, height) {
    difference() {
        cubeWidth = (innerRadius + padding) * 2;
        cube([cubeWidth, cubeWidth, height], center = true);
        
        //translate([cubeWidth / 2, cubeWidth /2, -1])
        cylinder(h = height + 2, r = innerRadius, center = true);
    }
    
}

module proMicroCaddy() {
    translate([proMicroCaddyX, topCornerY - thickness, -(height + middlePlateHeight)])
    rotate([0, 0, 0])
    import("promicro-caddy.stl", convexity=10);
    //import("promicro.stl", convexity=10);
}

/*
module proMicro() {
    translate([proMicroPortX, 47, -16])
    rotate([0, -180, 90])
    //import("promicro-caddy.stl", convexity=10);
    import("promicro.stl", convexity=10);
}*/

/*
module proMicro() {
    translate([proMicroPortX, 59, -12.5])
    rotate([0, 0, 180])
    //import("promicro-caddy.stl", convexity=10);
    import("promicro.stl", convexity=10);
}*/


module proMicro() {
    translate([proMicroCaddyX, topCornerY - thickness + proMicroPortOffset, -(height + middlePlateHeight) + 0])
    //rotate([180, 0, 0])
    //import("promicro-caddy.stl", convexity=10);
    import("promicro.stl", convexity=10);
}

module keyboardWalls() {
    topOffset = [0, -outWidth - thickness, 0, 1] * keyRow1Trans;
    echo("top offset:");
    echo(topOffset[2]);
    //moveHeight = height - topOffset[2];
    moveHeight = height + 100;
    
    difference() {
        keyboardWallsUnsliced(height * 2);
        translate([-1000, -1000, -moveHeight - 100])
        cube([2000, 2000, 100]);
    }
}

module keyboardWallsUnsliced(height) {
    union() {
    placedSideWalls(height, switchPlateToKeyCapDist, switchBottomToKeyCapDist);
    placedTopWall(angle, numColumns * outWidth, switchPlateToKeyCapDist, height, verticalWallOffset, thickness);
    placedBottomWall(angle, numColumns * outWidth, height, verticalWallOffset);
    }
}

//extrudedSwitchArc(1);

module keyboardBase() {
    difference() {
        extrudedSwitchArc(numColumns);
        allSwitches("cutout");
    }
    if (renderSwitches) {
        allSwitches("model");
    }
}



module allSwitches(type) {
    switchRows(4, type, true);

    translate([outWidth * 4, 0, 0])
    switchRows(1, type, false);
    translate([outWidth * 5, 0, 0])
    switchRows(1, type, false);
    
    translate([outWidth * 4.5, 0, 0])
    placedThumbKey(angle, type);

    translate([outWidth * 6, 0, 0])
    switchRows(1, type, true);

    translate([outWidth * 7, 0, 0])
    switchRows(1, type, false);
    translate([outWidth * 8, 0, 0])
    switchRows(1, type, false);
    
    translate([outWidth * 7.5, 0, 0])
    placedThumbKey(angle, type);

    translate([outWidth * 9, 0, 0])
    switchRows(4, type, true);
}

//extrudedSwitchArc();

module switchRows(numRows, type, inclThumbKeys) {
    for ( i = [0 : numRows - 1] ) {
        translate([outWidth * i, 0, 0]) {
            switchColumn(angle, type, inclThumbKeys);
        }
    }
}

module extrudedSwitchArc(numColumns) {
    rotate([0, 90, 0])
    linear_extrude(height = numColumns * outWidth)
        switchArcPolygon(angle, thickness, 0);
    
    //projection(cut=true)
    //import("arc-base-3d-v3.stl", convexity=10);
}

module placedSideWalls(downThickness, upThickness, cutoffLength) {
    translate([-thickness, 0, 0])
        placedSideWall(downThickness, upThickness, cutoffLength);
    
    translate([numColumns * outWidth, 0, 0])
        placedSideWall(downThickness, upThickness, cutoffLength);
    
}

module placedSideWall(downThickness, upThickness, cutoffLength) {
    cutoffPoint = keyRow1Trans * [0, outWidth, -cutoffLength - verticalWallOffset, 1];
    
    difference() {
        rotate([0, 90, 0])
        linear_extrude(height = thickness)
        switchArcPolygon(angle, downThickness, upThickness);
        
        translate([-1, cutoffPoint[1], cutoffPoint[2] - downThickness])
        cube([thickness + 2, downThickness, downThickness]);
    }
}


module placedTopWall(angle, length, angledHeight, verticalHeight, off, thickness) {
    topTrasform = keyRow1Trans * translationMatrix(-thickness, outWidth, -angledHeight - off);
    
    multmatrix(topTrasform) {
        //translate([-thickness, outWidth, -angledHeight - off])
        cube([length + thickness * 2, thickness, angledHeight]);
    }
    
    offsetPoint = topTrasform * [0, thickness, 0, 1];
    
    translate([-thickness, offsetPoint[1] - thickness, offsetPoint[2] - verticalHeight])
    cube([length + thickness * 2, thickness, verticalHeight]);
    
    /*
    outerOffsetPoint = topTrasform * [0, thickness, 0, 1];
    innerOffsetPoint = topTrasform * [0, 0, 0, 1];
    
    fullVertHeight = verticalHeight + outerOffsetPoint[2] - innerOffsetPoint[2];
    translate([-thickness, outerOffsetPoint[1] - thickness, outerOffsetPoint[2] - fullVertHeight])
    cube([length + thickness * 2, thickness, fullVertHeight]);
    */
}

module placedBottomWall(angle, length, height, off) {
    
    /*
    translate([0, bottomWallOffset, 0])
    multmatrix(keyRow5Trans) {
        rotate([-angle * 0.5, 0, 0]) {
            translate([-thickness, -thickness, -height - off])
                cube([length + thickness * 2, thickness, height]);
            
            translate([-thickness, 0, -height - off])
                cube([thickness,10,height]);
            
            translate([-thickness + length + thickness, 0, -height - off])
                cube([thickness,10,height]);
        }
        //translate([-thickness, -thickness, -height - off])
        //        cube([length + thickness * 2, thickness, height]);
    }
    */
    multmatrix(keyRow5Trans) {
            translate([-thickness, -thickness, -height - off])
                cube([length + thickness * 2, thickness, height]);
            
            translate([-thickness, 0, -height - off])
                cube([thickness,10,height]);
            

        //translate([-thickness, -thickness, -height - off])
        //        cube([length + thickness * 2, thickness, height]);
    }

}

module placedThumbKey(angle, type) {
    multmatrix(keyRow5Trans)
        switch(type);
}


module switchColumn(angle, type, inclThumbKeys) {
    multmatrix(keyRow1Trans)
    switch(type);
    
    multmatrix(keyRow2Trans)
    switch(type);
    
    multmatrix(keyRow3Trans)
    switch(type);
    
    multmatrix(keyRow4Trans)
    switch(type);
    
    if (inclThumbKeys) {
        multmatrix(keyRow5Trans)
        switch(type);
    }
}

module switch(type) {
    if (type == "cutout") {
        switchCutout();
    }
    if (type == "model") {
        //switchCutout();
        import("keycap-template.stl", convexity=3);
    }
}

module switchCutout() {
    translate([outWidth/2 - inWidth/2, outWidth/2 - inWidth/2, -11])
    cube([inWidth, inWidth, 5]);
}

//TODO: fix thumb row intersecting badly when angle >20
module switchArcPolygon(angle, posThickness, negThickness) {
    thickness = posThickness + negThickness;
    //original transformation matricies are in terms of the yz plane, need to do everything along xy plane here
    YZtoXY = yRotMatrix(-90);
    YZsquarePoints = [
        [0, 0, 0, 1],
        [0, 0, thickness, 1],
        [0, outWidth, thickness, 1],
        [0, outWidth, 0, 1]
    ];
    
    rowTransformationsOriginal = [keyRow1Trans, keyRow2Trans, keyRow3Trans, keyRow4Trans, keyRow5Trans];

    //each "switch" needs to be moved down y axis a bit and rotated to fit on xy plane
    rowTransformations = [ for (i = [0:4])
        YZtoXY * rowTransformationsOriginal[i] * translationMatrix(0, 0, -7.54 - posThickness)
    ];
    
    
    //generate the points for each square representing a switch space
    for ( i = [0:numColumns - 1] ) {
        trans = rowTransformations[i];
        points = transformPoints(YZsquarePoints, 4, trans);
        polygon(points = flattenPointArray(points, 4, 0, 1));
    }
    
    //fill in the spaces between 2 squares by creating a polygon with their relevant points
    for ( i = [0:numColumns - 2] ) {
        rowATrans = rowTransformations[i];
        rowBTrans = rowTransformations[i + 1];
        
        rowAPoints = transformPoints(YZsquarePoints, 4, rowATrans);
        rowBPoints = transformPoints(YZsquarePoints, 4, rowBTrans);
        
        points = [rowAPoints[0], rowAPoints[1], rowBPoints[2], rowBPoints[3]];
        polygon(points = flattenPointArray(points, 4, 0, 1));
    }
    
}

function flattenPointArray(points, length, i1, i2) = 
[ for (i = [0:length-1]) 
    [points[i][i1], points[i][i2]]
];
    
function transformPoints(points, length, matrix) = 
[ for (i = [0:length-1])
    matrix * points[i]
];

function xRotMatrix(angle) = [
    [1, 0, 0, 0],
    [0, cos(angle), -sin(angle), 0],
    [0, sin(angle), cos(angle), 0],
    [0, 0, 0, 1]
];

function yRotMatrix(angle) = [
    [cos(angle), 0, sin(angle), 0],
    [0, 1, 0, 0],
    [-sin(angle), 0, cos(angle), 0],
    [0, 0, 0, 1]
];

function zRotMatrix(angle) = [
    [cos(angle), -sin(angle), 0, 0],
    [sin(angle), cos(angle), 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];

function translationMatrix(tX, tY, tZ) = [
    [1, 0, 0, tX],
    [0, 1, 0, tY],
    [0, 0, 1, tZ],
    [0, 0, 0, 1]
];

function identityMatrix() = [
    [1, 0, 0, 0],
    [0, 1, 0, 0],
    [0, 0, 1, 0],
    [0, 0, 0, 1]
];


/*
module switchBase() {
    //import("keycap-template.stl", convexity=3);
    
    difference() {
    translate([0, 0, -7.7])
    cube([outWidth, outWidth, 0.817]);

    translate([outWidth/2 - inWidth/2, outWidth/2 - inWidth/2, -9])
    cube([inWidth, inWidth, 3]);
    }
}
*/