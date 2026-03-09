
if (typeof gdjs.evtsExt__Card__ExplodeCard !== "undefined") {
  gdjs.evtsExt__Card__ExplodeCard.registeredGdjsCallbacks.forEach(callback =>
    gdjs._unregisterCallback(callback)
  );
}

gdjs.evtsExt__Card__ExplodeCard = {};
gdjs.evtsExt__Card__ExplodeCard.forEachIndex2 = 0;

gdjs.evtsExt__Card__ExplodeCard.forEachObjects2 = [];

gdjs.evtsExt__Card__ExplodeCard.forEachTemporary2 = null;

gdjs.evtsExt__Card__ExplodeCard.forEachTotalCount2 = 0;

gdjs.evtsExt__Card__ExplodeCard.GDCardObjects1= [];
gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2= [];
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects1= [];
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2= [];


gdjs.evtsExt__Card__ExplodeCard.mapOfGDgdjs_9546evtsExt_9595_9595Card_9595_9595ExplodeCard_9546GDStarParticleObjects2Objects = Hashtable.newFrom({"StarParticle": gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2});
gdjs.evtsExt__Card__ExplodeCard.eventsList0 = function(runtimeScene, eventsFunctionContext) {

};gdjs.evtsExt__Card__ExplodeCard.eventsList1 = function(runtimeScene, eventsFunctionContext) {

{

gdjs.copyArray(eventsFunctionContext.getObjects("Card"), gdjs.evtsExt__Card__ExplodeCard.GDCardObjects1);

for (gdjs.evtsExt__Card__ExplodeCard.forEachIndex2 = 0;gdjs.evtsExt__Card__ExplodeCard.forEachIndex2 < gdjs.evtsExt__Card__ExplodeCard.GDCardObjects1.length;++gdjs.evtsExt__Card__ExplodeCard.forEachIndex2) {
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2.length = 0;

gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length = 0;


gdjs.evtsExt__Card__ExplodeCard.forEachTemporary2 = gdjs.evtsExt__Card__ExplodeCard.GDCardObjects1[gdjs.evtsExt__Card__ExplodeCard.forEachIndex2];
gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.push(gdjs.evtsExt__Card__ExplodeCard.forEachTemporary2);
let isConditionTrue_0 = false;
if (true) {
{gdjs.evtTools.object.createObjectOnScene(eventsFunctionContext, gdjs.evtsExt__Card__ExplodeCard.mapOfGDgdjs_9546evtsExt_9595_9595Card_9595_9595ExplodeCard_9546GDStarParticleObjects2Objects, (( gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length === 0 ) ? 0 :gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2[0].getPointX("")), (( gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length === 0 ) ? 0 :gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2[0].getPointY("")), "");
}
{for(var i = 0, len = gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2.length ;i < len;++i) {
    gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2[i].setZOrder(100);
}
}
{gdjs.evtTools.sound.playSound(runtimeScene, "sounds/cuckoo.wav", false, 100, 1);
}
{for(var i = 0, len = gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length ;i < len;++i) {
    gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Tween")).addObjectWidthTween2("VanishWidth", 0, "easeOutExpo", 1, true);
}
}
{for(var i = 0, len = gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length ;i < len;++i) {
    gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2[i].getBehavior(eventsFunctionContext.getBehaviorName("Tween")).addObjectHeightTween2("VanishHeight", 0, "easeOutExpo", 1, true);
}
}
}
}

}


};

gdjs.evtsExt__Card__ExplodeCard.func = function(runtimeScene, Card, Tween, StarParticle, parentEventsFunctionContext) {
let scopeInstanceContainer = null;
var eventsFunctionContext = {
  _objectsMap: {
"Card": Card
, "StarParticle": StarParticle
},
  _objectArraysMap: {
"Card": gdjs.objectsListsToArray(Card)
, "StarParticle": gdjs.objectsListsToArray(StarParticle)
},
  _behaviorNamesMap: {
"Tween": Tween
},
  globalVariablesForExtension: runtimeScene.getGame().getVariablesForExtension("Card"),
  sceneVariablesForExtension: runtimeScene.getScene().getVariablesForExtension("Card"),
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
  getOnceTriggers: function() { return runtimeScene.getOnceTriggers(); }
};

gdjs.evtsExt__Card__ExplodeCard.GDCardObjects1.length = 0;
gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length = 0;
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects1.length = 0;
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2.length = 0;

gdjs.evtsExt__Card__ExplodeCard.eventsList1(runtimeScene, eventsFunctionContext);
gdjs.evtsExt__Card__ExplodeCard.GDCardObjects1.length = 0;
gdjs.evtsExt__Card__ExplodeCard.GDCardObjects2.length = 0;
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects1.length = 0;
gdjs.evtsExt__Card__ExplodeCard.GDStarParticleObjects2.length = 0;


return;
}

gdjs.evtsExt__Card__ExplodeCard.registeredGdjsCallbacks = [];