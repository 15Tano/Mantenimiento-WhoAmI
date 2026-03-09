gdjs.Brain_32SaysCode = {};
gdjs.Brain_32SaysCode.localVariables = [];
gdjs.Brain_32SaysCode.GDSquaresObjects1= [];
gdjs.Brain_32SaysCode.GDSquaresObjects2= [];
gdjs.Brain_32SaysCode.GDSquaresObjects3= [];
gdjs.Brain_32SaysCode.GDSquaresObjects4= [];
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1= [];
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects2= [];
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects3= [];
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects4= [];


gdjs.Brain_32SaysCode.eventsList0 = function(runtimeScene) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(4).getAsNumber() > gdjs.evtTools.string.strLen(gdjs.evtTools.variable.getVariableString(runtimeScene.getScene().getVariables().getFromIndex(1))));
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(1).concatenateString(gdjs.evtTools.common.toString(gdjs.randomInRange(1, 4)));
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(4).getAsNumber() == gdjs.evtTools.string.strLen(gdjs.evtTools.variable.getVariableString(runtimeScene.getScene().getVariables().getFromIndex(1))));
}
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(0).getAsString() == "CPU_TURN");
}
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(2).getAsNumber() == 0);
}
}
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("MOSTRANDO_CPU");
}
{gdjs.evtTools.runtimeScene.resetTimer(runtimeScene, "ritmo");
}
}

}


};gdjs.Brain_32SaysCode.eventsList1 = function(runtimeScene) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.runtimeScene.getTimerElapsedTimeInSecondsOrNaN(runtimeScene, "ritmo") >= 1;
if (isConditionTrue_0) {
}

}


{

gdjs.copyArray(runtimeScene.getObjects("Squares"), gdjs.Brain_32SaysCode.GDSquaresObjects2);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(2).getAsNumber() < gdjs.evtTools.variable.getVariableNumber(runtimeScene.getScene().getVariables().getFromIndex(4)));
}
if (isConditionTrue_0) {
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.Brain_32SaysCode.GDSquaresObjects2.length;i<l;++i) {
    if ( gdjs.Brain_32SaysCode.GDSquaresObjects2[i].getVariableNumber(gdjs.Brain_32SaysCode.GDSquaresObjects2[i].getVariables().getFromIndex(0)) == gdjs.evtTools.common.toNumber(gdjs.evtTools.string.subStr(gdjs.evtTools.variable.getVariableString(runtimeScene.getScene().getVariables().getFromIndex(1)), gdjs.evtTools.variable.getVariableNumber(runtimeScene.getScene().getVariables().getFromIndex(2)), 1)) ) {
        isConditionTrue_0 = true;
        gdjs.Brain_32SaysCode.GDSquaresObjects2[k] = gdjs.Brain_32SaysCode.GDSquaresObjects2[i];
        ++k;
    }
}
gdjs.Brain_32SaysCode.GDSquaresObjects2.length = k;
}
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32SaysCode.GDSquaresObjects2 */
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDSquaresObjects2.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDSquaresObjects2[i].getBehavior("Animation").setAnimationName("square said");
}
}
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDSquaresObjects2.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDSquaresObjects2[i].resetTimer("ApagarCuadro");
}
}
{runtimeScene.getScene().getVariables().getFromIndex(2).add(1);
}
{gdjs.evtTools.runtimeScene.resetTimer(runtimeScene, "ritmo");
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(2).getAsNumber() >= gdjs.evtTools.variable.getVariableNumber(runtimeScene.getScene().getVariables().getFromIndex(4)));
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(2).setNumber(0);
}
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("PLAYER_TURN");
}
}

}


};gdjs.Brain_32SaysCode.mapOfGDgdjs_9546Brain_959532SaysCode_9546GDSquaresObjects1Objects = Hashtable.newFrom({"Squares": gdjs.Brain_32SaysCode.GDSquaresObjects1});
gdjs.Brain_32SaysCode.eventsList2 = function(runtimeScene) {

{

gdjs.copyArray(runtimeScene.getObjects("Squares"), gdjs.Brain_32SaysCode.GDSquaresObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.input.cursorOnObject(gdjs.Brain_32SaysCode.mapOfGDgdjs_9546Brain_959532SaysCode_9546GDSquaresObjects1Objects, runtimeScene, true, false);
if (isConditionTrue_0) {
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.input.isMouseButtonReleased(runtimeScene, "Left");
}
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32SaysCode.GDSquaresObjects1 */
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDSquaresObjects1.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDSquaresObjects1[i].getBehavior("Animation").setAnimationName("square said");
}
}
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDSquaresObjects1.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDSquaresObjects1[i].resetTimer("ApagarCuadro");
}
}
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "ClickID", (gdjs.RuntimeObject.getVariableNumber(((gdjs.Brain_32SaysCode.GDSquaresObjects1.length === 0 ) ? gdjs.VariablesContainer.badVariablesContainer : gdjs.Brain_32SaysCode.GDSquaresObjects1[0].getVariables()).getFromIndex(0))), null);
}
{gdjs.evtsExt__ExtendedVariables__ModifySceneVariable.func(runtimeScene, "ExpectedID", gdjs.evtTools.common.toNumber(gdjs.evtTools.string.subStr(gdjs.evtTools.variable.getVariableString(runtimeScene.getScene().getVariables().getFromIndex(1)), gdjs.evtTools.variable.getVariableNumber(runtimeScene.getScene().getVariables().getFromIndex(3)), 1)), null);
}
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("CHECKING");
}
}

}


};gdjs.Brain_32SaysCode.eventsList3 = function(runtimeScene) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(3).getAsNumber() < gdjs.evtTools.string.strLen(gdjs.evtTools.variable.getVariableString(runtimeScene.getScene().getVariables().getFromIndex(1))));
}
if (isConditionTrue_0) {
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(3).getAsNumber() == gdjs.evtTools.string.strLen(gdjs.evtTools.variable.getVariableString(runtimeScene.getScene().getVariables().getFromIndex(1))));
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(4).add(1);
}
{runtimeScene.getScene().getVariables().getFromIndex(3).setNumber(0);
}
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("CPU_TURN");
}
}

}


};gdjs.Brain_32SaysCode.eventsList4 = function(runtimeScene) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(5).getAsNumber() == gdjs.evtTools.variable.getVariableNumber(runtimeScene.getScene().getVariables().getFromIndex(6)));
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(3).add(1);
}
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("PLAYER_TURN");
}

