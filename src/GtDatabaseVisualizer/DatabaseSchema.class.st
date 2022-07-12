Class {
	#name : #DatabaseSchema,
	#superclass : #Object,
	#traits : 'TDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'database',
		'tables'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseSchema >> database [

	^ database
]

{ #category : #accessing }
DatabaseSchema >> database: anObject [

	database := anObject
]

{ #category : #accessing }
DatabaseSchema >> getTables [
	^ self getEntities: {self name}
]

{ #category : #accessing }
DatabaseSchema >> hierarchyChildren [
	self
		flag: 'TODO: only dealing with tables for now. Account for other DB objects/entities like functions later.'.
	^ children ifNil: [ children := self tables ]
]

{ #category : #accessing }
DatabaseSchema >> hierarchyParent [
	^ parent ifNil: [ parent := database ]
]

{ #category : #accessing }
DatabaseSchema >> populateTables [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseSchema >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseSchema >> tables [
	^ tables ifNil: [ tables := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseSchema >> tables: anObject [

	tables := anObject
]
