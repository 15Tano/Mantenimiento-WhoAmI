
gdjs.evtsExt__ThreeDFlip__ThreeDFlip = gdjs.evtsExt__ThreeDFlip__ThreeDFlip || {};

/**
 * Behavior generated from 3D Flip
 */
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip = class ThreeDFlip extends gdjs.RuntimeBehavior {
  constructor(instanceContainer, behaviorData, owner) {
    super(instanceContainer, behaviorData, owner);
    this._runtimeScene = instanceContainer;

    this._onceTriggers = new gdjs.OnceTriggers();
    this._behaviorData = {};
    this._sharedData = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.getSharedData(
      instanceContainer,
      behaviorData.name
    );
    
    this._behaviorData.Resizable = behaviorData.Resizable !== undefined ? behaviorData.Resizable : "";
    this._behaviorData.Flippable = behaviorData.Flippable !== undefined ? behaviorData.Flippable : "";
    this._behaviorData.Animation = behaviorData.Animation !== undefined ? behaviorData.Animation : "";
    this._behaviorData.FlippingMethod = behaviorData.FlippingMethod !== undefined ? behaviorData.FlippingMethod : "Mirror";
    this._behaviorData.FrontAnimation = behaviorData.FrontAnimation !== undefined ? behaviorData.FrontAnimation : "Front";
    this._behaviorData.BackAnimation = behaviorData.BackAnimation !== undefined ? behaviorData.BackAnimation : "Back";
    this._behaviorData.Duration = Number("0") || 0;
    this._behaviorData.IsFlipped = false;
    this._behaviorData.Width = Number("0") || 0;
    this._behaviorData.ElapsedTime = Number("0") || 0;
    this._behaviorData.Toggle = false;
  }

  // Hot-reload:
  updateFromBehaviorData(oldBehaviorData, newBehaviorData) {
    
    if (oldBehaviorData.Resizable !== newBehaviorData.Resizable)
      this._behaviorData.Resizable = newBehaviorData.Resizable;
    if (oldBehaviorData.Flippable !== newBehaviorData.Flippable)
      this._behaviorData.Flippable = newBehaviorData.Flippable;
    if (oldBehaviorData.Animation !== newBehaviorData.Animation)
      this._behaviorData.Animation = newBehaviorData.Animation;
    if (oldBehaviorData.FlippingMethod !== newBehaviorData.FlippingMethod)
      this._behaviorData.FlippingMethod = newBehaviorData.FlippingMethod;
    if (oldBehaviorData.FrontAnimation !== newBehaviorData.FrontAnimation)
      this._behaviorData.FrontAnimation = newBehaviorData.FrontAnimation;
    if (oldBehaviorData.BackAnimation !== newBehaviorData.BackAnimation)
      this._behaviorData.BackAnimation = newBehaviorData.BackAnimation;
    if (oldBehaviorData.Duration !== newBehaviorData.Duration)
      this._behaviorData.Duration = newBehaviorData.Duration;
    if (oldBehaviorData.IsFlipped !== newBehaviorData.IsFlipped)
      this._behaviorData.IsFlipped = newBehaviorData.IsFlipped;
    if (oldBehaviorData.Width !== newBehaviorData.Width)
      this._behaviorData.Width = newBehaviorData.Width;
    if (oldBehaviorData.ElapsedTime !== newBehaviorData.ElapsedTime)
      this._behaviorData.ElapsedTime = newBehaviorData.ElapsedTime;
    if (oldBehaviorData.Toggle !== newBehaviorData.Toggle)
      this._behaviorData.Toggle = newBehaviorData.Toggle;

    return true;
  }

  // Network sync:
  getNetworkSyncData() {
    return {
      ...super.getNetworkSyncData(),
      props: {
        
    Resizable: this._behaviorData.Resizable,
    Flippable: this._behaviorData.Flippable,
    Animation: this._behaviorData.Animation,
    FlippingMethod: this._behaviorData.FlippingMethod,
    FrontAnimation: this._behaviorData.FrontAnimation,
    BackAnimation: this._behaviorData.BackAnimation,
    Duration: this._behaviorData.Duration,
    IsFlipped: this._behaviorData.IsFlipped,
    Width: this._behaviorData.Width,
    ElapsedTime: this._behaviorData.ElapsedTime,
    Toggle: this._behaviorData.Toggle,
      }
    };
  }
  updateFromNetworkSyncData(networkSyncData) {
    super.updateFromNetworkSyncData(networkSyncData);
    
    if (networkSyncData.props.Resizable !== undefined)
      this._behaviorData.Resizable = networkSyncData.props.Resizable;
    if (networkSyncData.props.Flippable !== undefined)
      this._behaviorData.Flippable = networkSyncData.props.Flippable;
    if (networkSyncData.props.Animation !== undefined)
      this._behaviorData.Animation = networkSyncData.props.Animation;
    if (networkSyncData.props.FlippingMethod !== undefined)
      this._behaviorData.FlippingMethod = networkSyncData.props.FlippingMethod;
    if (networkSyncData.props.FrontAnimation !== undefined)
      this._behaviorData.FrontAnimation = networkSyncData.props.FrontAnimation;
    if (networkSyncData.props.BackAnimation !== undefined)
      this._behaviorData.BackAnimation = networkSyncData.props.BackAnimation;
    if (networkSyncData.props.Duration !== undefined)
      this._behaviorData.Duration = networkSyncData.props.Duration;
    if (networkSyncData.props.IsFlipped !== undefined)
      this._behaviorData.IsFlipped = networkSyncData.props.IsFlipped;
    if (networkSyncData.props.Width !== undefined)
      this._behaviorData.Width = networkSyncData.props.Width;
    if (networkSyncData.props.ElapsedTime !== undefined)
      this._behaviorData.ElapsedTime = networkSyncData.props.ElapsedTime;
    if (networkSyncData.props.Toggle !== undefined)
      this._behaviorData.Toggle = networkSyncData.props.Toggle;
  }

  // Properties:
  
  _getResizable() {
    return this._behaviorData.Resizable !== undefined ? this._behaviorData.Resizable : "";
  }
  _setResizable(newValue) {
    this._behaviorData.Resizable = newValue;
  }
  _getFlippable() {
    return this._behaviorData.Flippable !== undefined ? this._behaviorData.Flippable : "";
  }
  _setFlippable(newValue) {
    this._behaviorData.Flippable = newValue;
  }
  _getAnimation() {
    return this._behaviorData.Animation !== undefined ? this._behaviorData.Animation : "";
  }
  _setAnimation(newValue) {
    this._behaviorData.Animation = newValue;
  }
  _getFlippingMethod() {
    return this._behaviorData.FlippingMethod !== undefined ? this._behaviorData.FlippingMethod : "Mirror";
  }
  _setFlippingMethod(newValue) {
    this._behaviorData.FlippingMethod = newValue;
  }
  _getFrontAnimation() {
    return this._behaviorData.FrontAnimation !== undefined ? this._behaviorData.FrontAnimation : "Front";
  }
  _setFrontAnimation(newValue) {
    this._behaviorData.FrontAnimation = newValue;
  }
  _getBackAnimation() {
    return this._behaviorData.BackAnimation !== undefined ? this._behaviorData.BackAnimation : "Back";
  }
  _setBackAnimation(newValue) {
    this._behaviorData.BackAnimation = newValue;
  }
  _getDuration() {
    return this._behaviorData.Duration !== undefined ? this._behaviorData.Duration : Number("0") || 0;
  }
  _setDuration(newValue) {
    this._behaviorData.Duration = newValue;
  }
  _getIsFlipped() {
    return this._behaviorData.IsFlipped !== undefined ? this._behaviorData.IsFlipped : false;
  }
  _setIsFlipped(newValue) {
    this._behaviorData.IsFlipped = newValue;
  }
  _toggleIsFlipped() {
    this._setIsFlipped(!this._getIsFlipped());
  }
  _getWidth() {
    return this._behaviorData.Width !== undefined ? this._behaviorData.Width : Number("0") || 0;
  }
  _setWidth(newValue) {
    this._behaviorData.Width = newValue;
  }
  _getElapsedTime() {
    return this._behaviorData.ElapsedTime !== undefined ? this._behaviorData.ElapsedTime : Number("0") || 0;
  }
  _setElapsedTime(newValue) {
    this._behaviorData.ElapsedTime = newValue;
  }
  _getToggle() {
    return this._behaviorData.Toggle !== undefined ? this._behaviorData.Toggle : false;
  }
  _setToggle(newValue) {
    this._behaviorData.Toggle = newValue;
  }
  _toggleToggle() {
    this._setToggle(!this._getToggle());
  }
}

