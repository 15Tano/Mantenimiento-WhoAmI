
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween || {};

/**
 * Behavior generated from Button object effect tween
 */
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween = class ButtonObjectEffectTween extends gdjs.RuntimeBehavior {
  constructor(instanceContainer, behaviorData, owner) {
    super(instanceContainer, behaviorData, owner);
    this._runtimeScene = instanceContainer;

    this._onceTriggers = new gdjs.OnceTriggers();
    this._behaviorData = {};
    this._sharedData = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.getSharedData(
      instanceContainer,
      behaviorData.name
    );
    
    this._behaviorData.ButtonFSM = behaviorData.ButtonFSM !== undefined ? behaviorData.ButtonFSM : "";
    this._behaviorData.Effect = behaviorData.Effect !== undefined ? behaviorData.Effect : "";
    this._behaviorData.EffectName = behaviorData.EffectName !== undefined ? behaviorData.EffectName : "Effect";
    this._behaviorData.EffectProperty = behaviorData.EffectProperty !== undefined ? behaviorData.EffectProperty : "";
    this._behaviorData.IdleValue = behaviorData.IdleValue !== undefined ? behaviorData.IdleValue : Number("0") || 0;
    this._behaviorData.FocusedValue = behaviorData.FocusedValue !== undefined ? behaviorData.FocusedValue : Number("0") || 0;
    this._behaviorData.PressedValue = behaviorData.PressedValue !== undefined ? behaviorData.PressedValue : Number("0") || 0;
    this._behaviorData.FadeInEasing = behaviorData.FadeInEasing !== undefined ? behaviorData.FadeInEasing : "easeInOutQuad";
    this._behaviorData.FadeOutEasing = behaviorData.FadeOutEasing !== undefined ? behaviorData.FadeOutEasing : "easeInOutQuad";
    this._behaviorData.FadeInDuration = behaviorData.FadeInDuration !== undefined ? behaviorData.FadeInDuration : Number("0.125") || 0;
    this._behaviorData.FadeOutDuration = behaviorData.FadeOutDuration !== undefined ? behaviorData.FadeOutDuration : Number("0.5") || 0;
    this._behaviorData.PreviousState = "Idle";
    this._behaviorData.TweenInitialValue = Number("0") || 0;
    this._behaviorData.TweenTargetedValue = Number("0") || 0;
    this._behaviorData.TweenTime = Number("0") || 0;
    this._behaviorData.TweenState = "NoTween";
    this._behaviorData.EffectValue = Number("0") || 0;
  }

  // Hot-reload:
  updateFromBehaviorData(oldBehaviorData, newBehaviorData) {
    
    if (oldBehaviorData.ButtonFSM !== newBehaviorData.ButtonFSM)
      this._behaviorData.ButtonFSM = newBehaviorData.ButtonFSM;
    if (oldBehaviorData.Effect !== newBehaviorData.Effect)
      this._behaviorData.Effect = newBehaviorData.Effect;
    if (oldBehaviorData.EffectName !== newBehaviorData.EffectName)
      this._behaviorData.EffectName = newBehaviorData.EffectName;
    if (oldBehaviorData.EffectProperty !== newBehaviorData.EffectProperty)
      this._behaviorData.EffectProperty = newBehaviorData.EffectProperty;
    if (oldBehaviorData.IdleValue !== newBehaviorData.IdleValue)
      this._behaviorData.IdleValue = newBehaviorData.IdleValue;
    if (oldBehaviorData.FocusedValue !== newBehaviorData.FocusedValue)
      this._behaviorData.FocusedValue = newBehaviorData.FocusedValue;
    if (oldBehaviorData.PressedValue !== newBehaviorData.PressedValue)
      this._behaviorData.PressedValue = newBehaviorData.PressedValue;
    if (oldBehaviorData.FadeInEasing !== newBehaviorData.FadeInEasing)
      this._behaviorData.FadeInEasing = newBehaviorData.FadeInEasing;
    if (oldBehaviorData.FadeOutEasing !== newBehaviorData.FadeOutEasing)
      this._behaviorData.FadeOutEasing = newBehaviorData.FadeOutEasing;
    if (oldBehaviorData.FadeInDuration !== newBehaviorData.FadeInDuration)
      this._behaviorData.FadeInDuration = newBehaviorData.FadeInDuration;
    if (oldBehaviorData.FadeOutDuration !== newBehaviorData.FadeOutDuration)
      this._behaviorData.FadeOutDuration = newBehaviorData.FadeOutDuration;
    if (oldBehaviorData.PreviousState !== newBehaviorData.PreviousState)
      this._behaviorData.PreviousState = newBehaviorData.PreviousState;
    if (oldBehaviorData.TweenInitialValue !== newBehaviorData.TweenInitialValue)
      this._behaviorData.TweenInitialValue = newBehaviorData.TweenInitialValue;
    if (oldBehaviorData.TweenTargetedValue !== newBehaviorData.TweenTargetedValue)
      this._behaviorData.TweenTargetedValue = newBehaviorData.TweenTargetedValue;
    if (oldBehaviorData.TweenTime !== newBehaviorData.TweenTime)
      this._behaviorData.TweenTime = newBehaviorData.TweenTime;
    if (oldBehaviorData.TweenState !== newBehaviorData.TweenState)
      this._behaviorData.TweenState = newBehaviorData.TweenState;
    if (oldBehaviorData.EffectValue !== newBehaviorData.EffectValue)
      this._behaviorData.EffectValue = newBehaviorData.EffectValue;

    return true;
  }

  // Network sync:
  getNetworkSyncData() {
    return {
      ...super.getNetworkSyncData(),
      props: {
        
    ButtonFSM: this._behaviorData.ButtonFSM,
    Effect: this._behaviorData.Effect,
    EffectName: this._behaviorData.EffectName,
    EffectProperty: this._behaviorData.EffectProperty,
    IdleValue: this._behaviorData.IdleValue,
    FocusedValue: this._behaviorData.FocusedValue,
    PressedValue: this._behaviorData.PressedValue,
    FadeInEasing: this._behaviorData.FadeInEasing,
    FadeOutEasing: this._behaviorData.FadeOutEasing,
    FadeInDuration: this._behaviorData.FadeInDuration,
    FadeOutDuration: this._behaviorData.FadeOutDuration,
    PreviousState: this._behaviorData.PreviousState,
    TweenInitialValue: this._behaviorData.TweenInitialValue,
    TweenTargetedValue: this._behaviorData.TweenTargetedValue,
    TweenTime: this._behaviorData.TweenTime,
    TweenState: this._behaviorData.TweenState,
    EffectValue: this._behaviorData.EffectValue,
      }
    };
  }
  updateFromNetworkSyncData(networkSyncData) {
    super.updateFromNetworkSyncData(networkSyncData);
    
    if (networkSyncData.props.ButtonFSM !== undefined)
      this._behaviorData.ButtonFSM = networkSyncData.props.ButtonFSM;
    if (networkSyncData.props.Effect !== undefined)
      this._behaviorData.Effect = networkSyncData.props.Effect;
    if (networkSyncData.props.EffectName !== undefined)
      this._behaviorData.EffectName = networkSyncData.props.EffectName;
    if (networkSyncData.props.EffectProperty !== undefined)
      this._behaviorData.EffectProperty = networkSyncData.props.EffectProperty;
    if (networkSyncData.props.IdleValue !== undefined)
      this._behaviorData.IdleValue = networkSyncData.props.IdleValue;
    if (networkSyncData.props.FocusedValue !== undefined)
      this._behaviorData.FocusedValue = networkSyncData.props.FocusedValue;
    if (networkSyncData.props.PressedValue !== undefined)
      this._behaviorData.PressedValue = networkSyncData.props.PressedValue;
    if (networkSyncData.props.FadeInEasing !== undefined)
      this._behaviorData.FadeInEasing = networkSyncData.props.FadeInEasing;
    if (networkSyncData.props.FadeOutEasing !== undefined)
      this._behaviorData.FadeOutEasing = networkSyncData.props.FadeOutEasing;
    if (networkSyncData.props.FadeInDuration !== undefined)
      this._behaviorData.FadeInDuration = networkSyncData.props.FadeInDuration;
    if (networkSyncData.props.FadeOutDuration !== undefined)
      this._behaviorData.FadeOutDuration = networkSyncData.props.FadeOutDuration;
    if (networkSyncData.props.PreviousState !== undefined)
      this._behaviorData.PreviousState = networkSyncData.props.PreviousState;
    if (networkSyncData.props.TweenInitialValue !== undefined)
      this._behaviorData.TweenInitialValue = networkSyncData.props.TweenInitialValue;
    if (networkSyncData.props.TweenTargetedValue !== undefined)
      this._behaviorData.TweenTargetedValue = networkSyncData.props.TweenTargetedValue;
    if (networkSyncData.props.TweenTime !== undefined)
      this._behaviorData.TweenTime = networkSyncData.props.TweenTime;
    if (networkSyncData.props.TweenState !== undefined)
      this._behaviorData.TweenState = networkSyncData.props.TweenState;
    if (networkSyncData.props.EffectValue !== undefined)
      this._behaviorData.EffectValue = networkSyncData.props.EffectValue;
  }

  // Properties:
  
  _getButtonFSM() {
    return this._behaviorData.ButtonFSM !== undefined ? this._behaviorData.ButtonFSM : "";
  }
  _setButtonFSM(newValue) {
    this._behaviorData.ButtonFSM = newValue;
  }
  _getEffect() {
    return this._behaviorData.Effect !== undefined ? this._behaviorData.Effect : "";
  }
  _setEffect(newValue) {
    this._behaviorData.Effect = newValue;
  }
  _getEffectName() {
    return this._behaviorData.EffectName !== undefined ? this._behaviorData.EffectName : "Effect";
  }
  _setEffectName(newValue) {
    this._behaviorData.EffectName = newValue;
  }
  _getEffectProperty() {
    return this._behaviorData.EffectProperty !== undefined ? this._behaviorData.EffectProperty : "";
  }
  _setEffectProperty(newValue) {
    this._behaviorData.EffectProperty = newValue;
  }
  _getIdleValue() {
    return this._behaviorData.IdleValue !== undefined ? this._behaviorData.IdleValue : Number("0") || 0;
  }
  _setIdleValue(newValue) {
    this._behaviorData.IdleValue = newValue;
  }
  _getFocusedValue() {
    return this._behaviorData.FocusedValue !== undefined ? this._behaviorData.FocusedValue : Number("0") || 0;
  }
  _setFocusedValue(newValue) {
    this._behaviorData.FocusedValue = newValue;
  }
  _getPressedValue() {
    return this._behaviorData.PressedValue !== undefined ? this._behaviorData.PressedValue : Number("0") || 0;
  }
  _setPressedValue(newValue) {
    this._behaviorData.PressedValue = newValue;
  }
  _getFadeInEasing() {
    return this._behaviorData.FadeInEasing !== undefined ? this._behaviorData.FadeInEasing : "easeInOutQuad";
  }
  _setFadeInEasing(newValue) {
    this._behaviorData.FadeInEasing = newValue;
  }
  _getFadeOutEasing() {
    return this._behaviorData.FadeOutEasing !== undefined ? this._behaviorData.FadeOutEasing : "easeInOutQuad";
  }
  _setFadeOutEasing(newValue) {
    this._behaviorData.FadeOutEasing = newValue;
  }
  _getFadeInDuration() {
    return this._behaviorData.FadeInDuration !== undefined ? this._behaviorData.FadeInDuration : Number("0.125") || 0;
  }
  _setFadeInDuration(newValue) {
    this._behaviorData.FadeInDuration = newValue;
  }
  _getFadeOutDuration() {
    return this._behaviorData.FadeOutDuration !== undefined ? this._behaviorData.FadeOutDuration : Number("0.5") || 0;
  }
  _setFadeOutDuration(newValue) {
    this._behaviorData.FadeOutDuration = newValue;
  }
  _getPreviousState() {
    return this._behaviorData.PreviousState !== undefined ? this._behaviorData.PreviousState : "Idle";
  }
  _setPreviousState(newValue) {
    this._behaviorData.PreviousState = newValue;
  }
  _getTweenInitialValue() {
    return this._behaviorData.TweenInitialValue !== undefined ? this._behaviorData.TweenInitialValue : Number("0") || 0;
  }
  _setTweenInitialValue(newValue) {
    this._behaviorData.TweenInitialValue = newValue;
  }
  _getTweenTargetedValue() {
    return this._behaviorData.TweenTargetedValue !== undefined ? this._behaviorData.TweenTargetedValue : Number("0") || 0;
  }
  _setTweenTargetedValue(newValue) {
    this._behaviorData.TweenTargetedValue = newValue;
  }
  _getTweenTime() {
    return this._behaviorData.TweenTime !== undefined ? this._behaviorData.TweenTime : Number("0") || 0;
  }
  _setTweenTime(newValue) {
    this._behaviorData.TweenTime = newValue;
  }
  _getTweenState() {
    return this._behaviorData.TweenState !== undefined ? this._behaviorData.TweenState : "NoTween";
  }
  _setTweenState(newValue) {
    this._behaviorData.TweenState = newValue;
  }
  _getEffectValue() {
    return this._behaviorData.EffectValue !== undefined ? this._behaviorData.EffectValue : Number("0") || 0;
  }
  _setEffectValue(newValue) {
    this._behaviorData.EffectValue = newValue;
  }
}

