Class {
	#name : #DatabaseTable,
	#superclass : #Object,
	#traits : 'TDatabaseEntity + TObjectHierarchy',
	#classTraits : 'TDatabaseEntity classTrait + TObjectHierarchy classTrait',
	#instVars : [
		'columns',
		'schema'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
DatabaseTable >> columns [
	^ columns ifNil: [ columns := OrderedCollection new ]
]

{ #category : #accessing }
DatabaseTable >> columns: anObject [

	columns := anObject
]

{ #category : #accessing }
DatabaseTable >> getColumns [
	^ self getEntities
]

{ #category : #accessing }
DatabaseTable >> hierarchyChildren [
	^ children ifNil: [ children := self columns ]
]

{ #category : #accessing }
DatabaseTable >> hierarchyParent [
	^ parent ifNil: [ parent := schema ]
]

{ #category : #accessing }
DatabaseTable >> populateColumns [
	self subclassResponsibility
]

{ #category : #accessing }
DatabaseTable >> printOn: aStream [
	aStream nextPutAll: self class name , '(' , name , ')'
]

{ #category : #accessing }
DatabaseTable >> schema [

	^ schema
]

{ #category : #accessing }
DatabaseTable >> schema: anObject [

	schema := anObject
]