/**
 * Shared data generated from 3D Flip
 */
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.SharedData = class ThreeDFlipSharedData {
  constructor(sharedData) {
    
  }
  
  // Shared properties:
  
}

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.getSharedData = function(instanceContainer, behaviorName) {
  if (!instanceContainer._ThreeDFlip_ThreeDFlipSharedData) {
    const initialData = instanceContainer.getInitialSharedDataForBehavior(
      behaviorName
    );
    instanceContainer._ThreeDFlip_ThreeDFlipSharedData = new gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.SharedData(
      initialData
    );
  }
  return instanceContainer._ThreeDFlip_ThreeDFlipSharedData;
}

// Methods:
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects3= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects4= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIsFlipped();
}
if (isConditionTrue_0) {
gdjs.copyArray(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1, gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects3);

{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects3.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects3[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipVisually(true, eventsFunctionContext);
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = !eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIsFlipped();
}
if (isConditionTrue_0) {
gdjs.copyArray(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1, gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2);

{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipVisually(false, eventsFunctionContext);
}
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.eventsList1 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
gdjs.copyArray(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1, gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2);

{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setElapsedTime(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getElapsedTime()+gdjs.evtTools.runtimeScene.getElapsedTimeInSeconds(runtimeScene))
}
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Resizable")).setWidth(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getWidth() * Math.abs(Math.cos(gdjs.evtTools.common.pi() * eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getElapsedTime() / eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getDuration())));
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getElapsedTime() >= eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getDuration() / 2);
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.eventsList0(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getElapsedTime() >= eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getDuration());
}
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1 */
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Resizable")).setWidth(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getWidth());
}
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.eventsList2 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipping(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {

{ //Subevents
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.eventsList1(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEvents = function(parentEventsFunctionContext) {
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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects3.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects4.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.eventsList2(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects3.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.doStepPreEventsContext.GDObjectObjects4.length = 0;


return;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects2= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipSecond(eventsFunctionContext.getArgument("NewDuration") / 1000, eventsFunctionContext);
}
}
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.Flip = function(NewDuration, parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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
if (argName === "NewDuration") return NewDuration;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects3= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{



}


{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setIsFlipped(false)
}
}

}


{

/* Reuse gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1 */

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsVisuallyFlipped(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setIsFlipped(true)
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.eventsList1 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setToggle(false)
}
}

}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2.length;i<l;++i) {
    if ( !(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipped(eventsFunctionContext)) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2.length = k;
if (isConditionTrue_0) {
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setIsFlipped(true)
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setToggle(true)
}
}

}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipped(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = !eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getToggle();
}
}
if (isConditionTrue_0) {
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setIsFlipped(false)
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.eventsList2 = function(runtimeScene, eventsFunctionContext) {

{



}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipping(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setElapsedTime(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getDuration() - eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getElapsedTime() * eventsFunctionContext.getArgument("NewDuration") / eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getDuration())
}
}

}


