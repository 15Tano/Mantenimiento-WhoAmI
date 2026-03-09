gdjs.Brain_32CrushCode = {};
gdjs.Brain_32CrushCode.localVariables = [];
gdjs.Brain_32CrushCode.forEachIndex3 = 0;

gdjs.Brain_32CrushCode.forEachObjects3 = [];

gdjs.Brain_32CrushCode.forEachTemporary3 = null;

gdjs.Brain_32CrushCode.forEachTotalCount3 = 0;

gdjs.Brain_32CrushCode.GDBrainObjects1= [];
gdjs.Brain_32CrushCode.GDBrainObjects2= [];
gdjs.Brain_32CrushCode.GDBrainObjects3= [];
gdjs.Brain_32CrushCode.GDBrainObjects4= [];
gdjs.Brain_32CrushCode.GDBrainObjects5= [];
gdjs.Brain_32CrushCode.GDCeldaObjects1= [];
gdjs.Brain_32CrushCode.GDCeldaObjects2= [];
gdjs.Brain_32CrushCode.GDCeldaObjects3= [];
gdjs.Brain_32CrushCode.GDCeldaObjects4= [];
gdjs.Brain_32CrushCode.GDCeldaObjects5= [];
gdjs.Brain_32CrushCode.GDPuntosObjects1= [];
gdjs.Brain_32CrushCode.GDPuntosObjects2= [];
gdjs.Brain_32CrushCode.GDPuntosObjects3= [];
gdjs.Brain_32CrushCode.GDPuntosObjects4= [];
gdjs.Brain_32CrushCode.GDPuntosObjects5= [];
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects1= [];
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects2= [];
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3= [];
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects4= [];
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects5= [];
gdjs.Brain_32CrushCode.GDScreenFadeObjects1= [];
gdjs.Brain_32CrushCode.GDScreenFadeObjects2= [];
gdjs.Brain_32CrushCode.GDScreenFadeObjects3= [];
gdjs.Brain_32CrushCode.GDScreenFadeObjects4= [];
gdjs.Brain_32CrushCode.GDScreenFadeObjects5= [];


gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDPositionPlaceholderObjects3Objects = Hashtable.newFrom({"PositionPlaceholder": gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3});
gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects3Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects3});
gdjs.Brain_32CrushCode.eventsList0 = function(runtimeScene) {

};gdjs.Brain_32CrushCode.eventsList1 = function(runtimeScene) {

{



}


{

gdjs.copyArray(runtimeScene.getObjects("PositionPlaceholder"), gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects2);

for (gdjs.Brain_32CrushCode.forEachIndex3 = 0;gdjs.Brain_32CrushCode.forEachIndex3 < gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects2.length;++gdjs.Brain_32CrushCode.forEachIndex3) {
gdjs.Brain_32CrushCode.GDBrainObjects3.length = 0;

gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.length = 0;


gdjs.Brain_32CrushCode.forEachTemporary3 = gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects2[gdjs.Brain_32CrushCode.forEachIndex3];
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.push(gdjs.Brain_32CrushCode.forEachTemporary3);
let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.object.pickRandomObject(runtimeScene, gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDPositionPlaceholderObjects3Objects);
if (isConditionTrue_0) {
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3[i].deleteFromScene(runtimeScene);
}
}
{gdjs.evtTools.object.createObjectOnScene(runtimeScene, gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects3Objects, (( gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.length === 0 ) ? 0 :gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3[0].getPointX("")), (( gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.length === 0 ) ? 0 :gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3[0].getPointY("")), "");
}
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDBrainObjects3.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDBrainObjects3[i].getBehavior("Animation").setAnimationIndex(gdjs.randomInRange(0, 3));
}
}
}
}

}


{


let isConditionTrue_0 = false;
{
{runtimeScene.getScene().getVariables().getFromIndex(8).setString("EsperandoSeleccion");
}
}

}


};gdjs.Brain_32CrushCode.eventsList2 = function(runtimeScene) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.runtimeScene.sceneJustBegins(runtimeScene);
if (isConditionTrue_0) {
gdjs.copyArray(runtimeScene.getObjects("ScreenFade"), gdjs.Brain_32CrushCode.GDScreenFadeObjects1);
{gdjs.evtTools.camera.showLayer(runtimeScene, "Fade");
}
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDScreenFadeObjects1.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDScreenFadeObjects1[i].getBehavior("Tween").addObjectOpacityTween2("FadeIn", 0, "linear", 1, true);
}
}