{ //Subevents
gdjs.Brain_32SaysCode.eventsList3(runtimeScene);} //End of subevents
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(5).getAsNumber() != gdjs.evtTools.variable.getVariableNumber(runtimeScene.getScene().getVariables().getFromIndex(6)));
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("GAME_OVER");
}
}

}


};gdjs.Brain_32SaysCode.eventsList5 = function(runtimeScene) {

{



}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
isConditionTrue_0 = gdjs.evtTools.runtimeScene.sceneJustBegins(runtimeScene);
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(1).setString("");
}
{runtimeScene.getScene().getVariables().getFromIndex(4).setNumber(1);
}
{runtimeScene.getScene().getVariables().getFromIndex(0).setString("CPU_TURN");
}
}

}


{



}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(0).getAsString() == "CPU_TURN");
}
if (isConditionTrue_0) {
{runtimeScene.getScene().getVariables().getFromIndex(2).setNumber(0);
}
{gdjs.evtTools.runtimeScene.resetTimer(runtimeScene, "ritmo");
}

{ //Subevents
gdjs.Brain_32SaysCode.eventsList0(runtimeScene);} //End of subevents
}

}


{



}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(0).getAsString() == "MOSTRANDO_CPU");
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.Brain_32SaysCode.eventsList1(runtimeScene);} //End of subevents
}

}


{



}


{

gdjs.copyArray(runtimeScene.getObjects("Squares"), gdjs.Brain_32SaysCode.GDSquaresObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.Brain_32SaysCode.GDSquaresObjects1.length;i<l;++i) {
    if ( gdjs.Brain_32SaysCode.GDSquaresObjects1[i].getTimerElapsedTimeInSecondsOrNaN("ApagarCuadro") > 0.6 ) {
        isConditionTrue_0 = true;
        gdjs.Brain_32SaysCode.GDSquaresObjects1[k] = gdjs.Brain_32SaysCode.GDSquaresObjects1[i];
        ++k;
    }
}
gdjs.Brain_32SaysCode.GDSquaresObjects1.length = k;
if (isConditionTrue_0) {
/* Reuse gdjs.Brain_32SaysCode.GDSquaresObjects1 */
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDSquaresObjects1.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDSquaresObjects1[i].getBehavior("Animation").setAnimationName("square");
}
}
{gdjs.evtTools.runtimeScene.removeTimer(runtimeScene, "ApagarCuadro");
}
}

}


{



}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(0).getAsString() == "PLAYER_TURN");
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.Brain_32SaysCode.eventsList2(runtimeScene);} //End of subevents
}

}


{



}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(0).getAsString() == "CHECKING");
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.Brain_32SaysCode.eventsList4(runtimeScene);} //End of subevents
}

}


{



}


{


let isConditionTrue_0 = false;
{
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (runtimeScene.getScene().getVariables().getFromIndex(0).getAsString() == "GAME_OVER");
}
if (isConditionTrue_0) {
gdjs.copyArray(runtimeScene.getObjects("BlackBackground"), gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1);
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1[i].getBehavior("Opacity").setOpacity(0);
}
}
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1[i].getBehavior("Tween").addObjectOpacityTween2("FadeOut", 175, "linear", 1, false);
}
}
{gdjs.evtTools.camera.showLayer(runtimeScene, "UI");
}
{for(var i = 0, len = gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1.length ;i < len;++i) {
    gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1[i].getBehavior("Resizable").setSize(800, 1400);
}
}
}

}


{


let isConditionTrue_0 = false;
{
}

}


};

gdjs.Brain_32SaysCode.func = function(runtimeScene) {
runtimeScene.getOnceTriggers().startNewFrame();

gdjs.Brain_32SaysCode.GDSquaresObjects1.length = 0;
gdjs.Brain_32SaysCode.GDSquaresObjects2.length = 0;
gdjs.Brain_32SaysCode.GDSquaresObjects3.length = 0;
gdjs.Brain_32SaysCode.GDSquaresObjects4.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects2.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects3.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects4.length = 0;

gdjs.Brain_32SaysCode.eventsList5(runtimeScene);
gdjs.Brain_32SaysCode.GDSquaresObjects1.length = 0;
gdjs.Brain_32SaysCode.GDSquaresObjects2.length = 0;
gdjs.Brain_32SaysCode.GDSquaresObjects3.length = 0;
gdjs.Brain_32SaysCode.GDSquaresObjects4.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects1.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects2.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects3.length = 0;
gdjs.Brain_32SaysCode.GDBlackBackgroundObjects4.length = 0;


return;

}

gdjs['Brain_32SaysCode'] = gdjs.Brain_32SaysCode;