{



}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length;i<l;++i) {
    if ( !(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipping(eventsFunctionContext)) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1 */
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setWidth((( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length === 0 ) ? 0 :gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1[0].getWidth()))
}
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setElapsedTime(0)
}

{ //Subevents
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.eventsList0(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


{


let isConditionTrue_0 = false;
{
{eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._setDuration(eventsFunctionContext.getArgument("NewDuration"))
}
}

}


{


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.eventsList1(runtimeScene, eventsFunctionContext);
}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecond = function(NewDuration, parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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
if (argName === "NewDuration") return NewDuration;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects3.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.eventsList2(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipSecondContext.GDObjectObjects3.length = 0;


return;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects2= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects3= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = !eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIsFlipped();
}
if (isConditionTrue_0) {
gdjs.copyArray(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1, gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects2);

{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipVisually(false, eventsFunctionContext);
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIsFlipped();
}
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1 */
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipVisually(true, eventsFunctionContext);
}
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.eventsList1 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipping(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1 */
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Resizable")).setWidth(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getWidth());
}
}

{ //Subevents
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.eventsList0(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlip = function(parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects3.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.eventsList1(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.StopFlipContext.GDObjectObjects3.length = 0;


return;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.GDObjectObjects2= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getElapsedTime() < eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getDuration());
}
if (isConditionTrue_0) {
{eventsFunctionContext.returnValue = true;}
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlipping = function(parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippingContext.GDObjectObjects2.length = 0;


return !!eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects2= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipping(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
{isConditionTrue_0 = eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getIsFlipped();
}
}
if (isConditionTrue_0) {
{eventsFunctionContext.returnValue = true;}
}

}


{



}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length;i<l;++i) {
    if ( !(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipping(eventsFunctionContext)) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length = k;
if (isConditionTrue_0) {
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsVisuallyFlipped(eventsFunctionContext) ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length = k;
}
if (isConditionTrue_0) {
{eventsFunctionContext.returnValue = true;}
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlipped = function(parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsFlippedContext.GDObjectObjects2.length = 0;


return !!eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects2= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = !eventsFunctionContext.getArgument("Flip");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipToSecond(false, eventsFunctionContext.getArgument("NewDuration") / 1000, eventsFunctionContext);
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = eventsFunctionContext.getArgument("Flip");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipToSecond(true, eventsFunctionContext.getArgument("NewDuration") / 1000, eventsFunctionContext);
}
}
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipTo = function(Flip, NewDuration, parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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
if (argName === "Flip") return Flip;
if (argName === "NewDuration") return NewDuration;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final = [];

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1.length = 0;


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final.length = 0;
let isConditionTrue_1 = false;
isConditionTrue_0 = false;
{
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2);
{let isConditionTrue_2 = false;
isConditionTrue_2 = false;
{isConditionTrue_2 = !!eventsFunctionContext.getArgument("Flip");
}
if (isConditionTrue_2) {
isConditionTrue_2 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length;i<l;++i) {
    if ( !(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipped(eventsFunctionContext)) ) {
        isConditionTrue_2 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length = k;
}
isConditionTrue_1 = isConditionTrue_2;
}
if(isConditionTrue_1) {
    isConditionTrue_0 = true;
    for (let j = 0, jLen = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length; j < jLen ; ++j) {
        if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final.indexOf(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[j]) === -1 )
            gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final.push(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[j]);
    }
}
}
{
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2);
{let isConditionTrue_2 = false;
isConditionTrue_2 = false;
{isConditionTrue_2 = !eventsFunctionContext.getArgument("Flip");
}
if (isConditionTrue_2) {
isConditionTrue_2 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).IsFlipped(eventsFunctionContext) ) {
        isConditionTrue_2 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length = k;
}
isConditionTrue_1 = isConditionTrue_2;
}
if(isConditionTrue_1) {
    isConditionTrue_0 = true;
    for (let j = 0, jLen = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length; j < jLen ; ++j) {
        if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final.indexOf(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[j]) === -1 )
            gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final.push(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2[j]);
    }
}
}
{
gdjs.copyArray(gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1_1final, gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1);
}
}
if (isConditionTrue_0) {
/* Reuse gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1 */
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Behavior")).FlipSecond(eventsFunctionContext.getArgument("NewDuration"), eventsFunctionContext);
}
}
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecond = function(Flip, NewDuration, parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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
if (argName === "Flip") return Flip;
if (argName === "NewDuration") return NewDuration;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipToSecondContext.GDObjectObjects2.length = 0;


return;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects2= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFlippingMethod() == "Animation");
}
if (isConditionTrue_0) {
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Animation")).getAnimationName() == eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getBackAnimation() ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1.length = k;
}
if (isConditionTrue_0) {
{eventsFunctionContext.returnValue = true;}
}

}