/**
 * Shared data generated from Button object effect tween
 */
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.SharedData = class ButtonObjectEffectTweenSharedData {
  constructor(sharedData) {
    
  }
  
  // Shared properties:
  
}

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.getSharedData = function(instanceContainer, behaviorName) {
  if (!instanceContainer._ButtonStates_ButtonObjectEffectTweenSharedData) {
    const initialData = instanceContainer.getInitialSharedDataForBehavior(
      behaviorName
    );
    instanceContainer._ButtonStates_ButtonObjectEffectTweenSharedData = new gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.SharedData(
      initialData
    );
  }
  return instanceContainer._ButtonStates_ButtonObjectEffectTweenSharedData;
}

// Methods:
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setEffectValue(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIdleValue())
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreated = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.onCreatedContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects3= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects4= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getPreviousState() == "Idle");
}
if (isConditionTrue_0) {
gdjs.copyArray(gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2, gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects3);

{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setPreviousState("Focused")
}
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects3.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects3[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FadeIn(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFocusedValue(), eventsFunctionContext);
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getPreviousState() == "Pressed");
}
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2 */
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setPreviousState("Focused")
}
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FadeOut(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFocusedValue(), eventsFunctionContext);
}
}
}

}


};gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList1 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length;i<l;++i) {
    if ( gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("ButtonFSM")).IsIdle(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[k] = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i];
        ++k;
    }
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getPreviousState() != "Idle");
}
}
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2 */
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setPreviousState("Idle")
}
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FadeOut(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIdleValue(), eventsFunctionContext);
}
}
}

}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length;i<l;++i) {
    if ( gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("ButtonFSM")).IsFocused(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[k] = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i];
        ++k;
    }
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length = k;
if (isConditionTrue_0) {

{ //Subevents
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList0(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("ButtonFSM")).IsPressed(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1[k] = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getPreviousState() != "Pressed");
}
}
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1 */
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setPreviousState("Pressed")
}
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FadeIn(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getPressedValue(), eventsFunctionContext);
}
}
}

}


};gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList2 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenState() == "FadeIn");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2);
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).PlayTween(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeInDuration(), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeInEasing(), eventsFunctionContext);
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenState() == "FadeOut");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).PlayTween(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeOutDuration(), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeOutEasing(), eventsFunctionContext);
}
}
}

}


};gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList3 = function(runtimeScene, eventsFunctionContext) {

{


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList1(runtimeScene, eventsFunctionContext);
}


{


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList2(runtimeScene, eventsFunctionContext);
}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEvents = function(parentEventsFunctionContext) {
this._onceTriggers.startNewFrame();
var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects3.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects4.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.eventsList3(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects3.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.doStepPreEventsContext.GDObjectObjects4.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects1);
{eventsFunctionContext.returnValue = gdjs.evtTools.runtimeScene.getElapsedTimeInSeconds(runtimeScene) * gdjs.evtTools.camera.getLayerTimeScale(runtimeScene, (( gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects1.length === 0 ) ? "" :gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects1[0].getLayer()));}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDelta = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.TimeDeltaContext.GDObjectObjects2.length = 0;


return Number(eventsFunctionContext.returnValue) || 0;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenTime(0)
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenState("FadeIn")
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenInitialValue(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectValue())
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenTargetedValue(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeIn = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenTime(0)
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenState("FadeOut")
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenInitialValue(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectValue())
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenTargetedValue(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOut = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenTime() < eventsFunctionContext.getArgument("Duration"));
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1);
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenTime(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenTime()+(( gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1.length === 0 ) ? 0 :gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).TimeDelta(eventsFunctionContext)))
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setEffectValue(gdjs.evtTools.tween.ease(eventsFunctionContext.getArgument("Easing"), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenInitialValue(), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenTargetedValue(), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenTime() / eventsFunctionContext.getArgument("Duration")))
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenTime() >= eventsFunctionContext.getArgument("Duration"));
}
if (isConditionTrue_0) {
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setTweenState("NoTween")
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setEffectValue(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getTweenTargetedValue())
}
}

}


