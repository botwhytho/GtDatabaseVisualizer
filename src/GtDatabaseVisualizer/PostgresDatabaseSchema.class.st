Class {
	#name : #PostgresDatabaseSchema,
	#superclass : #DatabaseSchema,
	#instVars : [
		'allColumns',
		'allForeignKeys'
	],
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseSchema class >> tableClass [
	^ PostgresDatabaseTable
]

{ #category : #accessing }
PostgresDatabaseSchema >> allIndexes [
]