{ //Subevents
gdjs.Brain_32CrushCode.eventsList1(runtimeScene);} //End of subevents
}

}


};gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects1});
gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects1});
gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects1});
gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects2Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects2});
gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects2Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects2});
gdjs.Brain_32CrushCode.eventsList3 = function(runtimeScene, asyncObjectsList) {

{

gdjs.copyArray(asyncObjectsList.getObjects("Brain"), gdjs.Brain_32CrushCode.GDBrainObjects4);


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.Brain_32CrushCode.GDBrainObjects4.length;i<l;++i) {
    if ( gdjs.Brain_32CrushCode.GDBrainObjects4[i].getVariableNumber(gdjs.Brain_32CrushCode.GDBrainObjects4[i].getVariables().getFromIndex(0)) == 1 ) {
        isConditionTrue_0 = true;
        gdjs.Brain_32CrushCode.GDBrainObjects4[k] = gdjs.Brain_32CrushCode.GDBrainObjects4[i];
        ++k;
    }
}
gdjs.Brain_32CrushCode.GDBrainObjects4.length = k;
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32CrushCode.GDBrainObjects4 */
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDBrainObjects4.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDBrainObjects4[i].getBehavior("Tween").addObjectPositionTween2("Variable(Seleccion) = 1", runtimeScene.getScene().getVariables().getFromIndex(6).getAsNumber(), runtimeScene.getScene().getVariables().getFromIndex(7).getAsNumber(), "linear", 0.2, false);
}
}
}

}


{

gdjs.copyArray(asyncObjectsList.getObjects("Brain"), gdjs.Brain_32CrushCode.GDBrainObjects3);


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.Brain_32CrushCode.GDBrainObjects3.length;i<l;++i) {
    if ( gdjs.Brain_32CrushCode.GDBrainObjects3[i].getVariableNumber(gdjs.Brain_32CrushCode.GDBrainObjects3[i].getVariables().getFromIndex(0)) == 0 ) {
        isConditionTrue_0 = true;
        gdjs.Brain_32CrushCode.GDBrainObjects3[k] = gdjs.Brain_32CrushCode.GDBrainObjects3[i];
        ++k;
    }
}
gdjs.Brain_32CrushCode.GDBrainObjects3.length = k;
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32CrushCode.GDBrainObjects3 */
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDBrainObjects3.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDBrainObjects3[i].getBehavior("Tween").addObjectPositionTween2("Variable(Seleccion) = 0", runtimeScene.getScene().getVariables().getFromIndex(4).getAsNumber(), runtimeScene.getScene().getVariables().getFromIndex(5).getAsNumber(), "linear", 0.2, false);
}
}
}

}


};gdjs.Brain_32CrushCode.asyncCallback13307900 = function (runtimeScene, asyncObjectsList) {
asyncObjectsList.restoreLocalVariablesContainers(gdjs.Brain_32CrushCode.localVariables);
{runtimeScene.getScene().getVariables().getFromIndex(8).setString("VerificarCoincidencias");
}

{ //Subevents
gdjs.Brain_32CrushCode.eventsList3(runtimeScene, asyncObjectsList);} //End of subevents
gdjs.Brain_32CrushCode.localVariables.length = 0;
}
gdjs.Brain_32CrushCode.eventsList4 = function(runtimeScene) {

{


{
{
const asyncObjectsList = new gdjs.LongLivedObjectsList();
asyncObjectsList.backupLocalVariablesContainers(gdjs.Brain_32CrushCode.localVariables);
for (const obj of gdjs.Brain_32CrushCode.GDBrainObjects2) asyncObjectsList.addObject("Brain", obj);
runtimeScene.getAsyncTasksManager().addTask(gdjs.evtTools.runtimeScene.wait(0.3), (runtimeScene) => (gdjs.Brain_32CrushCode.asyncCallback13307900(runtimeScene, asyncObjectsList)));
}
}

}


};gdjs.Brain_32CrushCode.eventsList5 = function(runtimeScene) {

{

gdjs.copyArray(gdjs.Brain_32CrushCode.GDBrainObjects1, gdjs.Brain_32CrushCode.GDBrainObjects2);


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.object.distanceTest(gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects2Objects, gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects2Objects, 104 * 1.5, false);
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32CrushCode.GDBrainObjects2 */
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "x2", (( gdjs.Brain_32CrushCode.GDBrainObjects2.length === 0 ) ? 0 :gdjs.Brain_32CrushCode.GDBrainObjects2[0].getPointX("")), null);
}
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "y2", (( gdjs.Brain_32CrushCode.GDBrainObjects2.length === 0 ) ? 0 :gdjs.Brain_32CrushCode.GDBrainObjects2[0].getPointY("")), null);
}

{ //Subevents
gdjs.Brain_32CrushCode.eventsList4(runtimeScene);} //End of subevents
}

}