{


let isConditionTrue_0 = false;
{
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Effect")).setEffectDoubleParameter(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectName(), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectProperty(), eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectValue());
}
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTween = function(Duration, Easing, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Duration") return Duration;
if (argName === "Easing") return Easing;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PlayTweenContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectName();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectName = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectNameContext.GDObjectObjects2.length = 0;


return "" + eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getEffectProperty();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectProperty = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.EffectPropertyContext.GDObjectObjects2.length = 0;


return "" + eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setEffectName(eventsFunctionContext.getArgument("NewEffectName"))
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setEffectProperty(eventsFunctionContext.getArgument("NewPropertyName"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectProperty = function(NewEffectName, NewPropertyName, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "NewEffectName") return NewEffectName;
if (argName === "NewPropertyName") return NewPropertyName;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetEffectPropertyContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIdleValue();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValue = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.IdleValueContext.GDObjectObjects2.length = 0;


return Number(eventsFunctionContext.returnValue) || 0;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setIdleValue(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValue = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetIdleValueContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFocusedValue();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValue = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FocusedValueContext.GDObjectObjects2.length = 0;


return Number(eventsFunctionContext.returnValue) || 0;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setFocusedValue(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValue = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFocusedValueContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getPressedValue();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValue = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.PressedValueContext.GDObjectObjects2.length = 0;


return Number(eventsFunctionContext.returnValue) || 0;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setPressedValue(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValue = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetPressedValueContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeInEasing();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasing = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInEasingContext.GDObjectObjects2.length = 0;


return "" + eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setFadeInEasing(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasing = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInEasingContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeOutEasing();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasing = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutEasingContext.GDObjectObjects2.length = 0;


return "" + eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setFadeOutEasing(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasing = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutEasingContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeInDuration();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDuration = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeInDurationContext.GDObjectObjects2.length = 0;


return Number(eventsFunctionContext.returnValue) || 0;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setFadeInDuration(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDuration = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeInDurationContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.returnValue = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFadeOutDuration();}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDuration = function(parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.FadeOutDurationContext.GDObjectObjects2.length = 0;


return Number(eventsFunctionContext.returnValue) || 0;
}
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext = {};
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.GDObjectObjects1= [];
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.GDObjectObjects2= [];


gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setFadeOutDuration(eventsFunctionContext.getArgument("Value"))
}
}

}


};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDuration = function(Value, parentEventsFunctionContext) {

var that = this;
var runtimeScene = this._runtimeScene;
let scopeInstanceContainer = null;
var thisObjectList = [this.owner];
var Object = Hashtable.newFrom({Object: thisObjectList});
var Behavior = this.name;
var eventsFunctionContext = {
  _objectsMap: {
"Object": Object
},
  _objectArraysMap: {
"Object": thisObjectList
},
  _behaviorNamesMap: {
"Behavior": Behavior
, "ButtonFSM": this._getButtonFSM()
, "Effect": this._getEffect()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ButtonStates"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ButtonStates"),
  localVariables: [],
  getObjects: function(objectName) {
    return eventsFunctionContext._objectArraysMap[objectName] || [];
  },
  getObjectsLists: function(objectName) {
    return eventsFunctionContext._objectsMap[objectName] || null;
  },
  getBehaviorName: function(behaviorName) {
    return eventsFunctionContext._behaviorNamesMap[behaviorName] || behaviorName;
  },
  createObject: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    if (objectsList) {
      const object = parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
        parentEventsFunctionContext.createObject(objectsList.firstKey()) :
        runtimeScene.createObject(objectsList.firstKey());
      if (object) {
        objectsList.get(objectsList.firstKey()).push(object);
        eventsFunctionContext._objectArraysMap[objectName].push(object);
      }
      return object;
    }
    return null;
  },
  getInstancesCountOnScene: function(objectName) {
    const objectsList = eventsFunctionContext._objectsMap[objectName];
    let count = 0;
    if (objectsList) {
      for(const objectName in objectsList.items)
        count += parentEventsFunctionContext && !(scopeInstanceContainer && scopeInstanceContainer.isObjectRegistered(objectName)) ?
parentEventsFunctionContext.getInstancesCountOnScene(objectName) :
        runtimeScene.getInstancesCountOnScene(objectName);
    }
    return count;
  },
  getLayer: function(layerName) {
    return runtimeScene.getLayer(layerName);
  },
  getArgument: function(argName) {
if (argName === "Value") return Value;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween.prototype.SetFadeOutDurationContext.GDObjectObjects2.length = 0;


return;
}


gdjs.registerBehavior("ButtonStates::ButtonObjectEffectTween", gdjs.evtsExt__ButtonStates__ButtonObjectEffectTween.ButtonObjectEffectTween);
