Class {
	#name : #DatabaseInstance,
	#superclass : #Object,
	#traits : 'TDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'server',
		'schemas'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseInstance >> children [
	^ children ifNil: [ children := self schemas ]
]

{ #category : #accessing }
DatabaseInstance >> getSchemas [
	^ self getEntities
]

{ #category : #accessing }
DatabaseInstance >> parent [
	^ parent ifNil: [ parent := server ]
]

{ #category : #accessing }
DatabaseInstance >> populateSchemas [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseInstance >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseInstance >> schemas [
	^ schemas ifNil: [ schemas := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseInstance >> schemas: anObject [

	schemas := anObject
]

{ #category : #accessing }
DatabaseInstance >> server [

	^ server
]

{ #category : #accessing }
DatabaseInstance >> server: anObject [

	server := anObject
]
