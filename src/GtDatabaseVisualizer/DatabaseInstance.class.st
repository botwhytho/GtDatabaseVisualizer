Class {
	#name : #DatabaseInstance,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'server',
		'schemas'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseInstance >> getSchemas [
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseInstance >> hierarchyChildren [
	^ children ifNil: [ children := self schemas ]
]

{ #category : #accessing }
DatabaseInstance >> hierarchyParent [
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