{



}


{

gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1);

let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFlippingMethod() != "Animation");
}
if (isConditionTrue_0) {
isConditionTrue_0 = false;
for (var i = 0, k = 0, l = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1.length;i<l;++i) {
    if ( gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Flippable")).isFlippedX() ) {
        isConditionTrue_0 = true;
        gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1[k] = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1[i];
        ++k;
    }
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1.length = k;
}
if (isConditionTrue_0) {
{eventsFunctionContext.returnValue = true;}
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlipped = function(parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects2.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.eventsList0(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.IsVisuallyFlippedContext.GDObjectObjects2.length = 0;


return !!eventsFunctionContext.returnValue;
}
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext = {};
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2= [];
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects3= [];


gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.eventsList0 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = !eventsFunctionContext.getArgument("Flipped");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Animation")).setAnimationName(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFrontAnimation());
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = eventsFunctionContext.getArgument("Flipped");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Animation")).setAnimationName(eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getBackAnimation());
}
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.eventsList1 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = !eventsFunctionContext.getArgument("Flipped");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Flippable")).flipX(false);
}
}
}

}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = eventsFunctionContext.getArgument("Flipped");
}
if (isConditionTrue_0) {
gdjs.copyArray(eventsFunctionContext.getObjects("Object"), gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1);
{for(var i = 0, len = gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1.length ;i < len;++i) {
    gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1[i].getBehavior(eventsFunctionContext.getBehaviorName("Flippable")).flipX(true);
}
}
}

}


};gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.eventsList2 = function(runtimeScene, eventsFunctionContext) {

{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFlippingMethod() == "Animation");
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.eventsList0(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


{



}


{


let isConditionTrue_0 = false;
isConditionTrue_0 = false;
{isConditionTrue_0 = (eventsFunctionContext.getObjects("Object")[0].getBehavior(eventsFunctionContext.getBehaviorName("Behavior"))._getFlippingMethod() != "Animation");
}
if (isConditionTrue_0) {

{ //Subevents
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.eventsList1(runtimeScene, eventsFunctionContext);} //End of subevents
}

}


};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisually = function(Flipped, parentEventsFunctionContext) {

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
, "Resizable": this._getResizable()
, "Flippable": this._getFlippable()
, "Animation": this._getAnimation()
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("ThreeDFlip"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("ThreeDFlip"),
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
if (argName === "Flipped") return Flipped;
    return "";
  },
  getOnceTriggers: function() { return that._onceTriggers; }
};

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects3.length = 0;

gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.eventsList2(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects1.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects2.length = 0;
gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip.prototype.FlipVisuallyContext.GDObjectObjects3.length = 0;


return;
}


gdjs.registerBehavior("ThreeDFlip::ThreeDFlip", gdjs.evtsExt__ThreeDFlip__ThreeDFlip.ThreeDFlip);
