Class {
	#name : #DatabaseServer,
	#superclass : #Object,
	#traits : 'TGtDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TGtDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'databases'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseServer >> databases [
	^ databases ifNil: [ databases := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseServer >> databases: anObject [

	databases := anObject
]

{ #category : #accessing }
DatabaseServer >> getDatabases [
	^ self getEntitiesWithArgs: nil
]

{ #category : #accessing }
DatabaseServer >> hierarchyChildren [
	^ children ifNil: [ children := self databases ]
]

{ #category : #accessing }
DatabaseServer >> hierarchyParent [
	^ parent ifNil: [ parent := GtDatabaseVisualizer uniqueInstance ]
]

{ #category : #initialization }
DatabaseServer >> initialize [
	super initialize.
	GtDatabaseVisualizer uniqueInstance servers add: self
]

{ #category : #initialization }
DatabaseServer >> populateDatabases [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseServer >> printOn: aStream [
	aStream nextPutAll: client asString
]
