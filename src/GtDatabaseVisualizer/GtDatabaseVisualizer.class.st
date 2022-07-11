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
GtDatabaseVisualizer >> children [
	^ children ifNil: [ children := self servers ]
]

{ #category : #accessing }
GtDatabaseVisualizer >> initialize [
	super initialize.
	parent := self
]

{ #category : #accessing }
GtDatabaseVisualizer >> parent [
	^ parent ifNil: [ parent := self ]
]

{ #category : #accessing }
GtDatabaseVisualizer >> servers [
	^ servers ifNil: [ servers := OrderedCollection new ]
]

{ #category : #accessing }
GtDatabaseVisualizer >> servers: anObject [

	servers := anObject
]
