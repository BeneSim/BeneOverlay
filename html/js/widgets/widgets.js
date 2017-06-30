function setupWidgets(data_refs) {
    setupCallsign(data_refs);
    setupNetwork(data_refs);
    setupSpeed(data_refs);
    setupHeading(data_refs);
    setupAltitude(data_refs);
    setupWind(data_refs);
    setupTemperature(data_refs);
    setupPerformance(data_refs);

    attachToToggle($("#callsign"), data_refs["widget/callsign/enabled"]);
    attachToToggle($("#network"), data_refs["widget/network/enabled"]);
    attachToToggle($("#speed"), data_refs["widget/speed/enabled"]);
    attachToToggle($("#heading"), data_refs["widget/heading/enabled"]);
    attachToToggle($("#altitude"), data_refs["widget/altitude/enabled"]);
    attachToToggle($("#wind"), data_refs["widget/wind/enabled"]);
    attachToToggle($("#temperature"), data_refs["widget/temperature/enabled"]);
    attachToToggle($("#performance"), data_refs["widget/performance/enabled"]);
}
