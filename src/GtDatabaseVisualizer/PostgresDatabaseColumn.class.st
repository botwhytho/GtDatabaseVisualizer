Class {
	#name : #PostgresDatabaseColumn,
	#superclass : #DatabaseColumn,
	#category : #GtDatabaseVisualizer
}

{ #category : #accessing }
PostgresDatabaseColumn class >> columnAttributeClass [
	^ PostgresDatabaseColumnAttribute
]
