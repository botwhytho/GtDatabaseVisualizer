Class {
	#name : #GtDatabaseVisualizer,
	#superclass : #Object,
	#traits : 'TGtUniqueInstance + TObjectHierarchy',
	#classTraits : 'TGtUniqueInstance classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'servers'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
GtDatabaseVisualizer class >> gtDatabasesFor: aView [
	<gtClassView>
	| root |
	root := self uniqueInstance.
	(root children isNil or: [ root children isEmpty ]) ifTrue: [ ^ aView empty ].
	^ aView forward
		title: 'Databases';
		priority: 1;
		object: [ self uniqueInstance ];
		view: #gtHierarchyFor:
]

{ #category : #accessing }
GtDatabaseVisualizer >> hierarchyChildren [
	^ children ifNil: [ children := self servers ]
]

{ #category : #accessing }
GtDatabaseVisualizer >> servers [
	^ servers ifNil: [ servers := OrderedCollection new ]
]

{ #category : #accessing }
GtDatabaseVisualizer >> servers: anObject [

	servers := anObject
]
