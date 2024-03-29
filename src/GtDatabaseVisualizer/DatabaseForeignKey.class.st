Class {
	#name : #DatabaseForeignKey,
	#superclass : #DatabaseColumnAttribute,
	#instVars : [
		'table',
		'foreignTable',
		'foreignColumn'
	],
	#category : #'GtDatabaseVisualizer-GtDatabaseVisualizer'
}

{ #category : #accessing }
DatabaseForeignKey >> foreignColumn [

	^ foreignColumn
]

{ #category : #accessing }
DatabaseForeignKey >> foreignColumn: anObject [

	foreignColumn := anObject
]

{ #category : #accessing }
DatabaseForeignKey >> foreignTable [

	^ foreignTable
]

{ #category : #accessing }
DatabaseForeignKey >> foreignTable: anObject [

	foreignTable := anObject
]

{ #category : #accessing }
DatabaseForeignKey >> gtForeignKeyRelationFor: aView [
	<gtView>
	^ (self
		gtTableRelationsForHelper: aView
		withTables: {self table . self foreignTable})
		title: 'Relationship';
		priority: 1
]

{ #category : #accessing }
DatabaseForeignKey >> table [

	^ table
]

{ #category : #accessing }
DatabaseForeignKey >> table: anObject [

	table := anObject
]