{


let isConditionTrue_0 = false;
{
/* Reuse gdjs.Brain_32CrushCode.GDBrainObjects1 */
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDBrainObjects1.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDBrainObjects1[i].returnVariable(gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariables().getFromIndex(0)).setNumber(0);
}
}
{runtimeScene.getScene().getVariables().getFromIndex(3).setNumber(0);
}
}

}


};gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects = Hashtable.newFrom({"Brain": gdjs.Brain_32CrushCode.GDBrainObjects1});
gdjs.Brain_32CrushCode.eventsList6 = function(runtimeScene) {

{


gdjs.Brain_32CrushCode.eventsList2(runtimeScene);
}


{


let isConditionTrue_0 = false;
{
}

}


{


let isConditionTrue_0 = false;
{
}

}


{

gdjs.copyArray(runtimeScene.getObjects("Brain"), gdjs.Brain_32CrushCode.GDBrainObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.input.cursorOnObject(gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects, runtimeScene, true, false);
if (isConditionTrue_0) {
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.Brain_32CrushCode.GDBrainObjects1.length;i<l;++i) {
    if ( gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariableNumber(gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariables().getFromIndex(0)) == 1 ) {
        isConditionTrue_0 = true;
        gdjs.Brain_32CrushCode.GDBrainObjects1[k] = gdjs.Brain_32CrushCode.GDBrainObjects1[i];
        ++k;
    }
}
gdjs.Brain_32CrushCode.GDBrainObjects1.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(3).getAsNumber() == 1);
}
}
}
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32CrushCode.GDBrainObjects1 */
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDBrainObjects1.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDBrainObjects1[i].returnVariable(gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariables().getFromIndex(0)).setNumber(0);
}
}
{runtimeScene.getScene().getVariables().getFromIndex(3).setNumber(0);
}
}

}


{


let isConditionTrue_0 = false;
{
}

}


{


let isConditionTrue_0 = false;
{
}

}


{

gdjs.copyArray(runtimeScene.getObjects("Brain"), gdjs.Brain_32CrushCode.GDBrainObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.input.cursorOnObject(gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects, runtimeScene, true, false);
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(3).getAsNumber() == 0);
}
}
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32CrushCode.GDBrainObjects1 */
{for(var i = 0, len = gdjs.Brain_32CrushCode.GDBrainObjects1.length ;i < len;++i) {
    gdjs.Brain_32CrushCode.GDBrainObjects1[i].returnVariable(gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariables().getFromIndex(0)).setNumber(1);
}
}
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "x1", (( gdjs.Brain_32CrushCode.GDBrainObjects1.length === 0 ) ? 0 :gdjs.Brain_32CrushCode.GDBrainObjects1[0].getPointX("")), null);
}
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "y1", (( gdjs.Brain_32CrushCode.GDBrainObjects1.length === 0 ) ? 0 :gdjs.Brain_32CrushCode.GDBrainObjects1[0].getPointY("")), null);
}
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "seleccionado", 1, null);
}
}

}


{


let isConditionTrue_0 = false;
{
}

}


{


let isConditionTrue_0 = false;
{
}

}


{

gdjs.copyArray(runtimeScene.getObjects("Brain"), gdjs.Brain_32CrushCode.GDBrainObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.input.cursorOnObject(gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects, runtimeScene, true, false);
if (isConditionTrue_0) {
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.Brain_32CrushCode.GDBrainObjects1.length;i<l;++i) {
    if ( gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariableNumber(gdjs.Brain_32CrushCode.GDBrainObjects1[i].getVariables().getFromIndex(0)) == 0 ) {
        isConditionTrue_0 = true;
        gdjs.Brain_32CrushCode.GDBrainObjects1[k] = gdjs.Brain_32CrushCode.GDBrainObjects1[i];
        ++k;
    }
}
gdjs.Brain_32CrushCode.GDBrainObjects1.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(3).getAsNumber() == 1);
}
}
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.Brain_32CrushCode.eventsList5(runtimeScene);} //End of subevents
}

}


{


let isConditionTrue_0 = false;
{
}

}


{


let isConditionTrue_0 = false;
{
}

}


{

gdjs.copyArray(runtimeScene.getObjects("Brain"), gdjs.Brain_32CrushCode.GDBrainObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.input.cursorOnObject(gdjs.Brain_32CrushCode.mapOfGDgdjs_9546Brain_959532CrushCode_9546GDBrainObjects1Objects, runtimeScene, true, false);
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(3).getAsNumber() == 1);
}
}
if (isConditionTrue_0) {
}

}


};

gdjs.Brain_32CrushCode.func = function(runtimeScene) {
runtimeScene.getOnceTriggers().startNewFrame();

gdjs.Brain_32CrushCode.GDBrainObjects1.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects2.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects3.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects4.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects5.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects1.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects2.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects3.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects4.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects5.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects1.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects2.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects3.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects4.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects5.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects1.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects2.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects4.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects5.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects1.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects2.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects3.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects4.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects5.length = 0;

gdjs.Brain_32CrushCode.eventsList6(runtimeScene);
gdjs.Brain_32CrushCode.GDBrainObjects1.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects2.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects3.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects4.length = 0;
gdjs.Brain_32CrushCode.GDBrainObjects5.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects1.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects2.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects3.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects4.length = 0;
gdjs.Brain_32CrushCode.GDCeldaObjects5.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects1.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects2.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects3.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects4.length = 0;
gdjs.Brain_32CrushCode.GDPuntosObjects5.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects1.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects2.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects3.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects4.length = 0;
gdjs.Brain_32CrushCode.GDPositionPlaceholderObjects5.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects1.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects2.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects3.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects4.length = 0;
gdjs.Brain_32CrushCode.GDScreenFadeObjects5.length = 0;


return;

}

gdjs['Brain_32CrushCode'] = gdjs.Brain_32CrushCode;
